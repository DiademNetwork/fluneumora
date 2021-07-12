// import 'package:fluneumora/all.dart';

// class TokenModel extends Equatable {
//   TokenModel({
//     required this.tokenAddress,
//     required this.contractType,
//     required this.name,
//     required this.symbol,
//     required this.tokenUri,
//     required this.tokenId,
//     required this.amount,
//   });

//   final String tokenAddress;
//   final String contractType;
//   final String name;
//   final String symbol;
//   final String tokenUri;
//   final int tokenId;
//   final int amount;

//   @override
//   List<Object?> get props => [
//         tokenAddress,
//         contractType,
//         name,
//         symbol,
//         tokenUri,
//         tokenId,
//         amount,
//       ];

//   factory TokenModel.fromJson(Map<String, dynamic> json) {
//     return TokenModel(
//       tokenAddress: json['token_address'],
//       contractType: json['contract_type'],
//       name: json['name'],
//       symbol: json['symbol'],
//       tokenUri: json['token_uri'],
//       tokenId: int.parse(json['token_id']),
//       amount: int.parse(json['amount']),
//     );
//   }
// }
