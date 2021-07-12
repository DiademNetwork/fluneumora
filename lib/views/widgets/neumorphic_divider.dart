import 'package:fluneumora/all.dart';

class NeumorphicDivider extends StatelessWidget {
  Widget build(_) {
    return Neumorphic(
      style: NeumorphicStyle(
        depth: 1,
        intensity: 0.5,
        lightSource: LightSource.bottom,
      ),
      child: Neumorphic(
        style: NeumorphicStyle(
          depth: -2,
          intensity: 0.5,
          lightSource: LightSource.top,
        ),
        child: Divider(
          height: 1,
          color: Color(0xffe5e5ec),
        ),
      ),
    );
  }
}
