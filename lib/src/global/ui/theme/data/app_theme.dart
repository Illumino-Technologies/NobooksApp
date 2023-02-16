import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nobook/src/global/global_barrel.dart';

abstract class AppTheme {
  static final ThemeData lightTheme = _lightTheme;
}

final ThemeData _lightTheme = ThemeData.light().copyWith(
  primaryColor: AppColors.blue500,
  appBarTheme: _appBarTheme,
  colorScheme: _lightColorScheme,
);

const AppBarTheme _appBarTheme = AppBarTheme(
  elevation: 0,
  color: AppColors.white,
  systemOverlayStyle: SystemUiOverlayStyle.dark,
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
