import 'package:fluneumora/all.dart';

class NeumorphicScaffold extends StatelessWidget {
  final Widget child;
  NeumorphicScaffold({required this.child});

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: Spacing.of(context).insets.onlyTop.normal,
          color: baseColor,
          child: child,
        ),
      ),
    );
  }
}
