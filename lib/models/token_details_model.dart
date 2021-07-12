import 'package:fluneumora/all.dart';

class TokenDetailsModel extends ParseObject implements ParseCloneable {
  TokenDetailsModel() : super(tableName);
  TokenDetailsModel.clone() : this();

  @override
  TokenDetailsModel clone(Map<String, dynamic> map) =>
      TokenDetailsModel.clone()..fromJson(map);

  static const String tableName = "TokenDetails";

  static const String _token_id = "token_id";
  static const String _token_name = "token_name";
  static const String _token_supply = "token_supply";
  static const String _creator_address = "creator_address";
  static const String _is_new = "is_new";
  static const String _hash = "hash";

  String get tokenId => get<String>(_token_id, defaultValue: "")!;
  String get tokenName => get<String>(_token_name)!;
  String get tokenSupply => get<String>(_token_supply, defaultValue: "0")!;
  String get creatorAddress => get<String>(_creator_address)!;
  bool get isNew => get<bool>(_is_new)!;

  set tokenName(String value) => set<String>(_token_name, value);
  set isNew(bool value) => set<bool>(_is_new, value);
  set tokenSupply(String value) => set<String>(_token_supply, value);

  set hash(String value) => set<String>(_hash, value);
  String get hash => get<String>(_hash, defaultValue: "")!;
}
