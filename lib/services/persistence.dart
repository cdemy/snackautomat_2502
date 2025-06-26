import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snackautomat_2502/domain/state/app_state.dart';

const String _appStateKey = 'app_state';

Future<void> saveAppState(AppState state) async {
  try {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(state.toJson());
    await prefs.setString(_appStateKey, jsonString);
  } catch (e) {
    // Optional: Logging oder Fehlerhandling
    print("Fehler beim Speichern des AppState: $e");
  }
}

Future<AppState?> loadAppState() async {
  try {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_appStateKey);
    if (jsonString == null) return null;
    final jsonMap = jsonDecode(jsonString);
    return AppState.fromJson(jsonMap);
  } catch (e) {
    print("Fehler beim Laden des AppState: $e");
    return null;
  }
}
