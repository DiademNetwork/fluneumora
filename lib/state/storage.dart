import 'dart:convert';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

import 'package:fluneumora/all.dart';

class AppStateStorage extends StateStorage<AppState> {
  final storageKey = "AppState";

  html.Storage get localStorage => html.window.localStorage;

  Future<void> save(AppState state) async {
    final stateJsonEncoded = jsonEncode({
      'user': state.user,
    });

    localStorage.update(storageKey, (val) => stateJsonEncoded,
        ifAbsent: () => stateJsonEncoded);
  }

  Future<AppState?> load() async {
    try {
      final data = localStorage.entries.firstWhere((i) => i.key == storageKey);

      final Map<String, dynamic> stateJson = jsonDecode(data.value);

      return AppState(
        maybeUser: MaybeUserModel.existing(stateJson['user']),
        currentTransaction: stateJson['currentTransaction'],
      );
    } on StateError {
      log("state is not present in local storage");
      return null;
    }
  }

  Future<void> clear() async {
    localStorage.remove(storageKey);
  }
}
