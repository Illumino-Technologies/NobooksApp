part of 'base_class.dart';

final class MultipleChoiceAssessmentOperation extends AssessmentOperation {
  final List<NoteDocument> options;
  final int? _answer;

  @override
  int? get answer => _answer;

  int? get mcqAnswer => _answer;

  MultipleChoiceAssessmentOperation({
    required super.id,
    required super.question,
    int? answer,
    required super.marks,
    required this.options,
  })  : _answer = answer,
        super(answer: answer);

  @override
  int get totalMarks => marks ?? 0;

  factory MultipleChoiceAssessmentOperation.fromMap(Map<String, dynamic> map) {
    return MultipleChoiceAssessmentOperation(
      id: map['id'] as String,
      marks: map['marks'] as int?,
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
    NoteDocument? question,
    dynamic answer,
    int? marks,
    List<NoteDocument>? options,
  }) {
    return MultipleChoiceAssessmentOperation(
      id: id ?? this.id,
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
      'question': question.toSerializerList(),
      'options': options.map((e) => e.toSerializerList()).toList(),
      'answer': answer,
    };
  }
}
