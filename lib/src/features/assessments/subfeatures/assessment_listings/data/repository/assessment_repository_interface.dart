part of 'assessment_repository.dart';

abstract class AssessmentsRepositoryInterface {
  List<Assessment> get exams;

  List<Assessment> get tests;

  Future<List<Assessment>> fetchAssessmentsOf(AssessmentType type);

  Future<List<Assessment>> fetchAllAssessments();
}
