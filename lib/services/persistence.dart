import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snackautomat_2502/domain/state/app_state.dart';

/// Loads the app state from the database
Future<AppState?> loadAppState() async {
  try {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_appStateKey);
    if (jsonString == null) return null;
    final jsonMap = jsonDecode(jsonString);
    return AppState.fromJson(
      jsonMap as Map<String, dynamic>,
    ).copyWith(displayMessage: () => null);
  } on Exception catch (e) {
    debugPrint('Fehler beim Laden des AppState: $e');
    return null;
  }
}

const String _appStateKey = 'app_state';

/// Saves the app state into the database
Future<void> saveAppState(AppState state) async {
  try {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(state.toJson());
    await prefs.setString(_appStateKey, jsonString);
  } on Exception catch (e) {
    // Optional: Logging oder Fehlerhandling
    debugPrint('Fehler beim Speichern des AppState: $e');
  }
}
