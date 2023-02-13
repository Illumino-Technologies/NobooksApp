import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:go_router_flow/go_router_flow.dart';
import 'package:nobook/src/features/dashboard/view/screen/dashboard_screen.dart';
import 'package:nobook/src/features/notes/view/screen/note_screen.dart';

part 'app_route.dart';

part 'navigation_redirects.dart';

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

final GoRouter _router = GoRouter(
  redirect: NavigationRedirects.baseRedirect,
  routes: [
    GoRoute(
      path: AppRoute.dashboard.path,
      name: AppRoute.dashboard.name,
      builder: (context, state) {
        return const DashBoardScreen();
      },
    ),
    GoRoute(
      path: AppRoute.note.path,
      name: AppRoute.note.name,
      builder: (context, state) {
        return const NoteScreen();
      },
    ),
  ],
);
