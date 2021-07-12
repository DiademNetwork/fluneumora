import 'package:fluneumora/all.dart';
// import 'package:fluneumora/state/storage.dart';

void log(msg) {
  Logger.root.info(msg);
}

void main() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((LogRecord record) {
    print(record.message.toString());

    if (record.error != null) print(record.error);

    if (record.stackTrace != null) print(record.stackTrace);
  });

  runApp(FluneumoraApp());
}

class FluneumoraApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Fountain(
      initialState: (_) => AppState(
        currentTransaction: TransactionState.none(),
        maybeUser: MaybeUserModel.none(),
      ),
      services: [
        Service<AppState, WalletService>(
          builder: (context) => WalletService(),
        ),
        Service<AppState, MoralisService>(
          builder: (context) => MoralisService(),
        ),
      ],
      middlewares: [
        // buildErrorMiddleware(context),
        ActionsMiddleware(),
        EventsMiddleware(),
        // if (kIsWeb)
        //   Persistence(
        //     storage: AppStateStorage(),
        //   ),
        ...Fountain.defaultMiddlewares<AppState>(),
      ],
      child: Builder(
        builder: (BuildContext context) {
          if (context.select((AppState state) => state.isInitialized) == true) {
            return AppView();
          } else {
            return SplashView();
          }
        },
      ),
    );
  }
}
