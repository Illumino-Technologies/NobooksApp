part of 'extensions.dart';

extension CustomGoRouteExtension on GoRoute {
  static GoRoute fromAppRoute({
    required AppRoute route,
    GoRouterWidgetBuilder? builder,
    GoRouterPageBuilder? pageBuilder,
    GlobalKey<NavigatorState>? parentNavigatorKey,
    GoRouterRedirect? redirect,
    List<RouteBase> routes = const <RouteBase>[],
  }) {
    return GoRoute(
      path: route.path,
      name: route.name,
      builder: builder,
      pageBuilder: pageBuilder,
      parentNavigatorKey: parentNavigatorKey,
      routes: routes,
      redirect: redirect,
    );
  }
}
