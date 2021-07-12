import 'package:fluneumora/all.dart';

class FlatBackButton extends StatelessWidget {
  final Function() onPressed;

  FlatBackButton({
    required this.onPressed,
  });

  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: 56,
        height: 48,
        padding: Spacing.of(context).insets.all.normal,
        child: Image.asset("assets/back-ic.png", width: 16),
      ),
    );
  }
}
