part of 'base_class.dart';

final class TheoryAssessmentOperation extends AssessmentOperation {
  final NoteDocument _answer;
  final List<TheoryAssessmentOperationLeaf> subOperations;

  @override
  NoteDocument get answer => _answer;

  @override
  int get totalMarks =>
      (marks ?? 0) +
      subOperations.fold<int>(
        0,
        (previousValue, element) => previousValue + element.totalMarks,
      );

  const TheoryAssessmentOperation({
    required super.id,
    required super.question,
    required NoteDocument answer,
    required super.marks,
    required this.subOperations,
  })  : _answer = answer,
        super(answer: answer);

  factory TheoryAssessmentOperation.fromMap(Map<String, dynamic> map) {
    return TheoryAssessmentOperation(
      id: map['id'] as String,
      subOperations: map['subOperations'] == null
          ? []
          : (map['subOperations'] as List).map((e) {
              return TheoryAssessmentOperationLeaf.fromMap(e);
            }).toList(),
      marks: map['marks'] as int?,
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
    NoteDocument? question,
    List<TheoryAssessmentOperationLeaf>? subOperations,
    dynamic answer,
    int? marks,
  }) {
    return TheoryAssessmentOperation(
      id: id ?? this.id,
      question: question ?? List.from(this.question),
      answer: answer ?? this.answer,
      marks: marks ?? this.marks,
      subOperations: subOperations ?? List.from(this.subOperations),
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'marks': marks,
      'question': question.toSerializerList(),
      'answer': answer.toSerializerList(),
      'subOperations': subOperations.map((e) => e.toMap()).toList(),
    };
  }
}
