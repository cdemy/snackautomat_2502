import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:snackautomat_2502/models/snack.dart';
import 'package:snackautomat_2502/models/coinstack.dart';
import 'package:snackautomat_2502/domain/state/app_state.dart';

class DatabaseSimulator {
  static const String _initialStateJson = '''
{
  "availableSnacks": [
    {"id": "1", "name": "Haribo", "price": 120, "quantity": 8},
    {"id": "2", "name": "Knoppers", "price": 250, "quantity": 5},
    {"id": "3", "name": "Erdnuss", "price": 100, "quantity": 8},
    {"id": "4", "name": "Milka", "price": 200, "quantity": 12},
    {"id": "5", "name": "Paprika chips", "price": 100, "quantity": 7},
    {"id": "6", "name": "Paulaner spezi", "price": 230, "quantity": 9},
    {"id": "7", "name": "Potato chips", "price": 200, "quantity": 4},
    {"id": "8", "name": "Sour cream onion chips", "price": 250, "quantity": 15},
    {"id": "9", "name": "Tuc cracker", "price": 150, "quantity": 6}
  ],
  "input": {},
  "output": {},
  "machine": {
    "10": 50,
    "20": 50,
    "50": 50,
    "100": 50,
    "200": 50
  }
}
''';

  static Future<AppState> getInitialAppState() async {
    // Simulate network delay between 500-1500ms
    final random = Random();
    final delay = 500 + random.nextInt(1000); // Random between 500-1500ms
    print("Simulating database delay of $delay milliseconds...");
    await Future.delayed(Duration(milliseconds: delay));
    print("Database delay completed, parsing initial state...");
    // Parse JSON string and create AppState from it
    final Map<String, dynamic> jsonMap = jsonDecode(_initialStateJson);
    return AppState.fromJson(jsonMap);
  }
}
