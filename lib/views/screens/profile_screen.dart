import 'package:fluneumora/all.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isLoading = false;
  String? newName;
  String? currentName;
  String? userAddress;

  ParseFileBase? avatar;

  bool avatarHasChanged = false;

  void onPressedSaveChanges() async {
    setState(() {
      isLoading = true;
    });

    await context.dispatch<AppState>(
      UpdateUserNameAction(newName!),
    );

    if (avatarHasChanged) {
      context.dispatch<AppState>(
        UpdateUserAvatarAction(avatar: avatar),
      );
    }

    setState(() {
      isLoading = false;
      currentName = context.select((AppState state) => state.user.fullname);
    });
  }

  void onChangedName(value) {
    setState(() {
      newName = value;
    });
  }

  void onTapAddPhoto() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxHeight: 48,
      maxWidth: 48,
    );

    if (pickedFile != null) {
      if (kIsWeb) {
        ParseWebFile file = ParseWebFile(null, name: "", url: pickedFile.path);
        await file.download();
        avatar = ParseWebFile(file.file, name: file.name);
      } else {
        avatar = ParseFile(File(pickedFile.path));
      }

      setState(() {
        avatarHasChanged = true;
      });
    }
  }

  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      currentName = context.select((AppState state) => state.user.fullname);
      avatar = context.select((AppState state) => state.user.avatar);

      setState(() {
        newName = currentName;
        userAddress = context.select((AppState state) => state.user.address);
      });
    });
  }

  void onPressedCopy(value) {
    FlutterClipboard.copy(value);
  }

  Widget build(BuildContext context) {
    return NeumorphicScaffold(
      child: SpacedColumn.semiBig(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: Spacing.of(context).insets.vertical.normal,
            child: Container(
              height: 35,
              padding: Spacing.of(context).insets.horizontal.big,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "My profile",
                    style: TextStyles.title,
                  ),
                  // Container(
                  //   width: 90,
                  //   height: 35,
                  //   child: NeumorphicButton(
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //       children: [
                  //         Text(
                  //           "Save",
                  //           style: TextStyling.button,
                  //         ),
                  //         Icon(Icons.save),
                  //       ],
                  //     ),
                  //     onPressed: onPressedSaveChanges,
                  //   ),
                  // ),
                  if (isLoading) CircularProgressIndicator(),
                  if ((currentName != newName || avatarHasChanged) &&
                      !isLoading)
                    NeumorphicButton(
                      child: Text(
                        "Save changes",
                        style: TextStyles.button,
                      ),
                      onPressed: onPressedSaveChanges,
                    ),
                ],
              ),
            ),
          ),
          // Container(
          //   padding: Spacing.of(context).insets.all.normal,
          //   child: Text(
          //     "Account name",
          //     style: TextStyling.label,
          //   ),
          // ),
          FutureBuilder<ParseFileBase>(
            future: avatar?.download(),
            builder:
                (BuildContext context, AsyncSnapshot<ParseFileBase> snapshot) {
              if (snapshot.hasData) {
                if (kIsWeb) {
                  return Image.memory((snapshot.data as ParseWebFile).file!);
                } else {
                  return Neumorphic(
                    style: NeumorphicStyle(
                      depth: -2,
                      intensity: 0.5,
                      boxShape: NeumorphicBoxShape.circle(),
                    ),
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage: FileImage(
                        (snapshot.data as ParseFile).file!,
                      ),
                    ),
                  );
                }
              } else {
                return NeumorphicButton(
                  onPressed: onTapAddPhoto,
                  padding: Spacing.of(context).insets.all.big,
                  style: NeumorphicStyle(
                    depth: -2,
                    intensity: 0.5,
                    boxShape: NeumorphicBoxShape.circle(),
                  ),
                  child: NeumorphicIcon(
                    Icons.add_a_photo,
                    style: NeumorphicStyle(
                      intensity: 0.85,
                      depth: 1,
                    ),
                    size: 100,
                  ),
                );
              }
            },
          ),
          if (newName != null)
            Padding(
              padding: Spacing.of(context).insets.horizontal.normal,
              child: Neumorphic(
                margin: Spacing.of(context).insets.horizontal.big,
                padding: Spacing.of(context).insets.vertical.semiBig,
                style: NeumorphicStyle(
                  depth: -4,
                  intensity: 0.9,
                ),
                child: Padding(
                  padding: Spacing.of(context).insets.horizontal.semiBig,
                  child: TextEdited(
                    text: newName!,
                    builder: (context, controller) => TextField(
                      controller: controller,
                      decoration: InputDecoration(
                        prefixText: "Full Name   ",
                        hintText: "Full Name",
                        hintStyle: TextStyles.hint,
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                      ),
                      showCursor: true,
                      style: TextStyles.input,
                      onChanged: onChangedName,
                    ),
                  ),
                ),
              ),
            ),

          Container(
            height: 55,
            padding: Spacing.of(context).insets.horizontal.normal,
            margin: Spacing.of(context).insets.horizontal.big,
            child: AnimatedSwitcher(
              duration: Duration(seconds: 1),
              child: userAddress != null
                  ? SpacedRow.normal(
                      children: [
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
                                      "share you address to receive tokens",
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
                                    userAddress!,
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
                            userAddress,
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
        ],
      ),
    );
  }
}

