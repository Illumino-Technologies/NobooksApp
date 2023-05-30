part of '../assessment.dart';

extension AssessmentExtension on Assessment {
  bool get hasNoAnswers {
    if (paperType == PaperType.multipleChoice) {
      return assessments.cast<MultipleChoiceAssessmentOperation>().every(
            (element) => element.answer == null,
          );
    }

    if (paperType == PaperType.theory) {
      return assessments.cast<TheoryAssessmentOperation>().every(
            (element) => element.subOperations.every(
              (element) => element.answer.isNullOrEmpty,
            ),
          );
    }
    return false;
  }
}
