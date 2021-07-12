import 'package:fluneumora/all.dart';
import 'package:fluneumora/views/widgets/transaction_timeline.dart';

enum TransactionStep { initial, filledgas, signed, broadcasted, confirmed }

Color getColor(int index, int current) {
  if (index == current) {
    return inProgressColor;
  } else if (index < current) {
    return completeColor;
  } else {
    return todoColor;
  }
}

List<String> steps = ["Receive gas", "Sign trx", "Broadcast", "Confirmed"];

class TransactionScreen extends StatefulWidget {
  TransactionScreen();

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  bool transactionTimeout = false;

  String? initialWalletTokenId;

  initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      initialWalletTokenId =
          context.select((AppState state) => state.walletTokenId);
    });

    Future.delayed(Duration(seconds: 10), () {
      if (context.select((AppState state) =>
          state.currentTransaction.transactionStep !=
          TransactionStep.confirmed)) {
        setState(
          () {
            transactionTimeout = true;
          },
        );
      }
    });
  }

  void onPressedCopy(value) {
    FlutterClipboard.copy(value);
  }

  void onPressedBack() {
    Navigator.of(context).maybePop();
  }

  void onPressedClose() {
    context.dispatch<AppState>(
      LoadTokensAction(),
    );

    // context.dispatch<AppState>(
    //   LoadTokenBalance(
    //     tokenId: context.select(
    //       (AppState state) => state.walletTokenId,
    //     ),
    //   ),
    // );

    // context.dispatch<AppState>(
    //   LoadTokenTransactions(
    //     tokenId: context.select(
    //       (AppState state) => state.walletTokenId,
    //     ),
    //   ),
    // );

    Navigator.of(context).pop();

    // Navigator.of(context).popUntil(ModalRoute.withName("/app"));
  }

  Widget build(_) {
    final transactionStep = context
        .select((AppState state) => state.currentTransaction.transactionStep);

    final transactionStepIndex =
        TransactionStep.values.indexOf(transactionStep);

    final transactionHash = context
        .select((AppState state) => state.currentTransaction.transactionHash);

    // final transactionLink =
    //     "${Config.explorerUrl}/tx/${transactionHash.trim()}";

    final showCloseButton =
        transactionStep == TransactionStep.confirmed || transactionTimeout;

    final walletTokenId =
        context.select((AppState state) => state.walletTokenId);

    final tokenDetails = context
        .select((AppState state) => state.currentTransaction.tokenDetails);

    final user = context
        .select((AppState state) => state.currentTransaction.recipientUser);

    bool isNewToken =
        initialWalletTokenId != null && walletTokenId != initialWalletTokenId;

    final depositSecret = context
        .select((AppState state) => state.currentTransaction.resultValue);

    final depositLink = depositSecret != null ? "htps://$depositSecret" : null;

    final String recipientAccount =
        "0x89e7c3ac5dfddb13af63ffadc807faac13a1187f";

    // Map<String, String> transaction = {
    //   "first_title": "matic received to cover gas fee",
    //   "second_title": "token transferred to recipient account",
    // };

    final transaction = context.select(
      (AppState state) => state.currentTransaction,
    );

    return NeumorphicScaffold(
      child: SpacedColumn.semiBig(
        children: [
          Padding(
            padding: Spacing.of(context).insets.horizontal.big,
            child: Padding(
              padding: Spacing.of(context).insets.onlyTop.normal,
              child: Row(
                children: [
                  Container(
                    child: AnimatedSwitcher(
                      duration: Duration(seconds: 1),
                      child: showCloseButton
                          ? FlatBackButton(
                              onPressed: onPressedBack,
                            )
                          : Container(),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text("Transaction", style: TextStyles.title),
                        // Text(widget.subtitle, style: TextStyles.subtitle),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // if (tokenDetails != null)
          //   Container(
          //     padding: Spacing.of(context).insets.horizontal.big,
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //       children: [
          //         TokenAvatar(
          //           tokenDetails: tokenDetails,
          //         ),
          //         SpacedColumn.normal(
          //           mainAxisAlignment: MainAxisAlignment.end,
          //           children: [
          //             Image.asset(
          //               'assets/transfer-ic.png',
          //             ),
          //             Text(
          //               "${tokenDetails.tokenSupply}",
          //               style: TextStyles.title,
          //             ),
          //             Text(
          //               "${tokenDetails.tokenName}",
          //               style: TextStyles.title,
          //             ),
          //           ],
          //         ),
          //         if (user != null)
          //           UserAvatar(
          //             user: user,
          //           ),
          //         // Text(
          //         //     "create ${tokenDetails.tokenSupply} of ${tokenDetails.tokenName}"),

          //         // Text("transfer $amount ${tokenDetails.tokenName}"),
          //       ],
          //     ),
          //   ),

          Container(
            height: 200,
            child: TransactionTimeline(
              transactionStepIndex: transactionStepIndex,
            ),
          ),

          Container(
            height: 63,
            padding: Spacing.of(context).insets.horizontal.big,
            child: AnimatedSwitcher(
              duration: Duration(seconds: 1),
              child: transaction.gasTransactionHash != ""
                  ? SpacedRow.normal(
                      children: [
                        Flexible(
                          child: DoubleNeumorphic(
                            child: SpacedColumn.small(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: Spacing.of(context)
                                      .insets
                                      .exceptBottom
                                      .normal,
                                  child: Text("receive matic to cover gas fee",
                                      style: TextStyles.title.copyWith(
                                        fontSize: 10,
                                      )),
                                ),
                                Padding(
                                  padding: Spacing.of(context)
                                      .insets
                                      .exceptTop
                                      .normal,
                                  child: Text(
                                    "${Config.explorerUrl}/tx/${transaction.gasTransactionHash.trim()}",
                                    overflow: TextOverflow.clip,
                                    style:
                                        TextStyles.hint.copyWith(fontSize: 8),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        NeumorphicButton(
                          onPressed: () => onPressedCopy(
                            "${Config.explorerUrl}/tx/${transaction.gasTransactionHash.trim()}",
                          ),
                          child: Icon(
                            Icons.copy,
                            size: 30,
                            color: secondaryColor,
                          ),
                        ),
                      ],
                    )
                  : Container(),
            ),
          ),

          Container(
            height: 55,
            padding: Spacing.of(context).insets.horizontal.big,
            child: AnimatedSwitcher(
              duration: Duration(seconds: 1),
              child: transaction.transactionHash != ""
                  ? SpacedRow.normal(
                      children: [
                        NeumorphicButton(
                          onPressed: () => onPressedCopy(
                            "${Config.explorerUrl}/tx/${transaction.transactionHash.trim()}",
                          ),
                          child: Icon(
                            Icons.copy,
                            size: 30,
                            color: secondaryColor,
                          ),
                        ),
                        Flexible(
                          child: DoubleNeumorphic(
                            child: SpacedColumn.small(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: Spacing.of(context)
                                      .insets
                                      .exceptBottom
                                      .normal,
                                  child: Text(
                                    transaction.transactionTitle,
                                    style: TextStyles.title.copyWith(
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: Spacing.of(context)
                                      .insets
                                      .exceptTop
                                      .normal,
                                  child: Text(
                                    "${Config.explorerUrl}/tx/${transaction.transactionHash.trim()}",
                                    overflow: TextOverflow.clip,
                                    style:
                                        TextStyles.hint.copyWith(fontSize: 8),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  : Container(),
            ),
          ),

          Container(
            height: 55,
            width: MediaQuery.of(context).size.width,
            padding: Spacing.of(context).insets.horizontal.big,
            child: AnimatedSwitcher(
              duration: Duration(seconds: 1),
              child: transaction.resultValue != ""
                  ? Container(
                      width: MediaQuery.of(context).size.width,
                      child: DoubleNeumorphic(
                        child: SpacedColumn.small(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: Spacing.of(context)
                                  .insets
                                  .exceptBottom
                                  .normal,
                              child: Text(
                                transaction.resultTitle,
                                style: TextStyles.title.copyWith(
                                  fontSize: 8,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  Spacing.of(context).insets.exceptTop.normal,
                              child: Text(
                                transaction.resultValue,
                                overflow: TextOverflow.clip,
                                style: TextStyles.hint.copyWith(fontSize: 12),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Container(),
            ),
          ),

          // Container(
          //   padding: Spacing.of(context).insets.horizontal.big,
          //   child: AnimatedSwitcher(
          //     duration: Duration(seconds: 2),
          //     child: isNewToken == true
          //         ? Neumorphic(
          //             style: NeumorphicStyle(
          //               depth: -1,
          //             ),
          //             padding: Spacing.of(context).insets.all.big,
          //             child: SpacedRow.normal(
          //               children: [
          //                 Text("Created Token #", style: TextStyles.title),
          //                 Text("$walletTokenId", style: TextStyles.title),
          //               ],
          //             ),
          //           )
          //         : Container(),
          //   ),
          // ),

          // Container(
          //   padding: Spacing.of(context).insets.horizontal.big,
          //   child: AnimatedSwitcher(
          //     duration: Duration(seconds: 2),
          //     child: depositLink != null
          //         ? Container(
          //             child: SpacedRow.normal(
          //               children: [
          //                 Flexible(
          //                   child: Neumorphic(
          //                     padding: Spacing.of(context).insets.all.normal,
          //                     style: NeumorphicStyle(
          //                       depth: -1,
          //                     ),
          //                     child: Text(
          //                       depositLink,
          //                       overflow: TextOverflow.clip,
          //                       style: TextStyles.hint.copyWith(fontSize: 12),
          //                     ),
          //                   ),
          //                 ),
          //                 NeumorphicButton(
          //                   onPressed: () => onPressedCopy(depositLink),
          //                   child: Icon(Icons.copy),
          //                 ),
          //               ],
          //             ),
          //           )
          //         : Container(),
          //   ),
          // ),

          // if (widget.child != null) widget.child!,
        ],
      ),
    );
  }
}
