part of '../assessment.dart';

/// This class encapsulates the data of an assessment primarily namely:
/// - question
/// - answer
/// - marks attached to a question
///
/// The object of this class is what will carry the answer the user gives
class AssessmentOperation {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final NoteDocument question;
  final NoteDocument answer;
  final int? marks;

  const AssessmentOperation({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.question,
    required this.answer,
    required this.marks,
  });

  //generate copyWith
  AssessmentOperation copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    NoteDocument? question,
    NoteDocument? answer,
    int? marks,
  }) {
    return AssessmentOperation(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      question: question ?? this.question,
      answer: answer ?? this.answer,
      marks: marks ?? this.marks,
    );
  }

  //generate fromMap and toMap
  factory AssessmentOperation.fromMap(Map<String, dynamic> map) {
    return AssessmentOperation(
      id: map['id'] as String,
      marks: map['marks'] as int?,
      createdAt: UtilFunctions.dateTimeFromMap(map['createdAt'])!,
      updatedAt: UtilFunctions.dateTimeFromMap(map['updatedAt'])!,
      question: UtilFunctions.noteDocumentFromList(
        (map['question'] as List).cast(),
      ),
      answer: UtilFunctions.noteDocumentFromList(
        (map['answer'] as List).cast(),
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'marks': marks,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'question': question.toSerializerList(),
      'answer': answer.toSerializerList(),
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AssessmentOperation &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          createdAt == other.createdAt &&
          updatedAt == other.updatedAt &&
          question == other.question &&
          answer == other.answer &&
          marks == other.marks;

  @override
  int get hashCode =>
      id.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode ^
      question.hashCode ^
      answer.hashCode ^
      marks.hashCode;
}
