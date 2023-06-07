/// We are dealing with abstractions, this enum simply serves to
/// disambiguate test from exam and vice-versa.
enum AssessmentType {
  //TODO: change these to the actual api paths
  exam('exam_api_path', 'Examination'),
  test('test_api_path', 'Test'),
  ;

  final String apiPath;
  final String longName;

  const AssessmentType(this.apiPath, this.longName);
}
