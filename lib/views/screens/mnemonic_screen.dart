import 'package:fluneumora/all.dart';

class MnemonicScreen extends StatefulWidget {
  @override
  State<MnemonicScreen> createState() => _MnemonicScreenState();
}

class _MnemonicScreenState extends State<MnemonicScreen> {
  final TextEditingController controller = TextEditingController(text: "");

  String mnemonic = "";

  bool isReadOnly = true;

  FocusNode focusNode = FocusNode();

  void onPressedCreate() async {
    context.dispatch<AppState>(
      AuthorizeAction(
        mnemonic: mnemonic,
      ),
    );

    Navigator.of(context).pushReplacementNamed("/app");
  }

  void onPressedCopy() {
    FlutterClipboard.copy(mnemonic);
  }

  void onPressedEdit() {
    // mnemonic = generateMnemonic();
    // controller.text = mnemonic;

    controller.clear();

    focusNode.requestFocus();

    setState(() {
      isReadOnly = false;
    });
  }

  void onChangedMnemonic(value) {}

  initState() {
    super.initState();

    mnemonic = generateMnemonic();
    controller.text = mnemonic;

    nextTick(() async {
      final test = Test(context: context);

      // await test.createExistingWallet();
    });
  }

  Widget build(BuildContext context) {
    return NeumorphicScaffold(
      child: SpacedColumn.semiBig(
        children: [
          Padding(
            padding: Spacing.of(context).insets.vertical.normal,
            child: Container(
              padding: Spacing.of(context).insets.horizontal.big,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "New Wallet",
                    style: TextStyles.title,
                  ),
                  NeumorphicButton(
                    onPressed: onPressedCreate,
                    child: Text(
                      "Create",
                      style: TextStyles.button,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: Spacing.of(context).insets.onlyRight.big,
            child: SpacedRow.normal(
              children: [
                Expanded(
                  child: Neumorphic(
                    margin: Spacing.of(context).insets.horizontal.big,
                    padding: Spacing.of(context).insets.vertical.semiBig,
                    style: NeumorphicStyle(
                      depth: -4,
                      intensity: 0.9,
                    ),
                    child: Container(
                      height: 90,
                      child: Padding(
                        padding: Spacing.of(context).insets.horizontal.semiBig,
                        child: TextField(
                          focusNode: focusNode,
                          controller: controller,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                          ),
                          showCursor: true,
                          style: TextStyles.hint,
                          onChanged: onChangedMnemonic,
                          readOnly: isReadOnly,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                        ),
                      ),
                    ),
                  ),
                ),
                SpacedColumn.normal(
                  children: [
                    NeumorphicButton(
                      onPressed: onPressedCopy,
                      child: Image.asset(
                        'assets/copy.png',
                        width: 24,
                      ),
                    ),
                    NeumorphicButton(
                      onPressed: onPressedEdit,
                      child: Image.asset(
                        'assets/edit.png',
                        width: 24,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
