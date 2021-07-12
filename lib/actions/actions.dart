import 'package:fluneumora/all.dart';

class LoadTokensAction extends Action<AppState> {
  Stream<Updater<AppState>> call(Context<AppState> context) async* {
    final actualUser = await context.state.user.fetch() as UserModel;

    final tokens = await context.services.create<MoralisService>().getTokens(
          userEnabledTokens: actualUser.tokens.cast<String>(),
        );

    if (tokens != null) {
      yield (state) => state.update(tokens: tokens);

      await context.dispatch(
        ChangeCurrentTokenAction(tokenId: tokens.first.tokenId),
      );
    }
  }
}

class ChangeCurrentTokenAction extends Action<AppState> {
  final String tokenId;

  ChangeCurrentTokenAction({required this.tokenId});

  Stream<Updater<AppState>> call(Context<AppState> context) async* {
    yield (state) => state.update(
          walletTokenId: tokenId,
        );

    await Future.wait([
      context.dispatch(
        LoadTokenBalance(tokenId: tokenId),
      ),
      context.dispatch(
        LoadTokenTransactions(tokenId: tokenId),
      ),
      context.dispatch(
        LoadTokenOwnersAction(tokenId: tokenId),
      ),
    ]);
  }

  // String toString() {
  //   return "${super.toString()}($tokenId)";
  // }
}

class RefreshCurrentTokenAction extends Action<AppState> {
  Stream<Updater<AppState>> call(Context<AppState> context) async* {
    final currentTokenId = context.state.walletTokenId;

    await Future.wait([
      context.dispatch(
        LoadTokenBalance(tokenId: currentTokenId),
      ),
      context.dispatch(
        LoadTokenTransactions(tokenId: currentTokenId),
      ),
    ]);
  }
}

class LoadTokenBalance extends Action<AppState> {
  final String tokenId;

  LoadTokenBalance({required this.tokenId});

  Stream<Updater<AppState>> call(Context<AppState> context) async* {
    final balance = await context.services.create<WalletService>().getBalance(
          userAddress: context.state.userAddress,
          tokenId: tokenId,
        );

    if (balance != null)
      yield (state) => state.update(
            balances: <String, int>{}
              ..addAll(state.balances)
              ..update(
                tokenId,
                (_) => balance,
                ifAbsent: () => balance,
              ),
          );
  }
}

class LoadTokenTransactions extends Action<AppState> {
  final String tokenId;

  LoadTokenTransactions({required this.tokenId});

  Stream<Updater<AppState>> call(Context<AppState> context) async* {
    final transactions =
        await context.services.create<MoralisService>().getTransactions(
              address: context.state.userAddress,
              tokenId: tokenId,
            );

    if (transactions != null)
      yield (state) => state.update(
            transactions: <String, List<TransactionModel>?>{}
              ..addAll(
                state.transactions,
              )
              ..update(
                tokenId,
                (_) => transactions,
                ifAbsent: () => transactions,
              ),
          );
  }
}

class LoadTokenOwnersAction extends Action<AppState> {
  final String tokenId;

  LoadTokenOwnersAction({required this.tokenId});

  Stream<Updater<AppState>> call(Context<AppState> context) async* {
    final users = await context.services
        .create<MoralisService>()
        .getTokenOwners(tokenId: tokenId);

    if (users != null) {
      users.add(UserModel.clone()
        ..fullname = "Donation Account"
        ..address = "0xd718980eda24e009f30c479792da8056cf507df9");

      yield (state) => state.update(
            owners: Map<String, List<UserModel>>.from(state.owners)
              ..update(
                tokenId,
                (_) => users,
                ifAbsent: () => users,
              ),
          );
    }
  }
}

// class LoadContactsAction extends Action<AppState> {
//   Stream<Updater<AppState>> call(Context<AppState> context) async* {
//     final users = await context.services.create<MoralisService>().getAllUsers();

//     if (users != null) {
//       final defaultContacts = users.where((item) => item.fullname
//           .isNotEmpty); // todo: show only users who are having the same tokens as current user

//       if (defaultContacts.isNotEmpty) {
//         yield (state) => state.update(
//               contacts: [
//                 ...defaultContacts,
//                 ...state.contacts,
//               ].toSet().toList(),
//             );
//       }
//     }
//   }
// }

class AddNewContact extends Action<AppState> {
  final String address;
  final String fullname;

  AddNewContact({
    required this.address,
    required this.fullname,
  });

  Stream<Updater<AppState>> call(Context<AppState> context) async* {
    final newContact = UserModel(
      address,
      null,
    )..fullname = fullname;

    yield (state) => state.update(contacts: [...state.contacts, newContact]);
  }
}

