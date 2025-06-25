import 'package:flutter/material.dart';
import 'package:snackautomat_2502/theme/app_color_scheme.dart';

/// A theme extension that holds custom colors not covered by the default ColorScheme.
/// Used to define UI-specific colors for the vending machine interface,
/// with support for theme interpolation and copying.
class CustomColors extends ThemeExtension<CustomColors>
    implements AppColorScheme {
  @override
  final Color background;
  @override
  final Color productsViewBackground;
  @override
  final Color moneyDisplayInputBackground;
  @override
  final Color moneyDisplayPriceBackground;
  @override
  final Color productViewIconBackground;
  @override
  final Color coinInputWidgetBackground;

  /// Constructor for creating a new instance of CustomColours
  /// with the obligatory definition of all colour fields.
  const CustomColors({
    required this.background,
    required this.productsViewBackground,
    required this.moneyDisplayInputBackground,
    required this.moneyDisplayPriceBackground,
    required this.productViewIconBackground,
    required this.coinInputWidgetBackground,
  });

  /// Creates a copy of the current CustomColors object,
  /// replacing only those fields that are passed as arguments.
  /// If no argument is passed, the value from the current object is used.
  /// Used to partially update the colour scheme.
  @override
  CustomColors copyWith({
    Color? background,
    Color? productsViewBackground,
    Color? moneyDisplayInputBackground,
    Color? moneyDisplayPriceBackground,
    Color? productViewIconBackground,
    Color? coinInputWidgetBackground,
  }) {
    return CustomColors(
      background: background ?? this.background,
      productsViewBackground:
          productsViewBackground ?? this.productsViewBackground,
      moneyDisplayInputBackground:
          moneyDisplayInputBackground ?? this.moneyDisplayInputBackground,
      moneyDisplayPriceBackground:
          moneyDisplayPriceBackground ?? this.moneyDisplayPriceBackground,
      productViewIconBackground:
          productViewIconBackground ?? this.productViewIconBackground,
      coinInputWidgetBackground:
          coinInputWidgetBackground ?? this.coinInputWidgetBackground,
    );
  }

  /// The method smoothly blends (interpolates) colours between
  /// the current (this) and another (other) instance of
  /// CustomColors depending on the t parameter (from 0.0 to 1.0).
  @override
  CustomColors lerp(ThemeExtension<CustomColors>? other, double t) {
    if (other is! CustomColors) {
      return this;
    }
    return CustomColors(
      background: Color.lerp(background, other.background, t)!,
      productsViewBackground: Color.lerp(
        productsViewBackground,
        other.productsViewBackground,
        t,
      )!,
      moneyDisplayInputBackground: Color.lerp(
        moneyDisplayInputBackground,
        other.moneyDisplayInputBackground,
        t,
      )!,
      moneyDisplayPriceBackground: Color.lerp(
        moneyDisplayPriceBackground,
        other.moneyDisplayPriceBackground,
        t,
      )!,
      productViewIconBackground: Color.lerp(
        productViewIconBackground,
        other.productViewIconBackground,
        t,
      )!,
      coinInputWidgetBackground: Color.lerp(
        coinInputWidgetBackground,
        other.coinInputWidgetBackground,
        t,
      )!,
    );
  }
}
