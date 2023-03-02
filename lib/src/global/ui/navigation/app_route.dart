part of 'app_router.dart';

enum AppRoute {
  splash('/'),
  dashboard('/'),
  note('/note'),
  notePage('note-page'),
  noteDetailPage('note-detail-page'),
  assignment('/assignment'),
  record('/record'),
  testAndExam('/test-and-exam'),
  forum('/forum'),
  arena('/arena'),
  invalid(''),
  ;

  final String path;

  const AppRoute(this.path);
}
