import 'package:fluneumora/all.dart';

class TransactionState extends Equatable {
  TransactionState({
    required this.isExisting,
    required this.transactionStep,
    required this.gasTransactionHash,
    required this.transactionHash,
    required this.transactionTitle,
    required this.resultValue,
    required this.resultTitle,
    this.tokenDetails,
    this.recipientUser,
  });

  factory TransactionState.initial() => TransactionState(
        isExisting: true,
        transactionStep: TransactionStep.initial,
        gasTransactionHash: "",
        transactionHash: "",
        transactionTitle: "",
        resultValue: "",
        resultTitle: "",
      );

  factory TransactionState.none() => TransactionState.initial().update(
        isExisting: false,
      );

  TransactionState update(
          {isExisting,
          transactionStep,
          gasTransactionHash,
          transactionHash,
          transactionTitle,
          resultValue,
          resultTitle,
          tokenDetails,
          recipientUser}) =>
      TransactionState(
        isExisting: isExisting ?? this.isExisting,
        transactionStep: transactionStep ?? this.transactionStep,
        gasTransactionHash: gasTransactionHash ?? this.gasTransactionHash,
        transactionHash: transactionHash ?? this.transactionHash,
        transactionTitle: transactionTitle ?? this.transactionTitle,
        resultValue: resultValue ?? this.resultValue,
        resultTitle: resultTitle ?? this.resultTitle,
        tokenDetails: tokenDetails ?? this.tokenDetails,
        recipientUser: recipientUser ?? this.recipientUser,
      );

  @override
  List<Object?> get props => [
        isExisting,
        transactionStep,
        gasTransactionHash,
        transactionHash,
        transactionTitle,
        resultValue,
        resultTitle,
        tokenDetails,
        recipientUser
      ];

  final bool isExisting;
  final TransactionStep transactionStep;
  final String gasTransactionHash;
  final String transactionHash;
  final String transactionTitle;
  final String resultValue;
  final String resultTitle;

  final TokenDetailsModel? tokenDetails;
  final UserModel? recipientUser;
}
