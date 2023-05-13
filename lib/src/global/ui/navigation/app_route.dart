part of 'app_router.dart';

enum AppRoute {
  splash('/'),
  dashboard('/'),
  note('/note'),
  notePage('note-page'),
  noteDetailPage('note-detail-page'),
  assignments('/assignments'),
  assignment('assignment'),
  assessmentListing('/assessment-listing'),

  ///This takes in a record parameter of type `(Assessment, AssessmentType)`
  assessmentDetail('assessment-detail'),
  record('/record'),
  testAndExam('/test-and-exam'),
  forum('/forum'),
  arena('/arena'),
  invalid(''),
  ;

  final String path;

  const AppRoute(this.path);
}
