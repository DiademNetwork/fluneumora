import 'package:fluneumora/all.dart';

Future<void> nextTick(Function? fn) {
  return Future.delayed(Duration.zero, () {
    if (fn != null) fn();
  });
}

Future<void> sleep(Duration duration) async {
  return Future.delayed(
    duration,
  );
}

// class NextTransactionStatusAction extends Action<AppState> {
//   final TransactionStep step;

//   NextTransactionStatusAction(this.step);

//   Stream<Updater<AppState>> call(Context<AppState> context) async* {
//     yield (state) => state.update(
//           transactionStep: step,
//         );
//   }
// }

class DepositDetailsTestAction extends Action<AppState> {
  Stream<Updater<AppState>> call(Context<AppState> context) async* {
    yield (state) => state.update(
          currentTransaction: TransactionState.initial().update(
            transactionStep: TransactionStep.confirmed,
            resultValue: "0x3182ead0cee8666b92d3d37fd2f908158447033f",
          ),
        );
  }
}

class Test {
  BuildContext context;

  final String mnemonic =
      "trash injury dog message claim grab item eight achieve face edge mosquito";

  Test({
    required this.context,
  });

  createExistingWallet() async {
    await context.dispatch<AppState>(
      AuthorizeAction(
        mnemonic: mnemonic,
      ),
    );

    Navigator.of(context).pushReplacementNamed("/app");
  }

  createNewWallet() async {
    var mnemonic = generateMnemonic();

    await context.dispatch<AppState>(
      AuthorizeAction(
        mnemonic: mnemonic,
      ),
    );

    Navigator.of(context).pushReplacementNamed("/app");
  }

  createToken() async {
    pushNewScreen(
      context,
      screen: CreateTokenScreen(),
    );

    var tokenSupply = "21000";
    var tokenName = "BALISEEDS";

    context.dispatch<AppState>(
      CreateTokenAction(
        tokenName: tokenName,
        tokenSupply: tokenSupply,
      ),
    );

    pushNewScreen(
      context,
      screen: TransactionScreen(
          // title: "Create $tokenName",
          // subtitle: "with supply of $tokenSupply",
          ),
    );
  }

  loadTokens() async {
    await context.dispatch<AppState>(
      LoadTokensAction(),
    );
  }

  transferToken() async {
    context.dispatch<AppState>(
      TransferAction(
        recipient: "0x3182ead0cee8666b92d3d37fd2f908158447033f",
        amount: "1",
        tokenId: "163",
      ),
    );

    pushNewScreen(
      context,
      screen: TransactionScreen(),
    );
  }

  // transferDeposit() async {
  //   context.dispatch<AppState>(
  //     TransferDepositAction(amount: "1", tokenId: "158"),
  //   );

  //   pushNewScreen(
  //     context,
  //     screen: TransactionScreen(),
  //   );
  // }

  // acceptDeposit() async {}

  // shareSecret() async {
  //   await context.dispatch<AppState>(
  //     DepositDetailsTestAction(),
  //   );

  //   pushNewScreen(
  //     context,
  //     screen: ShareDepositScreen(),
  //   );
  // }

  // loadContacts() async {
  //   await context.dispatch<AppState>(
  //     LoadContactsAction(),
  //   );
  // }

  // transactionStatus() async {
  //   pushNewScreen(context, screen: TransactionScreen());

  //   await context.dispatch<AppState>(
  //       NextTransactionStatusAction(TransactionStep.filledgas));

  //   await sleep();

  //   await context.dispatch<AppState>(
  //       NextTransactionStatusAction(TransactionStep.signed));

  //   await sleep();

  //   await context.dispatch<AppState>(
  //       NextTransactionStatusAction(TransactionStep.broadcasted));

  //   await sleep();

  //   await context.dispatch<AppState>(
  //       NextTransactionStatusAction(TransactionStep.confirmed));
  // }

  // loadTokens() async {
  //   // await context.dispatch<AppState>(
  //   //   LoginWithMnemonicAction(
  //   //     mnemonic: bobMnemonic,
  //   //   ),
  //   // );

  //   await context.dispatch<AppState>(LoginWithMoralis(
  //     username: "realbob",
  //     password: "bobpass",
  //   ));

  //   await context.dispatch<AppState>(
  //     GetTokensAction(),
  //   );
  // }

  // loadMultiWallet() async {
  //   await context.dispatch<AppState>(
  //     LoginWithMnemonicAction(
  //       mnemonic: bobMnemonic,
  //     ),
  //   );

  //   // await context.dispatch<AppState>(

  //   // );
  // }

  // addNewContact() async {
  //   await context.dispatch<AppState>(
  //     AddNewContact(address: "0x123", username: "sergeo"),
  //   );
  // }

  // createToken() async {
  //   await context.dispatch<AppState>(
  //     LoginWithMnemonicAction(
  //       mnemonic: bobMnemonic,
  //     ),
  //   );

  //   pushNewScreen(
  //     context,
  //     screen: CreateTokenScreen(),
  //   );

