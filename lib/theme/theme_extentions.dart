import 'package:flutter/material.dart';
import 'package:snackautomat_2502/theme/custom_colors.dart';

/// Extension on [BuildContext] to simplify access to custom theme colors.
/// Provides a convenient getter to retrieve [CustomColors] using `context.appColors`.
///
/// Example:
/// ```dart
/// final background = context.appColors.background;
/// ```

extension ThemeColorExtentions on BuildContext {
  CustomColors get appColors => Theme.of(this).extension<CustomColors>()!;
}
