import 'package:fluneumora/all.dart';

class TransactionModel extends ParseObject implements ParseCloneable {
  TransactionModel() : super(tableName);
  TransactionModel.clone() : this();

  @override
  TransactionModel clone(Map<String, dynamic> map) =>
      TransactionModel.clone()..fromJson(map);

  static const String tableName = "PolygonNFTTransfers";

  static const String tokenIdColumn = "token_id";
  static const String blockHashColumn = "block_hash";
  static const String blockTimestampColumn = "block_timestamp";
  static const String contractTypeColumn = "contract_type";
  static const String tokenAddressColumn = "token_address";
  static const String transactionHashColumn = "transaction_hash";
  static const String toAddressColumn = "to_address";
  static const String transactionIndexColumn = "transaction_index";
  static const String logIndexColumn = "log_index";
  static const String amountColumn = "amount";
  static const String blockNumberColumn = "block_number";
  static const String fromAddressColumn = "from_address";
  static const String confirmedColumn = "confirmed";
  static const String fromUserColumn = "from_user";
  static const String toUserColumn = "to_user";
  static const String tokenColumn = "token";

  String get tokenId => get<String>(tokenIdColumn)!;
  String get blockHash => get<String>(blockHashColumn)!;
  String get blockTimestamp => get<String>(blockTimestampColumn)!;
  String get contractType => get<String>(contractTypeColumn)!;
  String get tokenAddress => get<String>(tokenAddressColumn)!;
  String get transactionHash => get<String>(transactionHashColumn)!;
  String get toAddress => get<String>(toAddressColumn)!;
  int get transactionIndex => get<int>(transactionIndexColumn)!;
  int get logIndex => get<int>(logIndexColumn)!;
  String get amount => get<String>(amountColumn)!;
  int get blockNumber => get<int>(blockNumberColumn)!;
  String get fromAddress => get<String>(fromAddressColumn)!;
  bool get confirmed => get<bool>(confirmedColumn)!;
  UserModel? get fromUser => get<UserModel>(fromUserColumn);
  UserModel? get toUser => get<UserModel>(toUserColumn);
  TokenDetailsModel? get token => get<TokenDetailsModel>(tokenColumn);
}