// class FormSample extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return NeumorphicTheme(
//       theme: NeumorphicThemeData(
//         defaultTextColor: Color(0xFF3E3E3E),
//         accentColor: Colors.grey,
//         variantColor: Colors.black38,
//         depth: 8,
//         intensity: 0.65,
//       ),
//       themeMode: ThemeMode.light,
//       child: Material(
//         child: NeumorphicBackground(
//           child: _Page(),
//         ),
//       ),
//     );
//   }
// }

// class _Page extends StatefulWidget {
//   @override
//   __PageState createState() => __PageState();
// }

// enum Gender { MALE, FEMALE, NON_BINARY }

// class __PageState extends State<_Page> {
//   String firstName = "";
//   String lastName = "";
//   double age = 12;
//   Gender gender = Gender.MALE;
//   Set<String> rides = Set();

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             // Container(
//             //   margin: EdgeInsets.only(left: 12, right: 12, top: 10),
//             //   child: TopBar(
//             //     actions: <Widget>[
//             //       ThemeConfigurator(),
//             //     ],
//             //   ),
//             // ),
//             Neumorphic(
//               margin: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//               padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//               style: NeumorphicStyle(
//                 boxShape:
//                     NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
//               ),
//               child: Column(
//                 children: <Widget>[
//                   SizedBox(
//                     height: 8,
//                   ),
//                   Align(
//                     alignment: Alignment.centerRight,
//                     child: NeumorphicButton(
//                       onPressed: _isButtonEnabled() ? () {} : null,
//                       padding:
//                           EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//                       child: Text(
//                         "Sign Up",
//                         style: TextStyle(fontWeight: FontWeight.w800),
//                       ),
//                     ),
//                   ),
//                   _AvatarField(),
//                   SizedBox(
//                     height: 8,
//                   ),
//                   _TextField(
//                     label: "First name",
//                     hint: "",
//                     onChanged: (firstName) {
//                       setState(() {
//                         this.firstName = firstName;
//                       });
//                     },
//                   ),
//                   SizedBox(
//                     height: 8,
//                   ),
//                   _TextField(
//                     label: "Last name",
//                     hint: "",
//                     onChanged: (lastName) {
//                       setState(() {
//                         this.lastName = lastName;
//                       });
//                     },
//                   ),
//                   SizedBox(
//                     height: 8,
//                   ),
//                   _AgeField(
//                     age: this.age,
//                     onChanged: (age) {
//                       setState(() {
//                         this.age = age;
//                       });
//                     },
//                   ),
//                   SizedBox(
//                     height: 8,
//                   ),
//                   _GenderField(
//                     gender: gender,
//                     onChanged: (gender) {
//                       setState(() {
//                         this.gender = gender;
//                       });
//                     },
//                   ),
//                   SizedBox(
//                     height: 8,
//                   ),
//                   /*
//                   _RideField(
//                     rides: this.rides,
//                     onChanged: (rides) {
//                       setState(() {
//                         this.rides = rides;
//                       });
//                     },
//                   ),
//                   SizedBox(
//                     height: 28,
//                   ),
//                    */
//                   SizedBox(
//                     height: 20,
//                   ),
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   bool _isButtonEnabled() {
//     return this.firstName.isNotEmpty && this.lastName.isNotEmpty;
//   }
// }

// class _AvatarField extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Neumorphic(
//         padding: EdgeInsets.all(10),
//         style: NeumorphicStyle(
//           boxShape: NeumorphicBoxShape.circle(),
//           depth: NeumorphicTheme.embossDepth(context),
//         ),
//         child: Icon(
//           Icons.insert_emoticon,
//           size: 120,
//           color: Colors.black.withOpacity(0.2),
//         ),
//       ),
//     );
//   }
// }

// class _AgeField extends StatelessWidget {
//   final double age;
//   final ValueChanged<double> onChanged;

//   _AgeField({required this.age, required this.onChanged});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: <Widget>[
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
//           child: Text(
//             "Age",
//             style: TextStyle(
//               fontWeight: FontWeight.w700,
//               color: NeumorphicTheme.defaultTextColor(context),
//             ),
//           ),
//         ),
//         Row(
//           children: <Widget>[
//             Flexible(
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 18.0),
//                 child: NeumorphicSlider(
//                   min: 8,
//                   max: 75,
//                   value: this.age,
//                   onChanged: (value) {
//                     this.onChanged(value);
//                   },
//                 ),
//               ),
//             ),
//             Text("${this.age.floor()}"),
//             SizedBox(
//               width: 18,
//             )
//           ],
//         ),
//       ],
//     );
//   }
// }

