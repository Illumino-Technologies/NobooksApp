part of 'assessment_source.dart';

abstract class AssessmentSourceInterface {
  Future<List<Assessment>> fetchAssessments(AssessmentType type);

  Future<void> submitAssessment(
    Assessment assessment, {
    required AssessmentType type,
  });
}
