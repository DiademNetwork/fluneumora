import 'package:fluneumora/all.dart';

class ShareDepositScreen extends StatefulWidget {
  @override
  State<ShareDepositScreen> createState() => _ShareDepositScreenState();
}

class _ShareDepositScreenState extends State<ShareDepositScreen> {
  void onPressedBack() {
    Navigator.of(context).maybePop();
  }

  void onPressedCopy(value) {
    FlutterClipboard.copy(value);
    setState(() {
      showBackButton = true;
    });
  }

  bool showBackButton = false;

  Widget build(BuildContext context) {
    final transaction = context.select(
      (AppState state) => state.currentTransaction,
    );

    final secretLink =
        "https://fluneumora.app/accept/${transaction.resultValue}";

    return NeumorphicScaffold(
      child: SpacedColumn.semiBig(
        children: [
          Padding(
            padding: Spacing.of(context).insets.horizontal.big,
            child: Padding(
              padding: Spacing.of(context).insets.onlyTop.normal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  AnimatedSwitcher(
                    duration: Duration(seconds: 1),
                    child: showBackButton
                        ? FlatBackButton(
                            onPressed: onPressedBack,
                          )
                        : SizedBox(
                            width: 56,
                            height: 48,
                          ),
                  ),
                  Center(
                    child: Column(
                      children: [
                        Text(
                          "Share secret link",
                          style: TextStyles.title,
                        ),
                        Text(
                          "recipient can claim your deposit",
                          style:
                              TextStyles.subtitle.copyWith(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: Spacing.of(context).insets.horizontal.big,
            child: AnimatedSwitcher(
              duration: Duration(seconds: 1),
              child: transaction.resultValue != ""
                  ? SpacedRow.normal(
                      children: [
                        NeumorphicButton(
                          onPressed: () => onPressedCopy(secretLink),
                          child: Icon(
                            Icons.copy,
                            size: 30,
                            color: secondaryColor,
                          ),
                        ),
                        Expanded(
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
                                    "share secretly with deposit recipient",
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
                                    secretLink,
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
            padding: Spacing.of(context).insets.exceptTop.big,
            child: QrImage(
              data: transaction.resultValue,
            ),
          ),
        ],
      ),
    );
  }
}
