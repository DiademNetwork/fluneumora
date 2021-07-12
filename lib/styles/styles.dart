import 'package:fluneumora/all.dart';

final baseColor = Color(0xffe5e5ec);
final secondaryColor = Color(0xff676787);
final subColor = Color(0xff86869b);

final completeColor = Color(0xff6dbfba);
final inProgressColor = Color(0xffbbbbd2);
final todoColor = Color(0xffe47a7d);

final tokenColors = [
  Color(0xff8d83c2),
  Color(0xff69abbc),
  Color(0xff97bd79),
  Color(0xffbfa861),
  Color(0xffc6876c),
  Color(0xff6b7fab),
  Color(0xffa7ab6b),
];

class TextStyles {
  static final title = TextStyle(
    fontFamily: "EvolveSans",
    fontSize: 22,
    fontWeight: FontWeight.w700,
    color: secondaryColor,
  );

  static final hint = TextStyle(
    fontFamily: "EvolveSans",
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: subColor,
  );

  static final name = TextStyle(
    fontFamily: "EvolveSans",
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: subColor,
  );

  static final address = TextStyle(
    fontFamily: "EvolveSans",
    fontSize: 11,
    fontWeight: FontWeight.w200,
    color: subColor,
  );

  static final subtitle = TextStyle(
    fontFamily: "EvolveSans",
    fontSize: 12,
    fontWeight: FontWeight.w200,
    color: secondaryColor, //Color(0xacacc2),
  );

  static final button = TextStyle(
    fontFamily: "EvolveSans",
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: secondaryColor,
  );

  static final label = hint;

  static final input = hint;

  static final tokenName = NeumorphicTextStyle(
    fontFamily: "EvolveSans",
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );

  static final placeholder = TextStyle(
    fontFamily: "EvolveSans",
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Color(0xffacacc2),
  );

  static final trx1 = TextStyle(
    color: Color(0xff8686a3),
    fontFamily: "EvolveSans",
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );

  static final trx2 = TextStyle(
    color: Color(0xff8686a3), // Color(0xff43436b),
    fontFamily: "EvolveSans",
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );

  static final trx2up = TextStyle(
    color: Color(0xff8686a3), // Color(0xff43436b),
    fontFamily: "EvolveSans",
    fontSize: 14,
    fontWeight: FontWeight.w600,
  );

  static final trx2down = TextStyle(
    color: Color(0xff8686a3), // Color(0xff43436b),
    fontFamily: "EvolveSans",
    fontSize: 12,
    fontWeight: FontWeight.w600,
  );

  static final trx2double = TextStyle(
    color: Color(0xff8686a3), // Color(0xff43436b),
    fontFamily: "EvolveSans",
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );

  static final trx3minus = TextStyle(
    color: Color(0xffca8e70),
    fontFamily: "EvolveSans",
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );

  static final trx3plus = TextStyle(
    color: Color(0xff43a49f),
    fontFamily: "EvolveSans",
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );

  static final trx3neutral = TextStyle(
    color: Color(0xff8686a3),
    fontFamily: "EvolveSans",
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );

  static final tokenBalance = NeumorphicTextStyle(
    fontFamily: "EvolveSans",
    fontSize: 24,
    fontWeight: FontWeight.w600,
  );
}
