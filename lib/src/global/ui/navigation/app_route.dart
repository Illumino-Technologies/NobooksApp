part of 'app_router.dart';

enum AppRoute {
  splash('/'),

  login('/login'),
  requestLogin('request-login'),
  changePassword('change-login'),

  dashboard('/dashboard'),

  note('/note'),
  noteDetailPage('note-detail-page'),

  assignments('/assignments'),
  assignment('assignment'),
  assessmentListing('/assessments'),

  ///This takes in a parameter of type [Assessment]
  multipleChoiceAssessmentStage('m-c-assessment-stage'),
  theoryAssessmentQuestions('theory-assessment-questions'),
  theoryAssessmentStage(
    'theory-assessment-stage:operationIndex',
  ),
  assessmentPreview('assessment-preview'),
  assessmentReview('assessment-review'),
  record('/record'),
  forum('/forum'),
  arena('/arena'),
  invalid(''),
  ;

  final String path;

  const AppRoute(this.path);
}
