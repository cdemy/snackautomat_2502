import 'package:flutter/material.dart';
import 'package:snackautomat_2502/theme/custom_colors.dart';

// Extension for build context
extension ThemeColorExtentions on BuildContext {
  CustomColors get appColors => Theme.of(this).extension<CustomColors>()!;
}
