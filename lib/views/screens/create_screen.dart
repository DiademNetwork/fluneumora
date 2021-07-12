// import 'package:fluneumora/all.dart';

// class CreateScreen extends StatefulWidget {
//   @override
//   State<CreateScreen> createState() => _CreateScreenState();
// }

// class _CreateScreenState extends State<CreateScreen> {
//   String tokenName = "";

//   int tokenSupply = 0;

//   void onPressedCreate() async {
//     if (tokenName == "") return;

//     if (tokenSupply == 0) return;

//     context.dispatch<AppState>(
//       CreateTokenAction(
//         tokenName: tokenName,
//         tokenSupply: tokenSupply,
//       ),
//     );

//     pushNewScreen(
//       context,
//       screen: TransactionScreen(),
//     );
//   }

//   void onChangedName(value) {
//     setState(() {
//       tokenName = value;
//     });
//   }

//   void onChangedSupply(value) {
//     setState(() {
//       tokenSupply = value;
//     });
//   }

//   Widget build(BuildContext context) {
//     return NeumorphicScaffold(
//       child: SpacedColumn.semiBig(
//         children: [
//           Container(
//             padding: Spacing.of(context).insets.onlyLeft.big,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   "Create new asset",
//                   style: TextStyles.title,
//                 ),
//                 NeumorphicButton(
//                   onPressed: onPressedCreate,
//                   child: Icon(Icons.send),
//                 ),
//               ],
//             ),
//           ),
//           TextEdited(
//             text: '',
//             builder: (context, controller) => Neumorphic(
//               margin: Spacing.of(context).insets.all.normal,
//               padding: Spacing.of(context).insets.all.normal,
//               style: NeumorphicStyle(
//                 depth: -4,
//                 intensity: 1,
//               ),
//               child: TextField(
//                 onChanged: onChangedName,
//                 controller: controller,
//                 decoration: InputDecoration(
//                   border: InputBorder.none,
//                   hintText: "Choose Asset Name",
//                 ),
//               ),
//             ),
//           ),
//           TextEdited(
//             text: '',
//             builder: (context, controller) => Neumorphic(
//               child: TextField(
//                 keyboardType: TextInputType.number,
//                 controller: controller,
//                 onChanged: onChangedSupply,
//                 decoration: InputDecoration(
//                   border: InputBorder.none,
//                   hintText: "Choose Asset Supply",
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
