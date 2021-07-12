import 'package:fluneumora/all.dart';

class MaybeUserModel {
  UserModel? user;

  MaybeUserModel(this.user);

  factory MaybeUserModel.none() => MaybeUserModel(null);

  factory MaybeUserModel.existing(UserModel user) => MaybeUserModel(user);
}

class UserModel extends ParseUser implements ParseCloneable {
  UserModel(String? username, String? password)
      : super(username, password, null) {
    if (username != null) {
      // this.address = username;
      // this.ethAddress = username;
      // this.maticAddress = username;
      // this.bscAddress = username;
      this.address = username;
      this.accounts = [username];
    }
  }

  UserModel.clone() : this(null, null);
  clone(Map<String, dynamic> map) => UserModel.clone()..fromJson(map);

  static const String tableName = "User";

  // static const String bscAddressColumn = "bscAddress";

  // static const String ethAddressColumn = "ethAddress";

  // static const String maticAddressColumn = "maticAddress";

  static const String tokensColumn = "tokens";

  static const String avatarColumn = "avatar";

  static const String accountsColumn = "accounts";

  static const String fullnameColumn = "fullname";

  static const String addressColumn = "address";

  String get address => get<String>(addressColumn, defaultValue: "")!;
  set address(String value) => set<String>(addressColumn, value);

  String get fullname => get<String>(fullnameColumn, defaultValue: "")!;
  set fullname(String value) => set<String>(fullnameColumn, value);

  // String get bscAddress => get<String>(bscAddressColumn, defaultValue: "")!;
  // set bscAddress(String value) => set<String>(bscAddress, value);

  // String get maticAddress => get<String>(maticAddressColumn, defaultValue: "")!;
  // set maticAddress(String value) => set<String>(maticAddressColumn, value);

  // String get ethAddress => get<String>(ethAddressColumn, defaultValue: "")!;
  // set ethAddress(String value) => set<String>(ethAddressColumn, value);

  List<String> get accounts =>
      get<List<String>>(accountsColumn, defaultValue: [])!;
  set accounts(List<String> value) => set<List<String>>(accountsColumn, value);

  List get tokens => get<List>(tokensColumn, defaultValue: [])!;

  ParseFileBase? get avatar => get<ParseFileBase>(avatarColumn);

  set avatar(ParseFileBase? value) => set<ParseFileBase>(avatarColumn, value!);
}
