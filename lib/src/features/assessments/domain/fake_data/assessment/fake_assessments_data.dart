import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nobook/src/features/assessments/assessments_barrel.dart';
import 'package:nobook/src/features/assignments/domain/fakes/fake_assignments.dart';
import 'package:nobook/src/features/notes/subfeatures/document_editing/document_editing_barrel.dart';
import 'package:nobook/src/global/global_barrel.dart';
import 'package:nobook/src/utils/utils_barrel.dart';

part 'fake_assessment_preview_data.dart';

part 'fake_assessment_stage_data.dart';

abstract class FakeAssessmentsData {
  /// the questions for each assessment
  static final List<NoteDocument> questionContents =
      FakeAssignmentData.questions;

  /// Generates a List of Assessments such that
  /// There exists three assessments per subject
  static List<Assessment> getSubjectAssessments({
    required AssessmentType type,
    TermPeriod term = TermPeriod.first,
    required DateTime startTime,
  }) =>
      FakeSubjects.subjects.map<List<Assessment>>((subject) {
        final int duration = math.Random().nextBool() ? 40 : 30;
        return List<Assessment>.generate(
          2,
          (index) => Assessment(
            submitted: false,
            id: UniqueKey().toString(),
            subject: subject,
            paperType: PaperType.values[index],
            assessments:
                _FakeAssessmentStageData.generateAssessmentOperationsBy(
              PaperType.values[index],
            ),
            duration: duration,
            startTime: startTime,
            endTime: startTime.copyAdd(minute: duration),
            term: term,
            assessmentNumber: term.index,
            type: type,
            session: '2021/2022',
            assessmentConduct: _FakeAssessmentPreviewData.assessmentConduct,
            assessmentInstructions:
                _FakeAssessmentPreviewData.assessmentInstructions,
            studentDeclaration: _FakeAssessmentPreviewData.studentConduct,
          ),
        );
      }).reduce((value, element) => value..addAll(element));
}