  //   var tokenSupply = 7500000;
  //   var tokenName = "MECOIN";

  //   context.dispatch<AppState>(
  //     CreateTokenAction(
  //       tokenName: tokenName,
  //       tokenSupply: tokenSupply,
  //     ),
  //   );

  //   pushNewScreen(
  //     context,
  //     screen: TransactionScreen(
  //       title: "Create $tokenName",
  //       subtitle: "with supply of $tokenSupply",
  //     ),
  //   );
  // }

  // transferToContact() async {
  //   await context.dispatch<AppState>(
  //     LoginWithMnemonicAction(
  //       mnemonic: bobMnemonic,
  //     ),
  //   );

  //   await context.dispatch<AppState>(
  //     GetNiftiesAction(),
  //   );

  //   await Future.wait([
  //     context.dispatch<AppState>(
  //       UpdateTransactionsAction(),
  //     ),
  //     context.dispatch<AppState>(
  //       LoadContactsAction(),
  //     )
  //   ]);

  //   pushNewScreen(
  //     context,
  //     screen: TransferScreen(),
  //   );

  //   await sleep(ms: 500);

  //   final walletTokenId =
  //       context.select((AppState state) => state.walletTokenId);

  //   final walletToken = context.select((AppState state) =>
  //       state.tokens.firstWhere((element) => element.tokenId == walletTokenId));

  //   final tokenName = walletToken.tokenName;

  //   final recipientContact =
  //       context.select((AppState state) => state.contacts.first);

  //   final recipient = recipientContact.address;

  //   pushNewScreen(
  //     context,
  //     screen: TransferSecondScreen(
  //       recipient: recipientContact,
  //     ),
  //   );

  //   await sleep(ms: 500);

  //   final amount = 1;

  //   context.dispatch<AppState>(
  //     TransferAction(
  //       amount: amount,
  //       recipient: recipient,
  //     ),
  //   );

  //   pushNewScreen(
  //     context,
  //     screen: TransactionScreen(
  //       title: "Transfer $tokenName ($amount)",
  //       subtitle: "to $recipient",
  //     ),
  //   );
  // }

  // loginAndTransfer() async {
  //   await context.dispatch<AppState>(
  //     LoginWithMnemonicAction(
  //       mnemonic: bobMnemonic,
  //     ),
  //   );

  //   await context.dispatch<AppState>(
  //     GetNiftiesAction(),
  //   );

  //   pushNewScreen(context, screen: TransactionScreen());

  //   await context.dispatch<AppState>(
  //     TransferAction(
  //       recipient: aliceAddress,
  //       amount: 1,
  //     ),
  //   );
  // }

  // loadTransactions() async {
  //   await context.dispatch<AppState>(
  //     LoginWithMnemonicAction(
  //       mnemonic: bobMnemonic,
  //     ),
  //   );

  //   await context.dispatch<AppState>(
  //     GetNiftiesAction(),
  //   );

  //   await context.dispatch<AppState>(
  //     UpdateTransactionsAction(),
  //   );
  // }

  // updateName() async {
  //   var oldName = "bob";
  //   var newName = "bobnew";

  //   await context.dispatch<AppState>(LoginWithMoralis(
  //     username: oldName,
  //     password: "bobpass",
  //   ));

  //   await context.dispatch<AppState>(
  //     UpdateNameAction(newName),
  //   );

  //   await context.dispatch<AppState>(
  //     UpdateNameAction(oldName),
  //   );
  // }
}

// never return errors from these functions (service classes functions)
// instead caller of the function
// should verify himself that it has been executed correctly
// by proving expected results
// this function just shows logs in case of error
// but returns this non-failing result
// then caller should check that result and expected side effects
// such approach brings more self-awareness to caller code
// because instead of trust to result of function
// it should verify changes itself
// its better because frees this function from following
// the errors protocol and gives it freedom to choose
// the way to handle errors and gives freedom to make mistakes

// builder.setLimit(1);

// does not return all needed fields
// final cloudFunction = ParseCloudFunction('getTransactions');
// final response = await cloudFunction.execute(
//   parameters: {
//     'chain': 'mumbai',
//     'address': address,
//     'order': 'desc',
//   },
// );

// Future.delayed(Duration.zero, () {
//   context.dispatch<AppState>(TransferAction(
//     recipient: "",
//     amount: 0,
//   ));
// });

// Future.delayed(Duration.zero, () {
//   context.dispatch<AppState>(
//     GetNiftiesAction(),
//   );
// });

// Future.delayed(Duration.zero, () {
//   context.dispatch<AppState>(
//     GetTransactionsAction(),
//   );
// });

// Future.delayed(Duration.zero, () async {
// await context.dispatch<AppState>(
//   LoginWithMnemonicAction(
//     mnemonic: bobMnemonic,
//   ),
// );

// await context.dispatch<AppState>(
//   TransferAction(
//     recipient: aliceAddress,
//     amount: 2,
//   ),
// );

