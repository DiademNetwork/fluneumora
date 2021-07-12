import 'package:fluneumora/all.dart';

class CreateContactScreen extends StatefulWidget {
  @override
  State<CreateContactScreen> createState() => _CreateContactScreenState();
}

class _CreateContactScreenState extends State<CreateContactScreen> {
  void onPressedBack() {
    Navigator.of(context).maybePop();
  }

  void onPressedSave() async {
    await context.dispatch<AppState>(
      AddNewContact(address: address!, fullname: username!),
    );

    Navigator.of(context).maybePop();
  }

  String? username;
  void onChangedName(value) {
    if (value == "") {
      value = null;
    }
    setState(() {
      username = value;
    });
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
                            "New Recipient",
                            style: TextStyles.title,
                          ),
                        ],
                      ),
                    ),
                    AnimatedOpacity(
                      opacity: username != null && address != null ? 1 : 0,
                      duration: Duration(milliseconds: 200),
                      child: NeumorphicButton(
                        child: Text(
                          "Add",
                          style: TextStyles.button,
                        ),
                        onPressed: onPressedSave,
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
              NeumorphicTextField(
                initialValue: "",
                onChanged: onChangedName,
                hintText: "choose nickname",
              ),
            ],
          )),
    );
  }
}
