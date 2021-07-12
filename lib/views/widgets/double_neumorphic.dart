import 'package:fluneumora/all.dart';

class DoubleNeumorphic extends StatelessWidget {
  final Widget child;

  DoubleNeumorphic({
    required this.child,
  });

  Widget build(BuildContext context) {
    return Neumorphic(
      style: NeumorphicStyle(
        depth: 1,
        intensity: 0.5,
        lightSource: LightSource.bottomRight,
      ),
      child: Neumorphic(
        style: NeumorphicStyle(
          depth: -2,
          intensity: 0.5,
          lightSource: LightSource.bottomRight,
        ),
        child: child,
      ),
    );
  }
}
