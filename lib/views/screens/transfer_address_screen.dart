import 'package:fluneumora/all.dart';

class TransferAddressScreen extends StatefulWidget {
  @override
  State<TransferAddressScreen> createState() => _TransferAddressScreenState();
}

class _TransferAddressScreenState extends State<TransferAddressScreen> {
  void onPressedBack() {
    Navigator.of(context).maybePop();
  }

  void onPressedNext() async {
    final recipient = UserModel.clone()..address = address!;

    pushNewScreen(
      context,
      screen: TransferAmountScreen(
        recipient: recipient,
      ),
    );
  }

  String? address;
  void onChangedAddress(value) {
    if (value == "") {
      value = null;
    }
    setState(() {
      address = value;
    });
  }

  Widget build(BuildContext context) {
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
                            "Recipient address",
                            style: TextStyles.title,
                          ),
                        ],
                      ),
                    ),
                    AnimatedOpacity(
                      opacity: address != null ? 1 : 0,
                      duration: Duration(milliseconds: 200),
                      child: NeumorphicButton(
                        child: Text(
                          "Next",
                          style: TextStyles.button,
                        ),
                        onPressed: onPressedNext,
                      ),
                    ),
                  ],
                ),
              ),
              NeumorphicTextField(
                initialValue: "",
                onChanged: onChangedAddress,
                hintText: "wallet address",
              ),
            ],
          )),
    );
  }
}