class UpdateUserAvatarAction extends Action<AppState> {
  final ParseFileBase? avatar;

  UpdateUserAvatarAction({
    required this.avatar,
  });

  Stream<Updater<AppState>> call(Context<AppState> context) async* {
    final updatedUser =
        await context.services.create<MoralisService>().updateAvatar(
              objectId: context.state.user.objectId!,
              avatar: avatar,
            );

    if (updatedUser != null) {
      yield (state) => state.update(user: updatedUser);
    }
  }
}

class UpdateUserNameAction extends Action<AppState> {
  final String newName;

  UpdateUserNameAction(this.newName);

  Stream<Updater<AppState>> call(Context<AppState> context) async* {
    final updatedUser =
        await context.services.create<MoralisService>().updateName(
              objectId: context.state.user.objectId!,
              newName: newName,
            );

    if (updatedUser != null) {
      yield (state) => state.update(
            user: updatedUser,
          );
    }
  }
}

class AuthorizeAction extends Action<AppState> {
  final String mnemonic;
  final String pincode = "7777";

  AuthorizeAction({required this.mnemonic});

  Stream<Updater<AppState>> call(Context<AppState> context) async* {
    final privateKey = (await context.services
            .create<WalletService>()
            .privateKeyFromMnemonic(mnemonic))
        .toString();

    final userAddress =
        (await EthPrivateKey.fromHex(privateKey).extractAddress())
            .toString()
            .toLowerCase();

    yield (state) => state.update(
          userAddress: userAddress,
          userPrivateKey: privateKey,
        );

    final UserModel? user =
        await context.services.create<MoralisService>().authorize(
              address: userAddress,
              password: pincode,
            );

    if (user != null) {
      yield (state) => state.update(
            user: user,
          );

      context.dispatch(LoadTokensAction());
    }
  }
}

class CreateTokenAction extends Action<AppState> {
  final String tokenName;
  final String tokenSupply;

  CreateTokenAction({
    required this.tokenName,
    required this.tokenSupply,
  });

  Stream<Updater<AppState>> call(Context<AppState> context) async* {
    yield (state) => state.update(
          currentTransaction: TransactionState.initial(),
        );

    while (context.state.userPrivateKey == "") {
      await sleep(Duration(seconds: 1));
    }

    final walletService = context.services.create<WalletService>();

    final moralisService = context.services.create<MoralisService>();

    var initialTokenDetails = TokenDetailsModel.clone()
      ..tokenName = tokenName
      ..tokenSupply = tokenSupply;

    yield (state) => state.update(
          currentTransaction: TransactionState.initial().update(
            tokenDetails: initialTokenDetails,
            recipientUser: context.state.user,
          ),
        );

    // transactionStep: TransactionStep.initial,
    // transactionHash: "",
    // transactionUserTo: context.state.user,
    // transactionTokenDetails: initialTokenDetails);

    final gasTransactionHash = await walletService.transferMatic(
      privateKey: Config.gasPrivateKey,
      recipient: context.state.userAddress,
      value: Config.createMaticValue,
    );

    yield (state) => state.update(
          currentTransaction: state.currentTransaction.update(
            transactionStep: TransactionStep.filledgas,
            gasTransactionHash: gasTransactionHash,
          ),
        );

    StreamQueue<String> transactionHash = StreamQueue<String>(
      walletService.createToken(
        privateKey: context.state.userPrivateKey,
        tokenName: tokenName,
        tokenSupply: tokenSupply,
      ),
    );

    final transactionHashExpected = await transactionHash.next;

    TokenDetailsModel? tokenDetails = await moralisService.createTokenDetails(
      hash: transactionHashExpected,
      tokenName: tokenName,
      tokenSupply: tokenSupply,
    );

    if (tokenDetails != null) {
      yield (state) => state.update(
            currentTransaction: state.currentTransaction.update(
              transactionHash: tokenDetails.hash,
              transactionStep: TransactionStep.signed,
              tokenDetails: tokenDetails,
              transactionTitle:
                  "create token ${tokenDetails.tokenName} with supply of ${tokenDetails.tokenSupply}",
            ),
          );

      await sleep(Duration(milliseconds: 250));

      final transactionHashBroadcasted = await transactionHash.next;

      yield (state) => state.update(
            currentTransaction: state.currentTransaction.update(
              transactionHash: transactionHashBroadcasted,
              transactionStep: TransactionStep.broadcasted,
            ),
          );

      // await sleep(Duration(seconds: 1));

      while (tokenDetails.tokenId.isEmpty) {
        await sleep(Duration(seconds: 1));
        await tokenDetails.fetch();
      }

      context.dispatch(
        LoadTokensAction(),
      );

      await sleep(Duration(seconds: 1));

      yield (state) => state.update(
            walletTokenId: tokenDetails.tokenId,
            currentTransaction: state.currentTransaction.update(
              transactionStep: TransactionStep.confirmed,
              resultTitle: "Created token ${tokenDetails.tokenId}",
              resultValue: "Transaction mined successfully",
            ),
          );

      // await for (var transaction in moralisService.getTransaction(
      //   transactionHash: transactionHashBroadcasted,
      // )) {
      //   if (transaction != null) {
      //     if (transaction.confirmed) {
      //       yield (state) => state.update(
      //             walletTokenId: transaction.tokenId,
      //             currentTransaction: state.currentTransaction.update(
      //               transactionStep: TransactionStep.confirmed,
      //               resultTitle: "Success!",
      //               resultValue: "Transaction mined successfully",
      //             ),
      //           );
      //       break;
      //     } else {
      //       yield (state) => state.update(
      //             walletTokenId: transaction.tokenId,
      //           );
      //     }
      //   }

      //   await sleep(Duration(seconds: 2));
      // }
    } else {
      log("ERROR - could not create token details");
    }
  }
}

