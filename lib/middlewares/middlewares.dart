import 'package:fluneumora/all.dart';

extension on Event {
  String asString() {
    var s = this.toString();
    return s.substring(0, s.length - 6).substring(13);
  }
}

extension on Action {
  String asString() {
    var s = this.toString();
    return s.substring(0, s.length - 1).substring(13);
  }
}

Middleware buildErrorMiddleware(BuildContext context) {
  return ErrorHandler<AppState>((appContext, event, initialState, error, st) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text("Error"),
        content: Text("And unexpected error occured and $event failed"),
        actions: [
          TextButton(
            child: Text("OK"),
            onPressed: () {},
          ),
        ],
      ),
    );
    return Event.empty;
  });
}

class EventsMiddleware extends Middleware<AppState> {
  const EventsMiddleware();

  @override
  Stream<AppState> call(
    Context<AppState> context,
    Event event,
    NextMiddleware<AppState> next,
  ) async* {
    await for (final state in next(context, event)) {
      yield state;

      if (event is Action) {
      } else {
        print("<${event.asString()}/>");

        if (event is InitApplicationEvent) {
          // context.dispatch(
          //   LoginWithMnemonicAction(mnemonic: testingMnemonic),
          // );

          // context.dispatch(
          //   GetNiftiesAction(),
          // );
        }
      }

      // if (event is LoginSuccessEvent) {
      //   context.dispatch(
      //     TransferAction(
      //       amount: 0,
      //       recipient: "",
      //     ),
      //   );
      // }

    }
  }
}

class ActionsMiddleware extends Middleware<AppState> {
  const ActionsMiddleware();

  Stream<AppState> call(
    Context<AppState> context,
    Event event,
    NextMiddleware<AppState> next,
  ) async* {
    bool isAction = event is Action;

    if (isAction) log('<${event.asString()}>');

    await for (final state in next(context, event)) {
      yield state;
      if (isAction) log(state.toString());
    }

    if (isAction) log('</${event.asString()}>');
  }
}
