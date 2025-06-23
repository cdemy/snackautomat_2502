import 'package:flutter/material.dart';
import 'package:snackautomat_2502/theme/app_color_scheme.dart';

//
class CustomColors extends ThemeExtension<CustomColors>
    implements AppColorScheme {
  @override
  final Color background;
  @override
  final Color productsViewBackground;
  @override
  final Color moneyDisplayInputBackground;
  @override
  final Color moneyDisplayOutputBackground;

  const CustomColors({
    required this.background,
    required this.productsViewBackground,
    required this.moneyDisplayInputBackground,
    required this.moneyDisplayOutputBackground,
  });

  @override
  CustomColors copyWith({
    Color? background,
    Color? productsViewBackground,
    Color? moneyDisplayInputBackground,
    Color? moneyDisplayOutputBackground,
  }) {
    return CustomColors(
      background: background ?? this.background,
      productsViewBackground:
          productsViewBackground ?? this.productsViewBackground,
      moneyDisplayInputBackground:
          moneyDisplayInputBackground ?? this.moneyDisplayInputBackground,
      moneyDisplayOutputBackground:
          moneyDisplayOutputBackground ?? this.moneyDisplayOutputBackground,
    );
  }

  // Smoothly changes colors between two color schemes (implemented by Flutter team)
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
      moneyDisplayOutputBackground: Color.lerp(
        moneyDisplayOutputBackground,
        other.moneyDisplayOutputBackground,
        t,
      )!,
    );
  }
}
