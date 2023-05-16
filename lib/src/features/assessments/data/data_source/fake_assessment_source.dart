part of 'assessment_source.dart';

final class FakeAssessmentSource implements AssessmentSourceInterface {
  @override
  Future<List<Assessment>> fetchAssessments(AssessmentType type) async {
    await Future.delayed(const Duration(seconds: 1));
    return FakeAssessmentsData.getSubjectAssessments(startTime: DateTime.now());
  }

  @override
  Future<void> submitAssessment(
    Assessment assessment, {
    required AssessmentType type,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
  }
}
