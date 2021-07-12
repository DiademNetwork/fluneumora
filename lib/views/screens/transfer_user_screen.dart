import 'package:fluneumora/all.dart';

class TransferScanScreen extends StatelessWidget {
  Widget build(_) {
    return Container();
  }
}

class TransferGiftScreen extends StatelessWidget {
  Widget build(_) {
    return Container();
  }
}

class TransferUserScreen extends StatefulWidget {
  @override
  State<TransferUserScreen> createState() => _TransferUserScreenState();
}

class _TransferUserScreenState extends State<TransferUserScreen> {
  void onPressedTransfer(UserModel user) {
    pushNewScreen(
      context,
      screen: TransferAmountScreen(
        recipient: user,
      ),
    );
  }

  void onPressedAddress() {
    pushNewScreen(
      context,
      screen: TransferAddressScreen(),
    );
  }

  void onPressedQR() {
    pushNewScreen(
      context,
      screen: TransferScanScreen(),
    );
  }

  void onPressedGift() {
    pushNewScreen(
      context,
      screen: TransferAmountScreen(
        recipient: null,
      ),
    );
  }

  void onPressedCreate() {
    pushNewScreen(
      context,
      screen: CreateContactScreen(),
    );
  }

  void onPressedClose() {
    Navigator.of(context).maybePop();
  }

  String? recipient;
  void onChangedRecipient(value) {
    setState(() {
      recipient = value;
    });
  }

  Widget build(BuildContext context) {
    final owners =
        context.select((AppState state) => state.owners[state.walletTokenId]);

    // final contacts = context.select((AppState state) => state.contacts);

    final walletTokenId =
        context.select((AppState state) => state.walletTokenId);

    final walletToken =
        context.select((AppState state) => state.tokens.firstWhere(
              (element) => element.tokenId == walletTokenId,
            ));

    final tokenName =
        walletToken.tokenName.isNotEmpty ? walletToken.tokenName : "UNKNOWN";

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
                    onPressed: onPressedClose,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "Transfer $tokenName",
                          style: TextStyles.title,
                        ),
                        Text(
                          "Choose recipient from existing owners or new address",
                          style: TextStyles.hint.copyWith(
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // if (name != null && supply != null)
                  // NeumorphicButton(
                  //   child: Text(
                  //     "Add",
                  //     style: TextStyles.button,
                  //   ),
                  //   onPressed: onPressedSave,
                  // ),

                  // NeumorphicButton(
                  //   child: Image.asset(
                  //     'assets/close-ic.png',
                  //     width: 24,
                  //     height: 24,
                  //   ),
                  //   onPressed: onPressedClose,
                  // ),
                ],
              ),
            ),

            // TODO: SAVE GIFT TO MORALIS COLLECTION AND GENERATE LINK
            // GIVE ASSET TO USER VIA RECEIVE SCREEN WHEN ACCEPTING THE LINK
            // FROM THE LOCAL ACCOUNT USING UNIQUE OBJECT ID

            DoubleNeumorphic(
              child: Column(
                children: [
                  // SpacedRow.big(
                  //   children: [
                  //     NeumorphicButton(
                  //       style: NeumorphicStyle(
                  //         depth: 1,
                  //         boxShape: NeumorphicBoxShape.rect(),
                  //       ),
                  //       onPressed: onPressedGift,
                  //       child: Icon(
                  //         Icons.card_giftcard,
                  //         size: 24,
                  //       ),
                  //     ),
                  //     Text(
                  //       "Create invite link for gift",
                  //       style: TextStyles.name,
                  //     ),
                  //   ],
                  // ),
                  // SpacedRow.big(
                  //   children: [
                  //     NeumorphicButton(
                  //       style: NeumorphicStyle(
                  //         depth: 1,
                  //         boxShape: NeumorphicBoxShape.rect(),
                  //       ),
                  //       onPressed: onPressedQR,
                  //       child: Icon(
                  //         Icons.scanner,
                  //         size: 24,
                  //       ),
                  //     ),
                  //     Text(
                  //       "Scan QR code to transfer",
                  //       style: TextStyles.name,
                  //     ),
                  //   ],
                  // ),
                  SpacedRow.big(
                    children: [
                      NeumorphicButton(
                        style: NeumorphicStyle(
                          depth: 1,
                          boxShape: NeumorphicBoxShape.rect(),
                        ),
                        onPressed: onPressedAddress,
                        child: Icon(
                          Icons.add,
                          size: 24,
                        ),
                      ),
                      Text(
                        "Transfer to another address",
                        style: TextStyles.name,
                      ),
                    ],
                  ),
                  if (owners != null)
                    for (var i = 0; i < owners.length; i++)
                      Column(
                        children: [
                          Divider(),
                          SpacedRow.big(
                            children: [
                              NeumorphicButton(
                                style: NeumorphicStyle(
                                  depth: 1,
                                  boxShape: NeumorphicBoxShape.rect(),
                                ),
                                onPressed: () => onPressedTransfer(owners[i]),
                                child: Image.asset(
                                  'assets/send.png',
                                  width: 24,
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (owners[i].fullname != "")
                                    Text(
                                      owners[i].fullname,
                                      style: TextStyles.name,
                                    ),
                                  if (owners[i].fullname != "")
                                    Text(
                                      owners[i].address,
                                      style: TextStyles.address,
                                    )
                                  else
                                    Text(
                                      owners[i].address,
                                      style: TextStyles.address,
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
