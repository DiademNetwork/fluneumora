import 'package:fluneumora/all.dart';

class TokenAvatar extends StatelessWidget {
  final TokenDetailsModel tokenDetails;

  TokenAvatar({
    required this.tokenDetails,
  });

  Widget build(_) {
    int tokenColorIdx = 0;
    if (int.tryParse(tokenDetails.tokenId) != null) {
      tokenColorIdx = int.parse(tokenDetails.tokenId) % tokenColors.length;
    }

    final tokenColor = tokenColors[tokenColorIdx];

    return Neumorphic(
      style: NeumorphicStyle(
        boxShape: NeumorphicBoxShape.circle(),
        depth: 1,
      ),
      child: CircleAvatar(
        child: Text(
          tokenDetails.tokenName.substring(0, 1),
          style: TextStyles.title.copyWith(
            fontSize: 36,
            fontWeight: FontWeight.w600,
            color: baseColor,
          ),
        ),
        radius: 36,
        backgroundColor: tokenColor,
        foregroundColor: baseColor,
      ),
    );
  }
}
