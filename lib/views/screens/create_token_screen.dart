import 'package:fluneumora/all.dart';

class CreateTokenScreen extends StatefulWidget {
  @override
  State<CreateTokenScreen> createState() => _CreateTokenScreenState();
}

class _CreateTokenScreenState extends State<CreateTokenScreen> {
  void onPressedBack() {
    Navigator.of(context).maybePop();
  }

  void onPressedCreate() async {
    context.dispatch<AppState>(
      CreateTokenAction(tokenName: name!, tokenSupply: supply.toString()),
    );

    await pushNewScreen(
      context,
      screen: TransactionScreen(),
    );

    Navigator.of(context).maybePop();

    // Navigator.of(context).pushAndRemoveUntil(
    //   CupertinoPageRoute(
    //     builder: (BuildContext context) {
    //       return TransactionScreen();
    //     },
    //   ),
    //   (_) => false,
    // );
  }

  String? name;
  void onChangedName(value) {
    if (value == "") {
      value = null;
    }
    setState(() {
      name = value;
    });
  }

  int? supply;
  void onChangedSupply(value) {
    try {
      value = int.parse(value);
    } catch (_) {
      value = null;
    }
    setState(() {
      supply = value;
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
                    InkWell(
                      onTap: onPressedBack,
                      child: Container(
                        width: 56,
                        height: 48,
                        padding: Spacing.of(context).insets.all.normal,
                        child: Image.asset("assets/back-ic.png", width: 16),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            "New Asset",
                            style: TextStyles.title,
                          ),
                        ],
                      ),
                    ),
                    AnimatedOpacity(
                      opacity: name != null && supply != null ? 1 : 0,
                      duration: Duration(milliseconds: 200),
                      child: NeumorphicButton(
                        child: Text(
                          "Create",
                          style: TextStyles.button,
                        ),
                        onPressed: onPressedCreate,
                      ),
                    ),
                  ],
                ),
              ),
              NeumorphicTextField(
                initialValue: "",
                onChanged: onChangedName,
                hintText: "choose asset name",
              ),
              NeumorphicTextField(
                initialValue: "",
                onChanged: onChangedSupply,
                hintText: "how many tokens",
                isNumeric: true,
              ),
            ],
          )),
    );
  }
}
