import 'package:flutter/material.dart';

/// Interface that defines the core color scheme
/// used across the application's themes.
/// Implemented by classes extending ThemeExtension.
abstract class AppColorScheme {
  /// Background color
  Color get background;

  /// Product view color
  Color get productsViewBackground;

  /// Money Display input background
  Color get moneyDisplayInputBackground;

  /// Money Display price background
  Color get moneyDisplayPriceBackground;

  /// Product view icon background
  Color get productViewIconBackground;

  /// Coin input widget background
  Color get coinInputWidgetBackground;
}
