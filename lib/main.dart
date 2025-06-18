import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:snackautomat_2502/app.dart';
import 'screens/main/main_screen.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(), // Haupt App Klasse
    ),
  );
}
