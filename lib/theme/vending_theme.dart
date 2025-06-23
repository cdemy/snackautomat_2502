import 'package:flutter/material.dart';
import 'package:snackautomat_2502/theme/custom_colors.dart';

final ThemeData darkVendingMachineTheme = ThemeData(
  brightness: Brightness.dark,
  useMaterial3: true,
  scaffoldBackgroundColor: const Color(0xFF2E2E2E), // Metal background
  colorScheme: const ColorScheme.dark(
    primary: Color(0xFFB0B0B0), // Light metalic
    secondary: Color(0xFFE53935), // Red button
    surface: Color(0xFF4A5C6A), // Steel blue
    onPrimary: Colors.black,
    onSecondary: Colors.white,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF4A5C6A),
    foregroundColor: Colors.white,
  ),
  cardColor: const Color(0xFF3A3A3A), // Dark metal
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.black),
    bodyMedium: TextStyle(color: Colors.black),
  ),
  buttonTheme: const ButtonThemeData(
    buttonColor: Color(0xFFE53935), // Red buttons
  ),
  extensions: [
    CustomColors(
      background: const Color.fromARGB(55, 0, 0, 0),
      moneyDisplayInputBackground: Colors.white10,
      moneyDisplayOutputBackground: Colors.amber,
      productsViewBackground: Colors.greenAccent,
    ),
  ],
);

final ThemeData lightVendingMachineTheme = ThemeData(
  brightness: Brightness.light,
  useMaterial3: true,
  scaffoldBackgroundColor: const Color(0xFF2E2E2E), // Metal background
  colorScheme: const ColorScheme.light(
    primary: Color(0xFFB0B0B0), // Light metalic
    secondary: Color(0xFFE53935), // Red button
    surface: Color(0xFF4A5C6A), // Steel blue
    onPrimary: Colors.black,
    onSecondary: Colors.white,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF4A5C6A),
    foregroundColor: Colors.white,
  ),
  cardColor: const Color(0xFF3A3A3A), // Dark metal
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.black),
    bodyMedium: TextStyle(color: Colors.black),
  ),
  buttonTheme: const ButtonThemeData(
    buttonColor: Color(0xFFE53935), // Red buttons
  ),
  extensions: [
    CustomColors(
      background: const Color.fromARGB(55, 0, 0, 0),
      moneyDisplayInputBackground: Colors.white10,
      moneyDisplayOutputBackground: const Color.fromARGB(255, 173, 164, 139),
      productsViewBackground: Colors.greenAccent,
    ),
  ],
);
