part of 'base_class.dart';

final class TheoryAssessmentOperationLeaf extends AssessmentOperation {
  final NoteDocument _answer;

  @override
  NoteDocument get answer => _answer;

  @override
  int get totalMarks => marks ?? 0;

  const TheoryAssessmentOperationLeaf({
    required super.id,
    required super.question,
    required NoteDocument answer,
    required super.marks,
  })  : _answer = answer,
        super(answer: answer);

  factory TheoryAssessmentOperationLeaf.fromMap(Map<String, dynamic> map) {
    return TheoryAssessmentOperationLeaf(
      id: map['id'] as String,
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
  TheoryAssessmentOperationLeaf copyWith({
    String? id,
    NoteDocument? question,
    dynamic answer,
    int? marks,
  }) {
    return TheoryAssessmentOperationLeaf(
      id: id ?? this.id,
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
      'question': question.toSerializerList(),
      'answer': answer.toSerializerList(),
    };
  }
}

// a theory operation should have a question which could have a list of other questions or just a single question
// I could make it such that the question has a list of questions,
//    then for the single case
//      it basically checks if it's a single question
//        and if it is a single question, it displays that as a question with the number index
//        if it is not then it displays the list of all those questions as a list of question
