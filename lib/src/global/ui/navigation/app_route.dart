part of 'app_router.dart';

enum AppRoute {
  home('/'),
  dashboard('/dashboard'),
  note('/note'),
  notePage('/note'),
  assignment('/assignment'),
  record('/record'),
  testAndExam('/test-and-exam'),
  forum('/forum'),
  arena('/arena'),
  ;

  final String path;

  const AppRoute(this.path);
}
