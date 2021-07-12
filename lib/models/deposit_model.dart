import 'package:fluneumora/all.dart';

class DepositModel extends ParseObject implements ParseCloneable {
  DepositModel() : super(tableName);
  DepositModel.clone() : this();

  @override
  DepositModel clone(Map<String, dynamic> map) =>
      DepositModel.clone()..fromJson(map);

  static const String tableName = "TransferDeposits";

  static const String transactionHashColumn = "transaction_hash";
  static const String tokenIdColumn = "token_id";
  static const String amountColumn = "amount";
  static const String senderColumn = "sender";
  static const String receiverColumn = "receiver";
  static const String secretColumn = "secret";

  String get transactionHash => get<String>(transactionHashColumn)!;
  set transactionHash(String value) =>
      set<String>(transactionHashColumn, value);

  String get tokenId => get<String>(tokenIdColumn)!;
  set tokenId(String value) => set<String>(tokenIdColumn, value);

  String get amount => get<String>(amountColumn)!;
  set amount(String value) => set<String>(amountColumn, value);

  String get sender => get<String>(senderColumn)!;
  set sender(String value) => set<String>(senderColumn, value);

  String get receiver => get<String>(receiverColumn)!;
  set receiver(String value) => set<String>(receiverColumn, value);

  String get secret => get<String>(secretColumn)!;
  set secret(String value) => set<String>(secretColumn, value);
}
