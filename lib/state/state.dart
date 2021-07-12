import 'package:fluneumora/all.dart';

class AppState extends Equatable {
  AppState({
    this.previous,
    this.isInitialized = true,
    this.userPrivateKey = "",
    this.userAddress = "0x3182EAd0ceE8666B92D3D37fd2F908158447033f",
    this.walletTokenId = "1",
    this.isLoadingAssets = false,
    this.isLoadingTransactions = false,
    this.tokens = const [],
    this.transactions = const {},
    this.response = "",
    required this.maybeUser,
    // this.transactionHash = "",
    // this.currencies = const [],
    this.contacts = const [],
    // this.walletCurrencyIndex = 0,
    // this.currencyTransactions = const [],
    // this.currencyBalances = const [],
    // this.transactionStep = TransactionStep.initial,
    this.balances = const {},
    this.owners = const {},
    // this.transactionUserTo,
    // this.transactionAmount,
    // this.transactionTokenName,
    // this.transactionTokenDetails,
    // this.transactionDeposit,
    required this.currentTransaction,
    this.depositSecret = "",
  });

  AppState update({
    isInitialized,
    userPrivateKey,
    userAddress,
    walletTokenId,
    isLoadingAssets,
    isLoadingTransactions,
    tokens,
    transactions,
    testing,
    // response,
    user,
    transactionHash,
    currencies,
    contacts,
    // walletCurrencyIndex,
    // currencyTransactions,
    // currencyBalances,
    // transactionStep,
    balances,
    owners,
    transactionUserTo,
    transactionAmount,
    transactionTokenName,
    transactionTokenDetails,
    transactionDeposit,
    currentTransaction,
    depositSecret,
  }) {
    return AppState(
      previous: this,
      isInitialized: isInitialized ?? this.isInitialized,
      userPrivateKey: userPrivateKey ?? this.userPrivateKey,
      userAddress: userAddress ?? this.userAddress,
      walletTokenId: walletTokenId ?? this.walletTokenId,
      isLoadingAssets: isLoadingAssets ?? this.isLoadingAssets,
      isLoadingTransactions:
          isLoadingTransactions ?? this.isLoadingTransactions,
      tokens: tokens ?? this.tokens,
      transactions: transactions ?? this.transactions,
      // response: response ?? this.response,
      maybeUser: user != null ? MaybeUserModel.existing(user) : this.maybeUser,
      // transactionHash: transactionHash ?? this.transactionHash,
      // currencies: currencies ?? this.currencies,
      contacts: contacts ?? this.contacts,
      // walletCurrencyIndex: walletCurrencyIndex ?? this.walletCurrencyIndex,
      // currencyTransactions: currencyTransactions ?? this.currencyTransactions,
      // currencyBalances: currencyBalances ?? this.currencyBalances,
      // transactionStep: transactionStep ?? this.transactionStep,
      balances: balances ?? this.balances,
      owners: owners ?? this.owners,
      // transactionUserTo: transactionUserTo ?? this.transactionUserTo,
      // transactionAmount: transactionAmount ?? this.transactionAmount,
      // transactionTokenName: transactionTokenName ?? this.transactionTokenName,
      // transactionTokenDetails:
      //     transactionTokenDetails ?? this.transactionTokenDetails,
      // transactionDeposit: transactionDeposit ?? this.transactionDeposit,
      currentTransaction: currentTransaction ?? this.currentTransaction,
      depositSecret: depositSecret ?? this.depositSecret,
    );
  }

  @override
  List<Object> get props => [
        isInitialized,
        userPrivateKey,
        userAddress,
        walletTokenId,
        isLoadingAssets,
        isLoadingTransactions,
        tokens,
        transactions,
        maybeUser,
        balances,
        owners,
        currentTransaction,
        depositSecret,

        // contacts,
        // tokensCount,
        // transactionsCount,
        // response,
        // isAuthorized,
        // transactionHash,
        // username,
        // currenciesCount,
        // contactsCount,
        // walletCurrencyIndex,
        // walletCurrencyTransactionsCount,
        // walletCurrencyBalance,
        // transactionStep,
        // walletTokenBalance,
        // ownersCount,
        // existingTransactionUserTo,
        // existingTransactionDeposit,
        // currentTransaction
      ];

