part of 'app_router.dart';

abstract class NavigationRedirects {
  static FutureOr<String?> baseRedirect(
    BuildContext context,
    GoRouterState state,
  ) async {
    // TODO: implement
    final String token = TokenManager.token ?? '';
    final String location = state.location;
    final String locationPath = '/${location.split('/').lastOrNull ?? ''}';

    print('location $location | location Path: $locationPath');

    if (token.isNotEmpty) return null;

    if (locationPath == AppRoute.splash.path) {
      return null;
    }

    if (location.contains(AppRoute.login.path)) {
      return null;
    }
    return AppRoute.login.path;
  }
}
