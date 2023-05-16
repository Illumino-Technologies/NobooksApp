part of 'app_router.dart';

enum AppRoute {
  splash('/'),
  dashboard('/'),
  note('/note'),
  notePage('note-page'),
  noteDetailPage('note-detail-page'),
  assignments('/assignments'),
  assignment('assignment'),
  assessmentListing('/assessments'),

  ///This takes in a parameter of type [Assessment]
  assessmentStage('assessment-stage'),
  assessmentPreview('assessment-preview'),
  record('/record'),
  forum('/forum'),
  arena('/arena'),
  invalid(''),
  ;

  final String path;

  const AppRoute(this.path);
}
