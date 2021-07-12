import 'package:fluneumora/all.dart';

enum TransactionType { minted, incoming, outcoming }

class TransactionTile extends StatelessWidget {
  final String userAddress;
  final TransactionModel transaction;

  const TransactionTile({
    required this.userAddress,
    required this.transaction,
  });

  void onPressedCopy() {
    final transactionLink =
        "${Config.explorerUrl}/tx/${transaction.transactionHash.trim()}";

    FlutterClipboard.copy(transactionLink);
  }

  Widget build(BuildContext context) {
    TransactionType transactionType;
    if (userAddress == transaction.fromAddress) {
      transactionType = TransactionType.outcoming;
    } else {
      if (transaction.fromAddress.replaceAll('0', '') == 'x') {
        transactionType = TransactionType.minted;
      } else {
        transactionType = TransactionType.incoming;
      }
    }

    // bool isIncoming = userAddress == transaction.toAddress;
    // String toUser = transaction.toUser?.username?.toString() ??
    //     transaction.toAddress.substring(0, 8);
    // String fromUser = transaction.fromUser?.username?.toString() ??
    //     transaction.fromAddress.substring(0, 8);
    // String tokenName = transaction.token?["contract_type"]?.toString() ?? "";

    UserModel? user;
    if (transactionType == TransactionType.minted) {
      user = transaction.toUser;
    } else if (transactionType == TransactionType.incoming) {
      user = transaction.fromUser;
    } else if (transactionType == TransactionType.outcoming) {
      user = transaction.toUser;
    }

    String address = "";
    if (transactionType == TransactionType.minted) {
      address = transaction.toAddress;
    } else if (transactionType == TransactionType.incoming) {
      address = transaction.fromAddress;
    } else if (transactionType == TransactionType.outcoming) {
      address = transaction.toAddress;
    }

    // String fullname = "";
    // if (transactionType == TransactionType.minted) {
    //   fullname = transaction.toUser?.fullname ?? "";
    // }
    // if (transactionType == TransactionType.incoming) {
    //   fullname = transaction.fromUser?.fullname ?? "";
    // }
    // if (transactionType == TransactionType.outcoming) {
    //   fullname = transaction.toUser?.fullname ?? "";
    // }

    // fullname = fullname.toLowerCase();

    // address = "0x89e7c3ac5dfddb13af63ffadc807faac13a1187f";

    // var defaultFullname = "account${address.substring(1, 5)}";

    // if (fullname == "") {
    //   fullname = defaultFullname;
    // }

    return Column(
      children: [
        Padding(
          padding: Spacing.of(context).insets.vertical.normal,
          child: Padding(
            padding: Spacing.of(context).insets.horizontal.semiBig,
            child: SpacedRow.normal(
              children: [
                NeumorphicButton(
                  style: NeumorphicStyle(
                    depth: 1,
                    intensity: 0.5,
                  ),
                  onPressed: onPressedCopy,
                  child: Image.asset(
                    'assets/copy.png',
                    width: 18,
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (transactionType == TransactionType.incoming)
                        Text(
                          "received from",
                          style: TextStyles.trx1,
                        ),
                      if (transactionType == TransactionType.outcoming)
                        Text(
                          "sent to",
                          style: TextStyles.trx1.copyWith(fontSize: 15),
                        ),
                      if (transactionType == TransactionType.minted)
                        Text(
                          "created by",
                          style: TextStyles.trx1,
                        ),
                      Container(
                        // height: 50,
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Row(
                                //   children: [
                                //     Padding(
                                //       padding: Spacing.of(context)
                                //           .insets
                                //           .onlyBottom
                                //           .small,
                                //       child: Text(
                                //         user?.fullname ?? "unknown",
                                //         style: TextStyles.title.copyWith(
                                //           fontSize: 15,
                                //           fontWeight: FontWeight.w600,
                                //         ),
                                //         textAlign: TextAlign.left,
                                //       ),
                                //     ),
                                //     if (user != null) UserAvatar(user: user),
                                //   ],
                                // ),
                                Text(
                                  address,
                                  style: TextStyles.address,
                                  overflow: TextOverflow.clip,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                if (transactionType == TransactionType.incoming)
                  Text(
                    "+ ${transaction.amount}",
                    style: TextStyles.trx3plus,
                  ),
                if (transactionType == TransactionType.outcoming)
                  Text(
                    "- ${transaction.amount}",
                    style: TextStyles.trx3minus,
                  ),
                if (transactionType == TransactionType.minted)
                  Text(
                    "${transaction.amount}",
                    style: TextStyles.trx3neutral,
                  ),
              ],
            ),
          ),
        ),
        NeumorphicDivider(),
      ],
    );
  }
}
