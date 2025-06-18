import 'package:flutter/material.dart';
import 'package:snackautomat_2502/screens/main/main_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vending Mashine App',
      home: MainScreen(), // Dein Start-Bildschirm
    );
  }
}
