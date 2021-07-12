import 'package:fluneumora/all.dart';

class TokenCard extends StatefulWidget {
  final TokenDetailsModel tokenDetails;
  final int tokenBalance;

  TokenCard({
    required this.tokenDetails,
    required this.tokenBalance,
  });

  @override
  State<TokenCard> createState() => _TokenCardState();
}

class _TokenCardState extends State<TokenCard> {
  Widget build(BuildContext context) {
    final tokenColor = tokenColors[
        int.parse(widget.tokenDetails.tokenId) % tokenColors.length];

    return Neumorphic(
      style: NeumorphicStyle(
        depth: -3,
        intensity: 0.6,
        color: tokenColor,
      ),
      margin: Spacing.of(context).insets.onlyRight.normal,
      child: SpacedColumn.small(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: Spacing.of(context).insets.onlyBottom.small,
            child: NeumorphicText(
              widget.tokenDetails.tokenName,
              style: NeumorphicStyle(
                color: baseColor,
              ),
              textStyle: TextStyles.tokenName.copyWith(
                fontSize: 20,
              ),
            ),
          ),
          Neumorphic(
            style: NeumorphicStyle(
              boxShape: NeumorphicBoxShape.circle(),
              intensity: 0.3,
              depth: 1,
            ),
            child: TokenAvatar(
              tokenDetails: widget.tokenDetails,
            ),
          ),
          Column(
            children: [
              NeumorphicText(
                "${widget.tokenBalance}",
                style: NeumorphicStyle(
                  color: baseColor,
                ),
                textStyle: TextStyles.tokenBalance,
              ),
              Text(
                "available balance",
                style: TextStyles.address.copyWith(
                  color: baseColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
