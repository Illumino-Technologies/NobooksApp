import 'package:nobook/src/features/assessments/assessments_barrel.dart';

class AssessmentNotifier {
  final AssessmentsRepositoryInterface _repo;

  AssessmentNotifier({
    AssessmentsRepositoryInterface? repo,
  }) : _repo = repo ?? AssessmentsRepository();

  List<Assessment> allAssessments = [];

  Future<void> fetchAssessments() async {
    allAssessments = await AssessmentsRepository().fetchAllAssessments();

    allAssessments = [
      ...AssessmentsRepository().exams,
      ...AssessmentsRepository().tests,
    ];
  }
}