  final List<Function> labels = [
    (prev, cur) => "isInitialized: $prev => $cur",
    (previous, current) => "userPrivateKey: $previous => $current",
    (previous, current) => "userAddress: $previous => $current",
    (previous, current) => "walletTokenId: $previous => $current",
    (previous, current) => "isLoadingAssets: $previous => $current",
    (previous, current) => "isLoadingTransactions: $previous => $current",
    (previous, current) => "tokens: ${previous?.length} => ${current?.length}",
    (previous, current) =>
        "transactions: ${previous?.length} => ${current?.length}",
    (previous, current) =>
        "maybeUser: ${previous.user != null} => ${current.user != null}",
    (previous, current) =>
        "balances: ${previous?.length} => ${current?.length}",
    (previous, current) => "owners: ${previous?.length} => ${current?.length}",
    (previous, current) =>
        "currentTransaction: ${previous?.transactionStep} => ${current?.transactionStep}",
    (previous, current) => "depositSecret:  $previous => $current",
    // "isInitialized",
    // "userPrivateKey",
    // "userAddress",
    // "walletTokenId",
    // "isLoadingAssets",
    // "isLoadingTransactions",
    // "tokens",
    // "transactions",
    // "user"
    // "tokensCount",
    // "transactionsCount",
    // "response",
    // "isAuthorized",
    // "transactionHash",
    // "username",
    // "currenciesCount",
    // "contactsCount",
    // "walletCurrencyIndex",
    // "walletCurrencyTransactionsCount",
    // "walletCurrencyBalance",
    // "transactionStep",
    // "walletTokenBalance",
    // "ownersCount",
    // "existingTransactionUserTo",
    // "existingTransactionDeposit",
    // "currentTransaction"
  ];

  @override
  String toString() {
    AppState prev = previous!;

    var result = "";

    for (var i = 0; i < props.length; i++) {
      final currentValue = props[i];

      final previousValue = prev.props[i];

      final label = labels[i](previousValue, currentValue);

      if (currentValue != previousValue) {
        result += "$label \n";
      }
    }

    if (result == "") return "--- state not changed ---";

    return result;
  }

  // @override
  // String toString() {
  //   AppState prev = previous!;

  //   var result = "";

  //   for (var i = 0; i < labels.length; i++) {
  //     final valueLabel = labels[i];

  //     final currentValue = props[i];

  //     final previousValue = prev.props[i];

  //     if (currentValue != previousValue) {
  //       result += "$previousValue => $currentValue ($valueLabel) \n";
  //     }
  //   }

  //   if (result == "") return "the same state?!";

  //   return result;
  // }

  final TransactionState currentTransaction;

  final AppState? previous;

  final String depositSecret;

  final bool isInitialized;

  final String userPrivateKey;

  final String userAddress;

  final String walletTokenId;

  final List<TokenDetailsModel> tokens;

  final Map<String, List<TransactionModel>?> transactions;

  final Map<String, int> balances;

  final Map<String, List<UserModel>> owners;

  final bool isLoadingAssets;

  final bool isLoadingTransactions;

  final dynamic response;

  final MaybeUserModel maybeUser;

  UserModel get user => maybeUser.user!;

  // final String transactionHash;

  // final TokenDetailsModel? transactionTokenDetails;

  // final List<CurrencyModel> currencies;

  final List<UserModel> contacts;

  // final int walletCurrencyIndex;

  // final List<List<CurrencyTransactionModel>> currencyTransactions;

  // final List<CurrencyBalanceModel> currencyBalances;

  // final TransactionStep transactionStep;

  // final UserModel? transactionUserTo;

  // bool get existingTransactionUserTo => transactionUserTo != null;

  // final int? transactionAmount;

  // final String? transactionTokenName;

  // final DepositModel? transactionDeposit;

  // bool get existingTransactionDeposit => transactionDeposit != null;

  // int get walletCurrencyTransactionsCount =>
  //     currencyTransactions[walletCurrencyIndex].length;

  // CurrencyBalanceModel get walletCurrencyBalance =>
  //     currencyBalances[walletCurrencyIndex];

  // int get currenciesCount => currencies.length;

  int get walletTokenBalance => balances[walletTokenId] ?? 0;

  int get transactionsCount => transactions[walletTokenId]?.length ?? 0;

  int get contactsCount => contacts.length;

  int get tokensCount => tokens.length;

  int get ownersCount => owners[walletTokenId]?.length ?? 0;

  // bool get isAuthorized => user.username != null;

  // String get username => user.username ?? "";
}

// class CurrencyTransactionModel {}

// class CurrencyBalanceModel {}