// await context.dispatch<AppState>(
//   GetAllUsersAction(),
// );
// });

// Future.delayed(Duration.zero, () async {
// await context.dispatch<AppState>(
//   LoginWithMoralis(
//     username: "bob",
//     password: "bobpass",
//   ),
// );

// controller.jumpToTab(2);

// await context.dispatch<AppState>(
//   LoginWithMoralis(
//     username: "bob",
//     password: "bobpass",
//   ),
// );

// await context.dispatch<AppState>(UpdateNameAction(
//   "bobup1",
// ));
// });

// if (users == null) {
//   log("LoadContactsAction: empty users");
// } else {
//   var contacts = <ContactModel>[];

//   contacts.addAll(context.state.contacts);

//   for (int i = 0; i < users.length; i++) {
//     if (users[i].username != null && users[i].address != "") {
//       if (contacts.any((element) => element.address == users[i].address) ==
//           false) {
//         final contact = ContactModel(
//           manual: false,
//           address: users[i].address,
//           username: users[i].username!,
//         );

//         contacts.add(contact);
//       }
//     }
//   }

//   yield (state) => state.update(
//         contacts: contacts,
//       );
// }

// TransactionModel? transaction;

// while (transaction == null) {
//   final ParseResponse response = await queryBuilder.query();

//   if (response.success) {
//     if (response.results != null && response.results!.isNotEmpty) {
//       final _transaction = response.results!.first as TransactionModel;
//       if (needConfirmed == false || _transaction.confirmed == true) {
//         transaction = _transaction;
//       }
//     }
//   }

//   if (transaction == null) {
//     await sleep(Duration(seconds: 1));
//   }
// }

// return transaction;

// Future<List<TokenModel>?> getNifties({required address}) async {
//   await _client;

//   final cloudFunction = ParseCloudFunction('getNFTs');

//   final response = await cloudFunction.execute(
//     parameters: {
//       'chain': 'mumbai',
//       'address': address,
//     },
//   );

//   if (response.success) {
//     if (response.result is List) {
//       return (response.result as List)
//           .where((item) =>
//               item["token_address"].toLowerCase() ==
//               Config.tokenAddress.toLowerCase())
//           .map((item) => TokenModel.fromJson(item))
//           .toList();
//     }
//   }

//   return null;
// }

// Future<ParseObject?> createToken({
//   required int tokenId,
//   required String tokenName,
//   required int tokenSupply,
//   required String creatorAddress,
// }) async {
//   final tokenObject = ParseObject("TokenDetails");

//   tokenObject.set("token_id", tokenId);
//   tokenObject.set("token_name", tokenName);
//   tokenObject.set("token_supply", tokenSupply);
//   tokenObject.set("creator_address", creatorAddress);

//   final response = await tokenObject.save();

//   if (response.success) {
//     return tokenObject;
//   } else {
//     return null;
//   }
// }

// 0:"block_timestamp" -> Map (2 items)
// key:"block_timestamp"
// value:Map (2 items)
// 1:"hash" -> "0xf7e2c4c697b7fe26bb8cd0ff69d5e292edf7a8c62476c840efd47082d1fd70a3"
// 2:"nonce" -> 7
// 3:"block_hash" -> "0x0cac7b6ac221140143ce7c4d099c2a31ce690cde865894f3d2778786182beb11"
// 4:"block_number" -> 14809707
// 5:"transaction_index" -> 0
// 6:"from_address" -> "0x2aff8e093877c0c92fd7b469784f9abed2cd98d0"
// 7:"to_address" -> "0x3182ead0cee8666b92d3d37fd2f908158447033f"
// 8:"value" -> "1000000000000000"
// 9:"gas_price" -> 20000000000
// 10:"gas" -> 21000
// 11:"input" -> "0x"

// try {
//   var user = ParseUser(
//     "username",
//     "password",
//     "name@gmail.com",
//   );

//   var response = await user.login();

//   if (response.success) {
//     print("user authorized");
//     print(response.result);
//     return;
//   } else {
//     print(response.error?.message);
//   }

//   response = await user.signUp();

//   if (response.success) {
//     print("user registered");
//     print(response.result);
//   } else {
//     print(response.error?.message);
//   }
// } catch (err) {
//   print("onSubmit error: " + err.toString());
//   rethrow;
// }

// Future<UserModel?> login(username) async {
//   UserModel user = UserModel(username, "password", "$username@gmail.com");

//   final ParseResponse signupResponse = await user.signUp();

//   print("signUp status " + signupResponse.statusCode.toString());
//   print("signUp error " + signupResponse.error.toString());

//   if (signupResponse.success) {
//     return signupResponse.result;
//   } else {
//     final ParseResponse loginResponse = await user.login();

//     print("login status: " + loginResponse.statusCode.toString());
//     print("login error " + loginResponse.error.toString());

//     if (loginResponse.success) {
//       return loginResponse.result;
//     }
//   }

//   return null;
// }
