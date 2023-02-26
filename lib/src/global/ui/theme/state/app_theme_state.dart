import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final StateNotifierProvider<ThemeModeNotifier, ThemeMode> themeModeProvider =
    StateNotifierProvider<ThemeModeNotifier, ThemeMode>(
  (ref) => ThemeModeNotifier(),
);

class ThemeModeNotifier extends StateNotifier<ThemeMode> {
  ThemeModeNotifier() : super(ThemeMode.light);

  static StateNotifierProvider<ThemeModeNotifier, ThemeMode> get provider =>
      themeModeProvider;

  void switchThemeModeTo(ThemeMode value) {
    if (state == value) return;
    state = value;
  }

  void switchToLight() => switchThemeModeTo(ThemeMode.light);

  void switchToDark() => switchThemeModeTo(ThemeMode.dark);

  void switchToSystem() => switchThemeModeTo(ThemeMode.system);
}
