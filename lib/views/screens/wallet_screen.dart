import 'package:fluneumora/all.dart';

class WalletScreen extends StatefulWidget {
  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  @override
  void initState() {
    super.initState();

    // Future.microtask(() {
    //   context.dispatch<AppState>(
    //     MaybeAcceptDepositAction(),
    //   );
    // });

    nextTick(() async {
      final test = Test(context: context);

      // await test.loadTokens();

      // await test.transferToken();

      // await test.transferDeposit();

      // await test.createToken();
    });

    Future.microtask(
      () {
        if (context.select((AppState state) => state.userPrivateKey).isEmpty) {
          Navigator.of(context).pushReplacementNamed("/login");
        }
      },
    );
  }

  void onPressedCreate() {
    pushNewScreen(
      context,
      screen: CreateTokenScreen(),
    );
  }

  Widget build(BuildContext context) {
    final tokens = context.select((AppState state) => state.tokens);
    // final isLoadingAssets =
    //     context.select((AppState state) => state.isLoadingAssets);
    // final isLoadingTransactions =
    //     context.select((AppState state) => state.isLoadingTransactions);
    final transactions = context.select(
      (AppState state) => state.transactions[state.walletTokenId],
    );
    final userAddress = context.select((AppState state) => state.userAddress);

    return NeumorphicScaffold(
      child: EasyRefresh(
        onRefresh: () async {
          await context.dispatch<AppState>(
            LoadTokensAction(),
          );
        },
        child: SingleChildScrollView(
          child: SpacedColumn.semiBig(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: Spacing.of(context).insets.vertical.normal,
                child: Padding(
                  padding: Spacing.of(context).insets.horizontal.big,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // NeumorphicProgressIndicator(),
                      Expanded(
                        child: Text(
                          "My assets",
                          style: TextStyles.title,
                        ),
                      ),
                      Container(
                        child: NeumorphicButton(
                          child: Text(
                            "Create",
                            style: TextStyles.button,
                          ),
                          onPressed: onPressedCreate,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              AnimatedContainer(
                duration: Duration(milliseconds: 200),
                height: 180,
                width: MediaQuery.of(context).size.width,
                child: tokens.isNotEmpty
                    ? Column(
                        children: [
                          if (tokens.isNotEmpty)
                            Expanded(
                              child: Paged(
                                initialPage: 0,
                                viewportFraction: 0.8,
                                builder: (BuildContext context,
                                    PageController value) {
                                  return PageView(
                                    onPageChanged: (int index) {
                                      context.dispatch<AppState>(
                                        ChangeCurrentTokenAction(
                                          tokenId: tokens[index].tokenId,
                                        ),
                                      );
                                    },
                                    controller: value,
                                    children: [
                                      for (var i = 0; i < tokens.length; i++)
                                        TokenCard(
                                          tokenDetails: tokens[i],
                                          tokenBalance: context.select(
                                              (AppState state) =>
                                                  state.walletTokenBalance),
                                        ),
                                    ],
                                  );
                                },
                              ),
                            ),
                        ],
                      )
                    : Column(
                        children: [
                          Container(
                            height: 180,
                            width: MediaQuery.of(context).size.width,
                            margin:
                                Spacing.of(context).insets.horizontal.normal,
                            child: DoubleNeumorphic(
                              child: Center(
                                child: Text(
                                  "created and received assets will be shown here",
                                  style: TextStyles.placeholder,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
              ),
              Container(
                padding: Spacing.of(context).insets.horizontal.big,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // if (isLoadingTransactions) NeumorphicProgressIndicator(),
                    Expanded(
                      child: Text(
                        "My transactions",
                        style: TextStyles.title,
                      ),
                    ),
                    if (tokens.length > 0)
                      NeumorphicButton(
                        child: Text(
                          "Transfer",
                          style: TextStyles.button,
                        ),
                        onPressed: () => pushNewScreen(
                          context,
                          screen: TransferUserScreen(),
                        ),
                      ),
                  ],
                ),
              ),
              Container(
                padding: Spacing.of(context).insets.horizontal.big,
                child: DoubleNeumorphic(
                  child: Column(
                    children: [
                      if (transactions != null && transactions.length > 0)
                        for (int i = 0; i < transactions.length; i++)
                          TransactionTile(
                            userAddress: userAddress,
                            transaction: transactions[i],
                          )
                      else
                        Container(
                          height: 360,
                        )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
