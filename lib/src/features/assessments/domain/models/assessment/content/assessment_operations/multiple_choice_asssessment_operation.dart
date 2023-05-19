part of 'base_class.dart';

final class MultipleChoiceAssessmentOperation extends AssessmentOperation {
  final List<NoteDocument> options;
  final int? _answer;

  @override
  int? get answer => _answer;

  int? get mcqAnswer => _answer;

  MultipleChoiceAssessmentOperation({
    required super.id,
    required super.createdAt,
    required super.updatedAt,
    required super.question,
    int? answer,
    required super.marks,
    required this.options,
  })  : _answer = answer,
        super(answer: answer);

  factory MultipleChoiceAssessmentOperation.fromMap(Map<String, dynamic> map) {
    return MultipleChoiceAssessmentOperation(
      id: map['id'] as String,
      marks: map['marks'] as int?,
      createdAt: UtilFunctions.dateTimeFromMap(map['createdAt'])!,
      updatedAt: UtilFunctions.dateTimeFromMap(map['updatedAt'])!,
      question: UtilFunctions.noteDocumentFromList(
        (map['question'] as List).cast(),
      ),
      options: (map['options'] as List).map((e) {
        return UtilFunctions.noteDocumentFromList(
          (e as List).cast(),
        );
      }).toList(),
      answer: map['answer'] as int?,
    );
  }

  @override
  MultipleChoiceAssessmentOperation copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    NoteDocument? question,
    dynamic answer,
    int? marks,
    List<NoteDocument>? options,
  }) {
    return MultipleChoiceAssessmentOperation(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      question: question ?? this.question,
      answer: answer ?? this.answer,
      options: options ?? this.options,
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
      'options': options.map((e) => e.toSerializerList()).toList(),
      'answer': answer,
    };
  }
}
