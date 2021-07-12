import 'package:fluneumora/all.dart';

class UserAvatar extends StatelessWidget {
  final UserModel user;

  UserAvatar({
    required this.user,
  });

  Widget build(_) {
    return Neumorphic(
      style: NeumorphicStyle(
        boxShape: NeumorphicBoxShape.circle(),
        depth: 1,
      ),
      child: CircleAvatar(
        child: Text(user.address.substring(0, 1)),
        radius: 48,
        backgroundColor: Colors.transparent,
        foregroundColor: secondaryColor,
      ),
    );
  }
}
