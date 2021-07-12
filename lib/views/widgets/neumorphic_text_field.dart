import 'package:fluneumora/all.dart';

class NeumorphicTextField extends StatelessWidget {
  final String initialValue;
  final String hintText;
  final Function(String) onChanged;
  final bool isNumeric;

  NeumorphicTextField({
    required this.initialValue,
    required this.onChanged,
    required this.hintText,
    this.isNumeric = false,
  });

  Widget build(BuildContext context) {
    return Padding(
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
            text: initialValue,
            builder: (context, controller) => TextField(
              keyboardType:
                  isNumeric ? TextInputType.number : TextInputType.text,
              controller: controller,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyles.hint,
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
              ),
              showCursor: true,
              style: TextStyles.input,
              onChanged: onChanged,
            ),
          ),
        ),
      ),
    );
  }
}