class ReceiveDepositAction extends Action<AppState> {
  final String secret;

  ReceiveDepositAction({required this.secret});

  Stream<Updater<AppState>> call(Context<AppState> context) async* {
    yield (state) => state.update(
          depositSecret: secret,
        );
  }
}

class MaybeAcceptDepositAction extends Action<AppState> {
  Stream<Updater<AppState>> call(Context<AppState> context) async* {
    if (context.state.depositSecret != "") {
      final depositSecret = context.state.depositSecret;

      yield (state) => state.update(depositSecret: "");

      final moralisService = context.services.create<MoralisService>();

      final deposit = await moralisService.getDeposit(
        depositSecret: depositSecret,
      );

      context.dispatch(
        TransferAction(
          recipient: context.state.userAddress,
          amount: deposit.amount,
          tokenId: deposit.tokenId,
          privateKey: Config.depositPrivateKey,
        ),
      );
    }
  }
}

class TransferDepositAction extends Action<AppState> {
  final String amount;
  final String tokenId;

  TransferDepositAction({
    required this.amount,
    required this.tokenId,
  });

  Stream<Updater<AppState>> call(Context<AppState> context) async* {
    final walletService = context.services.create<WalletService>();
    final moralisService = context.services.create<MoralisService>();

    yield (state) => state.update(
          currentTransaction: TransactionState.initial(),
        );

    final gasTransactionHash = await walletService.transferMatic(
      privateKey: Config.gasPrivateKey,
      recipient: context.state.userAddress,
      value: Config.transferMaticValue,
    );

    yield (state) => state.update(
          currentTransaction: state.currentTransaction.update(
            transactionStep: TransactionStep.filledgas,
            gasTransactionHash: gasTransactionHash,
          ),
        );

    Stream<String> depositTransaction = walletService
        .transfer(
          privateKey: context.state.userPrivateKey,
          recipient: Config.depositAddress,
          tokenId: tokenId,
          tokenQuantity: amount,
        )
        .take(2);

    String? transactionHash;
    await for (var hash in depositTransaction) {
      if (transactionHash == null) {
        transactionHash = hash;

        yield (state) => state.update(
                currentTransaction: state.currentTransaction.update(
              transactionHash: transactionHash,
              transactionStep: TransactionStep.signed,
            ));
      } else {
        yield (state) => state.update(
              currentTransaction: state.currentTransaction.update(
                transactionStep: TransactionStep.broadcasted,
              ),
            );
        break;
      }
    }

    final deposit = await moralisService.getDeposit(
      transactionHash: transactionHash,
    );

    yield (state) => state.update(
          currentTransaction: state.currentTransaction.update(
              transactionStep: TransactionStep.confirmed,
              resultTitle: "secret key to claim deposit",
              resultValue: deposit.secret),
        );
  }
}

// class AcceptDepositAction extends Action<AppState> {
//   final String depositSecret;

//   AcceptDepositAction({
//     required this.depositSecret,
//   });

//   Stream<Updater<AppState>> call(Context<AppState> context) async* {
//     yield (state) => state.update(transactionStep: TransactionStep.initial);

//     final walletService = context.services.create<WalletService>();

