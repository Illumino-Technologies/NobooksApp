part of 'app_router.dart';

enum AppRoute {
  dashboard('/'),
  note('/note'),
  assignment('/assignment'),
  record('/record'),
  testAndExam('/test-and-exam'),
  forum('/forum'),
  arena('/arena'),
  ;

  final String path;

  const AppRoute(this.path);
}
