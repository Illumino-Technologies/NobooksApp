/// We are dealing with abstractions, this enum simply serves to
/// disambiguate test from exam and vice-versa.
enum AssessmentType {
  //TODO: change these to the actual api paths
  test('test_api_path'),
  exam('exam_api_path'),
  ;

  final String apiPath;

  const AssessmentType(this.apiPath);
}
