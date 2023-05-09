import 'package:nobook/src/features/assessments/assessments_barrel.dart';

part 'assessment_repository_interface.dart';

class AssessmentsRepository implements AssessmentsRepositoryInterface {
  final AssessmentSourceInterface _source;

  AssessmentsRepository({
    AssessmentSourceInterface? source,
  }) : _source = source ?? AssessmentSource();

  final List<Assessment> _exams = [];
  final List<Assessment> _tests = [];

  @override
  List<Assessment> get exams => List.from(_exams);

  @override
  List<Assessment> get tests => List.from(_tests);

  @override
  Future<List<Assessment>> fetchAssessmentsOf(AssessmentType type) async {
    final List<Assessment> assessments = await _source.fetchAssessments(type);

    setInternalAssessmentLists(assessments, type);

    return assessments;
  }

  void setInternalAssessmentLists(
    final List<Assessment> assessments,
    AssessmentType type, [
    bool afresh = true,
  ]) {
    switch (type) {
      case AssessmentType.test:
        {
          if (afresh) _tests.clear();
          return _tests.addAll(assessments);
        }
      case AssessmentType.exam:
        {
          if (afresh) _exams.clear();
          return _exams.addAll(assessments);
        }
    }
  }

  @override
  Future<List<Assessment>> fetchAllAssessments() async {
    final List<Assessment> exams = await fetchAssessmentsOf(
      AssessmentType.exam,
    );
    final List<Assessment> tests = await fetchAssessmentsOf(
      AssessmentType.test,
    );

    return [...exams, ...tests]..sort();
  }
}
