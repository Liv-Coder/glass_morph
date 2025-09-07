import 'package:example/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppTextStyles {
  static TextStyle heading1(Brightness brightness) => TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: brightness == Brightness.light
            ? Color(AppColors.lightOnBackground)
            : Color(AppColors.darkOnBackground),
      );

  static TextStyle heading2(Brightness brightness) => TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: brightness == Brightness.light
            ? Color(AppColors.lightOnBackground)
            : Color(AppColors.darkOnBackground),
      );

  static TextStyle bodyText(Brightness brightness) => TextStyle(
        fontSize: 16,
        color: brightness == Brightness.light
            ? Color(AppColors.lightOnBackground)
            : Color(AppColors.darkOnBackground),
      );

  static TextStyle caption(Brightness brightness) => TextStyle(
        fontSize: 12,
        color: brightness == Brightness.light
            ? Color(AppColors.lightOnBackground)
            : Color(AppColors.darkOnBackground),
      );
}
