import 'package:fluneumora/all.dart';
import 'package:fluneumora/views/screens/mnemonic_screen.dart';

// ignore: avoid_web_libraries_in_flutter
// import 'dart:html';

class AppView extends StatefulWidget {
  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  late PersistentTabController controller;

  @override
  initState() {
    super.initState();

    controller = PersistentTabController(initialIndex: 1);

    // Future.microtask(() {
    //   final secret = window.location.hash.split('/')[1];

    //   print("secret $secret");

    //   if (secret != "") {
    //     context.dispatch<AppState>(
    //       ReceiveDepositAction(secret: secret),
    //     );
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: NeumorphicApp(
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.light,
        theme: NeumorphicThemeData(
          baseColor: baseColor,
          // textTheme: TextTheme(
          //   font
          // ),
          // textTheme: GoogleFonts.robotoTextTheme().copyWith(
          //     // subtitle1: GoogleFonts.jura(),
          //     // subtitle2: GoogleFonts.jura(),
          //     // headline4: GoogleFonts.jura(),
          //     // headline5: GoogleFonts.jura().copyWith(
          //     //   color: Colors.blue,
          //     // ),
          //     ),
        ),
        builder: (context, child) => Spacing(
          dataBuilder: (context) => SpacingData.generate(10),
          child: child!,
        ),
        initialRoute: "/login",
        routes: {
          "/login": (_) => MnemonicScreen(),
          "/app": (_) => PersistentTabView(
                context,
                controller: controller,
                confineInSafeArea: true,
                screens: [
                  ExploreScreen(),
                  WalletScreen(),
                  ProfileScreen(),
                ],
                items: [
                  PersistentBottomNavBarItem(
                    icon: Image.asset('assets/list-ic.png'),
                    title: "Explore",
                  ),
                  PersistentBottomNavBarItem(
                    icon: Image.asset('assets/wallet-ic.png'),
                    title: "Wallet",
                  ),
                  PersistentBottomNavBarItem(
                    icon: Image.asset('assets/profile-ic.png'),
                    title: "Profile",
                  ),
                ],
                decoration: NavBarDecoration(
                  colorBehindNavBar: Colors.pink,
                ),
                navBarStyle: NavBarStyle.neumorphic,
                backgroundColor: Color(0xffe5e5ec),
              ),
        },
      ),
    );
  }
}
