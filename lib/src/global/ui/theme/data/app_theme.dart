import 'package:flutter/material.dart';
import 'package:nobook/src/global/global_barrel.dart';

abstract class AppTheme {
  static final ThemeData lightTheme = _lightTheme;
}

final ThemeData _lightTheme = ThemeData.light().copyWith(
  primaryColor: AppColors.blue500,
  colorScheme: _lightColorScheme,
);

const ColorScheme _lightColorScheme = ColorScheme.light(
  primary: AppColors.blue500,
  onPrimary: AppColors.white,
  background: AppColors.white,
  onBackground: AppColors.black,
  surface: AppColors.backgroundGrey,
  onSurface: AppColors.black,
  error: AppColors.red500,
);
