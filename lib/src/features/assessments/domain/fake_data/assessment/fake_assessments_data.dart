import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:nobook/src/features/assessments/domain/models/assessment/assessment.dart';
import 'package:nobook/src/features/assignments/domain/fakes/fake_assignments.dart';
import 'package:nobook/src/features/notes/subfeatures/document_editing/subfeatures/drawing/drawing_barrel.dart';
import 'package:nobook/src/global/domain/domain_barrel.dart';
import 'package:nobook/src/utils/utils_barrel.dart';

abstract class FakeAssessmentsData {
  /// the questions for each assessment
  static final List<NoteDocument> questionContents =
      FakeAssignmentData.questions;

  /// this simply generates AssessmentOperations (question and answer)
  static List<AssessmentOperation> getOperations() {
    return questionContents.map<AssessmentOperation>((question) {
      return AssessmentOperation(
        id: UniqueKey().toString(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        question: question,
        answer: List.empty(growable: true),
        marks: math.Random().nextInt(10),
      );
    }).toList();
  }

  /// Generates a List of Assessments such that
  /// There exists three assessments per subject
  static List<Assessment> getSubjectAssessments({
    required DateTime startTime,
  }) =>
      FakeSubjects.subjects.map<List<Assessment>>((subject) {
        final int duration = math.Random().nextBool() ? 40 : 30;
        return List<Assessment>.generate(
          3,
          (index) => Assessment(
            id: UniqueKey().toString(),
            subject: subject,
            questionTypes: [
              QuestionType.theory,
              if (math.Random().nextBool()) QuestionType.german,
            ],
            assessments: getOperations(),
            duration: duration,
            startTime: startTime,
            endTime: startTime.copyAdd(minute: duration),
          ),
        );
      }).reduce((value, element) => value..addAll(element));
}
