import 'package:go_router/go_router.dart';
import 'package:nobook/src/core/navigation/app_routes.dart';

import 'package:nobook/src/features/dashboard/view/screen/dashboard_screen.dart';

import 'package:nobook/src/features/notes/view/screen/note_screen.dart';
part 'app_route_paths.dart';

class AppRouter {
  static GoRouter get router => _router;

  static void goNamed(
    String name, {
    Map<String, String> params = const <String, String>{},
    Map<String, dynamic> queryParams = const <String, dynamic>{},
    Object? extra,
  }) =>
      router.goNamed(
        name,
        params: params,
        queryParams: queryParams,
        extra: extra,
      );
}

final GoRouter _router =
    GoRouter(urlPathStrategy: UrlPathStrategy.path, routes: [
  GoRoute(
    path: AppRoutePath.dashboard,
    name: AppRoutes.dashboard,
    builder: (context, state) {
      return const DashBoardScreen();
    },
  ),
  GoRoute(
    path: AppRoutePath.note,
    name: AppRoutes.note,
    builder: (context, state) {
      return const NoteScreen();
    },
  ),
]);