//     final moralisService = context.services.create<MoralisService>();

//     await walletService.transferMatic(
//       privateKey: Config.gasPrivateKey,
//       recipient: Config.depositAddress,
//       value: Config.transferMaticValue,
//     );

//     yield (state) => state.update(transactionStep: TransactionStep.filledgas);

//     final deposit =
//         await moralisService.getDeposit(depositSecret: depositSecret);

//     yield (state) => state.update(
//         transactionStep: TransactionStep.signed, transactionDeposit: deposit);

//     StreamQueue<String> acceptTransaction = StreamQueue<String>(
//       walletService.transfer(
//         privateKey: Config.depositPrivateKey,
//         recipient: context.state.userAddress,
//         tokenId: deposit.tokenId,
//         tokenQuantity: deposit.amount,
//       ),
//     );

//     final expectedHash = await acceptTransaction.next;

//     yield (state) => state.update(
//           transactionStep: TransactionStep.broadcasted,
//           transactionHash: expectedHash,
//         );

//     final transactionHash = await acceptTransaction.next;

//     yield (state) => state.update(
//           transactionStep: TransactionStep.confirmed,
//           transactionHash: transactionHash,
//         );

//     // await for (var transaction
//     //     in moralisService.getTransaction(transactionHash: transactionHash)) {
//     //   if (transaction != null && transaction.confirmed == true) {
//     //     break;
//     //   }
//     //   await sleep(Duration(seconds: 2));
//     // }

//     // yield (state) => state.update(transactionStep: TransactionStep.confirmed);
//   }
// }

class TransferAction extends Action<AppState> {
  final String recipient;
  final String amount;
  final String tokenId;
  final String? privateKey;

  TransferAction(
      {required this.recipient,
      required this.amount,
      required this.tokenId,
      this.privateKey});

  Stream<Updater<AppState>> call(Context<AppState> context) async* {
    yield (state) => state.update(
          currentTransaction: TransactionState.initial(),
        );

    while (
        context.state.userPrivateKey == "" || context.state.userAddress == "") {
      await sleep(Duration(seconds: 1));
    }

    final walletService = context.services.create<WalletService>();

    String? gasTransactionHash;
    try {
      gasTransactionHash = await walletService.transferMatic(
        privateKey: Config.gasPrivateKey,
        recipient: context.state.userAddress,
        value: Config.transferMaticValue,
      );
    } catch (err) {
      log(err);
      throw err;
    }

    yield (state) => state.update(
          currentTransaction: state.currentTransaction.update(
            transactionStep: TransactionStep.filledgas,
            gasTransactionHash: gasTransactionHash,
          ),
        );

    // await Future.microtask(() => null);
    // await sleep(Duration(milliseconds: 250));

    int previousBalance = context.state.balances[tokenId]!;

    final transferTransaction = StreamQueue<String>(
      walletService.transfer(
        privateKey: privateKey ?? context.state.userPrivateKey,
        recipient: recipient,
        tokenId: tokenId,
        tokenQuantity: amount,
      ),
    );

    final txPredicted = await transferTransaction.next;

    yield (state) => state.update(
          currentTransaction: state.currentTransaction.update(
            transactionStep: TransactionStep.signed,
            transactionHash: txPredicted,
          ),
        );

    final transactionHash = await transferTransaction.next;

    // String? transactionHash;

    // while (transactionHash == null) {
    //   try {
    //     transactionHash = await
    //   } catch (err) {
    //     log(err);
    //     await sleep(Duration(seconds: 1));
    //   }
    // }

    yield (state) => state.update(
          currentTransaction: state.currentTransaction.update(
              transactionStep: TransactionStep.broadcasted,
              transactionHash: transactionHash,
              transactionTitle: "transfer token to recipient"),
        );

    await sleep(Duration(milliseconds: 250));

    bool isBalanceChanged = false;
    int newBalance = 0;
    while (isBalanceChanged == false) {
      await context.dispatch(
        LoadTokenBalance(tokenId: tokenId),
      );

      newBalance = await walletService.getBalance(
        userAddress: context.state.userAddress,
        tokenId: tokenId,
      );

      if (newBalance != previousBalance) {
        isBalanceChanged = true;
      } else {
        await sleep(Duration(seconds: 1));
      }
    }

    context.dispatch(
      LoadTokensAction(),
    );

    yield (state) => state.update(
          currentTransaction: state.currentTransaction.update(
              transactionStep: TransactionStep.confirmed,
              resultTitle: "Success!",
              resultValue: "Token transferred to recipient $recipient"),
        );
  }
}
