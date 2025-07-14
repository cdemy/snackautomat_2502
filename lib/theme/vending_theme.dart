import 'package:flutter/material.dart';
import 'package:snackautomat_2502/theme/custom_colors.dart';

/// Dark theme configuration for the vending machine UI.
/// Uses a seed-based ColorScheme and adds a CustomColors extension
/// to support custom UI-specific colors.
final ThemeData darkVendingMachineTheme = ThemeData(
  brightness: Brightness.dark,
  useMaterial3: true,
  scaffoldBackgroundColor: const Color(0xFF2E2E2E), // Metal background
  colorScheme: const ColorScheme.dark(
    primary: Color(0xFFB0B0B0), // Light metalic
    secondary: Color(0xFFE53935), // Red button
    surface: Color(0xFF4A5C6A), // Steel blue
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
  extensions: const [
    CustomColors(
      background: Color.fromARGB(55, 0, 0, 0),
      coinInputWidgetBackground: Color.fromARGB(255, 103, 119, 83),
      moneyDisplayInputBackground: Colors.white10,
      moneyDisplayPriceBackground: Colors.amber,
      productsViewBackground: Colors.greenAccent,
      productViewIconBackground: Color(0xFFB0B0B0),
    ),
  ],
);

/// Light theme configuration for the vending machine UI.
/// Uses a seed-based ColorScheme and adds a CustomColors extension
/// to support custom UI-specific colors.

final ThemeData lightVendingMachineTheme = ThemeData(
  brightness: Brightness.light,
  useMaterial3: true,
  // scaffoldBackgroundColor: const Color.fromARGB(255, 80, 80, 80), // Metal background
  // colorScheme: const ColorScheme.light(
  //   primary: Color(0xFFB0B0B0), // Light metalic
  //   secondary: Color(0xFFE53935), // Red button
  //   surface: Color(0xFF4A5C6A), // Steel blue
  //   onPrimary: Colors.black,
  //   onSecondary: Colors.white,
  // ),
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xFFB0B0B0),
  ),
  // appBarTheme: const AppBarTheme(
  //   backgroundColor: Color(0xFF4A5C6A),
  //   foregroundColor: Colors.white,
  // ),
  // cardColor: const Color(0xFF3A3A3A), // Dark metal
  // textTheme: const TextTheme(
  //   bodyLarge: TextStyle(color: Colors.black),
  //   bodyMedium: TextStyle(color: Colors.black),
  // ),
  // buttonTheme: const ButtonThemeData(
  //   buttonColor: Color(0xFFE53935), // Red buttons
  // ),
  extensions: const [
    CustomColors(
      background: Color.fromARGB(255, 97, 97, 97),
      coinInputWidgetBackground: Color.fromARGB(255, 126, 146, 102),
      moneyDisplayInputBackground: Color.fromARGB(255, 104, 128, 147),
      moneyDisplayPriceBackground: Color.fromARGB(255, 229, 222, 158),
      productsViewBackground: Color(0xFFB0B0B0),
      productViewIconBackground: Color.fromARGB(255, 255, 246, 246),
    ),
  ],
);