// class _TextField extends StatefulWidget {
//   final String label;
//   final String hint;

//   final ValueChanged<String> onChanged;

//   _TextField(
//       {required this.label, required this.hint, required this.onChanged});

//   @override
//   __TextFieldState createState() => __TextFieldState();
// }

// class __TextFieldState extends State<_TextField> {
//   late TextEditingController _controller;

//   @override
//   void initState() {
//     _controller = TextEditingController(text: widget.hint);
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: <Widget>[
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
//           child: Text(
//             this.widget.label,
//             style: TextStyle(
//               fontWeight: FontWeight.w700,
//               color: NeumorphicTheme.defaultTextColor(context),
//             ),
//           ),
//         ),
//         Neumorphic(
//           margin: EdgeInsets.only(left: 8, right: 8, top: 2, bottom: 4),
//           style: NeumorphicStyle(
//             depth: -4,
//             intensity: 1,
//             boxShape: NeumorphicBoxShape.stadium(),
//           ),
//           padding: EdgeInsets.symmetric(vertical: 14, horizontal: 18),
//           child: TextField(
//             onChanged: this.widget.onChanged,
//             controller: _controller,
//             decoration: InputDecoration.collapsed(hintText: this.widget.hint),
//           ),
//         )
//       ],
//     );
//   }
// }

// class _GenderField extends StatelessWidget {
//   final Gender gender;
//   final ValueChanged<Gender> onChanged;

//   const _GenderField({
//     required this.gender,
//     required this.onChanged,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: <Widget>[
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
//           child: Text(
//             "Gender",
//             style: TextStyle(
//               fontWeight: FontWeight.w700,
//               color: NeumorphicTheme.defaultTextColor(context),
//             ),
//           ),
//         ),
//         Row(
//           children: <Widget>[
//             SizedBox(width: 12),
//             NeumorphicRadio(
//               groupValue: this.gender,
//               padding: EdgeInsets.all(20),
//               style: NeumorphicRadioStyle(
//                 boxShape: NeumorphicBoxShape.circle(),
//               ),
//               value: Gender.MALE,
//               child: Icon(Icons.account_box),
//               onChanged: (Gender? value) => this.onChanged(value!),
//             ),
//             SizedBox(width: 12),
//             NeumorphicRadio(
//               groupValue: this.gender,
//               padding: EdgeInsets.all(20),
//               style: NeumorphicRadioStyle(
//                 boxShape: NeumorphicBoxShape.circle(),
//               ),
//               value: Gender.FEMALE,
//               child: Icon(Icons.pregnant_woman),
//               onChanged: (Gender? value) => this.onChanged(value!),
//             ),
//             SizedBox(width: 12),
//             NeumorphicRadio(
//               groupValue: this.gender,
//               padding: EdgeInsets.all(20),
//               style: NeumorphicRadioStyle(
//                 boxShape: NeumorphicBoxShape.circle(),
//               ),
//               value: Gender.NON_BINARY,
//               child: Icon(Icons.supervised_user_circle),
//               onChanged: (Gender? value) => this.onChanged(value!),
//             ),
//             SizedBox(
//               width: 18,
//             )
//           ],
//         ),
//       ],
//     );
//   }
// }
