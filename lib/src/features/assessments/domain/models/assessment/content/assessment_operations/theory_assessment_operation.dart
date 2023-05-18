part of 'base_class.dart';

final class TheoryAssessmentOperation extends AssessmentOperation {
  final NoteDocument _answer;

  @override
  NoteDocument get answer => _answer;

  const TheoryAssessmentOperation({
    required super.id,
    required super.createdAt,
    required super.updatedAt,
    required super.question,
    required NoteDocument answer,
    required super.marks,
  })  : _answer = answer,
        super(answer: answer);

  factory TheoryAssessmentOperation.fromMap(Map<String, dynamic> map) {
    return TheoryAssessmentOperation(
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

  @override
  TheoryAssessmentOperation copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    NoteDocument? question,
    dynamic answer,
    int? marks,
  }) {
    return TheoryAssessmentOperation(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      question: question ?? this.question,
      answer: answer ?? this.answer,
      marks: marks ?? this.marks,
    );
  }

  @override
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
}
