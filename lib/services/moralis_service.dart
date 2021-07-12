import 'package:fluneumora/all.dart';

class MoralisService {
  late Future<Parse> _client;

  String emptyEmail = "empty@email.com";

  MoralisService() {
    _client = Parse().initialize(
      Config.applicationId,
      Config.moralisServerUrl,
      masterKey: Config.masterKey,
      appName: Config.appName,
      appVersion: Config.appVersion,
      appPackageName: Config.appPackageName,
      registeredSubClassMap: <String, ParseObjectConstructor>{
        TransactionModel.tableName: () => TransactionModel(),
      },
      parseUserConstructor: (
        username,
        password,
        emailAddress, {
        client,
        debug,
        sessionToken,
      }) =>
          UserModel(username, password),
    );
  }

  Future<List<UserModel>?> getAllUsers() async {
    await _client;

    final response = await ParseUser.all();

    if (response.success) {
      return response.results!
          .map<UserModel>((user) => user as UserModel)
          .toList();
    } else {
      return null;
    }
  }

  Future<List<UserModel>?> getTokenOwners({
    required String tokenId,
  }) async {
    final builder = QueryBuilder(UserModel.clone())
      ..whereArrayContainsAll(
        UserModel.tokensColumn,
        [tokenId],
      );

    final response = await builder.query();

    if (response.success) {
      if (response.results is List && response.results!.length > 0) {
        return response.results!.cast<UserModel>().toList();
      }
    } else {
      log(response.error);
    }

    return null;
  }

  Future<ParseUser?> updateAvatar({
    required String objectId,
    ParseFileBase? avatar,
  }) async {
    await _client;

    final updatedUser = UserModel(
      null,
      null,
    )
      ..objectId = objectId
      ..avatar = avatar;

    final response = await updatedUser.save();

    if (response.success) {
      return updatedUser;
    }

    return null;
  }

  Future<ParseUser?> updateName({
    required String objectId,
    required String newName,
  }) async {
    await _client;

    final updatedUser = UserModel(
      null,
      null,
    )
      ..objectId = objectId
      ..fullname = newName;

    final response = await updatedUser.save();

    if (response.success) {
      return updatedUser;
    } else {
      log(response.error);
      return null;
    }
  }

  Future<UserModel?> authorize({
    required address,
    required password,
  }) async {
    await _client;

    var defaultFullname = "account${address.substring(1, 5)}";

    final user = UserModel(address, password)..fullname = defaultFullname;

    final registerResponse = await user.signUp(
      allowWithoutEmail: true,
    );

    if (registerResponse.results is List) {
      return registerResponse.results!.first as UserModel;
    } else {
      final loginResponse = await user.login();

      if (loginResponse.results is List) {
        return loginResponse.results!.first as UserModel;
      } else {
        log(registerResponse.error);
        log(loginResponse.error);
      }
    }

    return null;
  }

  Future<DepositModel> getDeposit(
      {String? depositSecret, String? transactionHash}) async {
    await _client;

    final queryBuilder = QueryBuilder(DepositModel())..setLimit(1);

    if (depositSecret != null) {
      queryBuilder.whereEqualTo(DepositModel.secretColumn, depositSecret);
    }

    if (transactionHash != null) {
      queryBuilder.whereEqualTo(
          DepositModel.transactionHashColumn, transactionHash);
    }

    DepositModel? result;

    while (result == null) {
      ParseResponse response = await queryBuilder.query();

      if (response.success) {
        if (response.results is List && response.results!.length > 0) {
          result = response.results!.first as DepositModel;
        } else {
          log("getDeposit: empty result");
        }
      } else {
        log(response.error);
      }
    }

    return result;
  }

  Stream<TransactionModel?> getTransaction({
    required String transactionHash,
  }) async* {
    await _client;

    final queryBuilder = QueryBuilder(TransactionModel())
      ..whereEqualTo(
        TransactionModel.transactionHashColumn,
        transactionHash,
      )
      ..setLimit(1);

    while (true) {
      final response = await queryBuilder.query();

      if (response.success) {
        if (response.results != null && response.results!.isNotEmpty) {
          yield response.results!.first as TransactionModel;
        }
      }

      yield null;
    }
  }

  Future<List<TokenDetailsModel>?> getTokens({
    List<String>? userEnabledTokens,
  }) async {
    await _client;

    final tokenDetails = TokenDetailsModel();

    final queryBuilder = QueryBuilder<TokenDetailsModel>(tokenDetails);

    if (userEnabledTokens != null) {
      queryBuilder.whereContainedIn(
          "token_id", userEnabledTokens.cast<String>().toList());
    }

    queryBuilder.orderByDescending("token_id");

    final response = await queryBuilder.query();

    if (response.success && response.results is List) {
      final results = response.results! // check null empty results
          .where(
            (element) => element.tokenId.isNotEmpty,
          )
          .toList();

      if (results.isNotEmpty) {
        final uniqueIds = results.map((e) => e.tokenId).toSet();
        results.retainWhere((x) => uniqueIds.remove(x.tokenId));

        return results.cast<TokenDetailsModel>();
      }
    } else {
      log(response.error);
    }

    return null;
  }

  Future<TokenDetailsModel?> getNewTokenDetails({required address}) async {
    await _client;

    final tokenDetails = TokenDetailsModel();

    final queryBuilder = QueryBuilder<TokenDetailsModel>(tokenDetails)
      ..whereEqualTo("is_new", true)
      ..whereEqualTo("creator_address", address.toLowerCase())
      ..orderByDescending("createdAt");

    final response = await queryBuilder.query();

    if (response.success && response.results is List) {
      return response.results!.first as TokenDetailsModel;
    }

    return null;
  }

  Future<TokenDetailsModel?> createTokenDetails({
    required String hash,
    required String tokenName,
    required String tokenSupply,
  }) async {
    await _client;

    final tokenDetails = TokenDetailsModel()
      ..tokenName = tokenName
      ..tokenSupply = tokenSupply
      ..hash = hash;

    final response = await tokenDetails.save();

    if (response.success) {
      return tokenDetails;
    } else {
      log(response.error);
      return null;
    }
  }

  // Future<TokenDetailsModel?> updateTokenDetails({
  //   required String objectId,
  //   required String tokenName,
  // }) async {
  //   await _client;

  //   final responseGet = await TokenDetailsModel().getObject(objectId);

  //   if (responseGet.success && responseGet.results is List) {
  //     final tokenDetails = responseGet.results!.first as TokenDetailsModel;

  //     tokenDetails.tokenName = tokenName;
  //     tokenDetails.isNew = false;

  //     final responseSave = await tokenDetails.save();

  //     if (responseSave.success) {
  //       return tokenDetails;
  //     }
  //   }
  // }

  Future<List<TransactionModel>?> getTransactions({
    required String address,
    String? tokenId,
  }) async {
    await _client;

    final keyClassToken = "TokenDetails";

    final model = TransactionModel();

    final builder = QueryBuilder<TransactionModel>.or(
      model,
      [
        QueryBuilder<TransactionModel>(model)
          ..whereEqualTo('from_address', address.toLowerCase()),
        QueryBuilder<TransactionModel>(model)
          ..whereEqualTo('to_address', address.toLowerCase()),
      ],
    )
      ..orderByDescending("createdAt")
      ..includeObject([keyClassUser, keyClassToken]);

    if (tokenId != null) {
      builder.whereEqualTo("token_id", tokenId.toString());
    }

    final response = await builder.query();

    if (response.success) {
      if (response.results is List) {
        return response.results!
            .map<TransactionModel>((r) => r as TransactionModel)
            .toList();
      }
    }

    return null;
  }
}
