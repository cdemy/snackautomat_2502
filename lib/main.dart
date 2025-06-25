import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:snackautomat_2502/theme/vending_theme.dart';
import 'screens/main_screen.dart';

void main() {
  debugPrint("Hello");
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vending Machine App',
      theme: lightVendingMachineTheme,
      home: MainScreen(),
    );
  }
}
