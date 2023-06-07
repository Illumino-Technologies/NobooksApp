import 'package:nobook/src/features/notes/subfeatures/document_editing/document_editing_barrel.dart';
import 'package:nobook/src/utils/utils_barrel.dart';

part 'multiple_choice_asssessment_operation.dart';

part 'theory_assessment_operation.dart';

part 'theory_assessment_operation_leaf.dart';

/// This class encapsulates the data of an assessment primarily namely:
/// - question
/// - answer
/// - marks attached to a question
///
/// The object of this class is what will carry the answer the user gives
sealed class AssessmentOperation {
  final String id;
  final NoteDocument question;
  final dynamic answer;
  final int? marks;

  const AssessmentOperation({
    required this.id,
    required this.question,
    required this.answer,
    required this.marks,
  });

  AssessmentOperation copyWith({
    String? id,
    NoteDocument? question,
    dynamic answer,
    int? marks,
  });

  static AssessmentOperation fromMap(Map<String, dynamic> map) {
    return switch (map) {
      {'options': _} => MultipleChoiceAssessmentOperation.fromMap(map),
      {'answer': NoteDocument _} => TheoryAssessmentOperation.fromMap(map),
      _ => throw Exception('Invalid map'),
    };
  }

  int get totalMarks;

  Map<String, dynamic> toMap();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AssessmentOperation &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          question == other.question &&
          answer == other.answer &&
          marks == other.marks;

  @override
  int get hashCode =>
      id.hashCode ^ question.hashCode ^ answer.hashCode ^ marks.hashCode;
}
