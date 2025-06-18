import 'package:flutter/material.dart';
import 'package:snackauotmat_2502/theme/vending_theme.dart';
import 'screens/main_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vending Machine',
      theme: lightVendingMachineTheme,
      darkTheme: darkVendingMachineTheme,
      themeMode: ThemeMode.dark,
      home: MainScreen(),
    );
  }
}
