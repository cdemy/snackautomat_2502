import 'package:flutter/material.dart';

/// Interface that defines the core color scheme
/// used across the application's themes.
/// Implemented by classes extending ThemeExtension.
abstract class AppColorScheme {
  Color get background;
  Color get productsViewBackground;
  Color get moneyDisplayInputBackground;
  Color get moneyDisplayPriceBackground;
  Color get productViewIconBackground;
  Color get coinInputWidgetBackground;
}
