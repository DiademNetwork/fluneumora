import 'package:fluneumora/all.dart';
import 'package:fluneumora/views/screens/share_deposit_screen.dart';

class TransferAmountScreen extends StatefulWidget {
  final UserModel? recipient;

  TransferAmountScreen({
    this.recipient,
  });

  @override
  State<TransferAmountScreen> createState() => _TransferAmountScreenState();
}

class _TransferAmountScreenState extends State<TransferAmountScreen> {
  void onPressedBack() {
    Navigator.of(context).maybePop();
  }

  void onPressedTransfer(walletToken) async {
    if (widget.recipient != null) {
      final recipient = widget.recipient!.address;

      context.dispatch<AppState>(
        TransferAction(
          recipient: recipient,
          amount: amount.toString(),
          tokenId: walletToken.tokenId,
        ),
      );
    } else {
      context.dispatch<AppState>(
        TransferDepositAction(
          amount: amount.toString(),
          tokenId: walletToken.tokenId,
        ),
      );
    }

    await pushNewScreen(
      context,
      screen: TransactionScreen(),
    );

    // if (widget.recipient != null) {
    //   Navigator.of(context).maybePop();
    // } else {
    //   await pushNewScreen(
    //     context,
    //     screen: ShareDepositScreen(),
    //   );

    //   Navigator.of(context).maybePop();
    // }

    // Navigator.of(context).pushReplacement(
    //   CupertinoPageRoute(
    //     builder: (BuildContext context) {
    //       return TransactionScreen(
    //           // title: "Transfer Asset",
    //           // subtitle: "to $recipient",
    //           // child: Column(
    //           //   children: [
    //           //     TokenAvatar(
    //           //       tokenDetails: walletToken,
    //           //     ),
    //           //     NeumorphicText(
    //           //       "- $amount ${walletToken.tokenName}"
    //           //     ),
    //           //   ],
    //           // ),
    //           );
    //     },
    //   ),
    // );
  }

  int? amount;
  void onChangedAmount(String value) {
    try {
      var newAmount = int.parse(value);

      setState(() {
        amount = newAmount;
      });
    } catch (_) {
      setState(() {
        amount = 0;
      });
    }
  }

  Widget build(BuildContext context) {
    final walletTokenId =
        context.select((AppState state) => state.walletTokenId);

    final walletToken = context.select((AppState state) =>
        state.tokens.firstWhere((element) => element.tokenId == walletTokenId));

    return NeumorphicScaffold(
      child: Padding(
        padding: Spacing.of(context).insets.horizontal.big,
        child: SpacedColumn.semiBig(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: Spacing.of(context).insets.vertical.normal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  FlatBackButton(
                    onPressed: onPressedBack,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "Choose amount",
                          style: TextStyles.title,
                        ),
                        Text(
                          "to transfer ${walletToken.tokenName}",
                          style: TextStyles.address,
                        ),
                      ],
                    ),
                  ),
                  if (amount != null && amount! > 0)
                    NeumorphicButton(
                      child: Text(
                        "Transfer",
                        style: TextStyles.button,
                      ),
                      onPressed: () => onPressedTransfer(walletToken),
                    ),
                ],
              ),
            ),
            NeumorphicTextField(
              initialValue: "",
              hintText: "Amount of tokens",
              onChanged: onChangedAmount,
              isNumeric: true,
            ),
          ],
        ),
      ),
    );
  }
}
