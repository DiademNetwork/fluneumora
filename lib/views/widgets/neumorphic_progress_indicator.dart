import 'package:fluneumora/all.dart';

class NeumorphicProgressIndicator extends StatelessWidget {
  Widget build(_) {
    return Neumorphic(
      style: NeumorphicStyle(
        depth: -1,
        intensity: 0.5,
        boxShape: NeumorphicBoxShape.circle(),
      ),
      child: CircularProgressIndicator(),
    );
  }
}
