/// We are dealing with abstractions, this enum simply serves to
/// disambiguate test from exam and vice-versa.
enum AssessmentType {
  //TODO: change these to the actual api paths
  exam('exam_api_path'),
  test('test_api_path'),
  ;

  final String apiPath;

  const AssessmentType(this.apiPath);
}
