import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nobook/src/global/ui/ui_barrel.dart';

final StateNotifierProvider<SplashStateNotifier, AppRoute> _provider =
    StateNotifierProvider<SplashStateNotifier, AppRoute>(
  (ref) => SplashStateNotifier(),
);

class SplashStateNotifier extends StateNotifier<AppRoute> {
  SplashStateNotifier() : super(AppRoute.splash);

  static StateNotifierProvider<SplashStateNotifier, AppRoute> get provider =>
      _provider;

  Future<void> navigateToNext() async {
    // TODO: initialize app
    await Future.delayed(const Duration(milliseconds: 1500));
    state = AppRoute.dashboard;
  }
}
