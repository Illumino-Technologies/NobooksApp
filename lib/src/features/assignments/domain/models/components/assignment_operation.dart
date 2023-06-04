part of '../assignment_model.dart';

class AssignmentOperation {
  final String id;
  final NoteDocument question;
  final NoteDocument answer;
  final DateTime createdAt;
  final DateTime updatedAt;

  const AssignmentOperation({
    required this.id,
    required this.question,
    required this.answer,
    required this.createdAt,
    required this.updatedAt,
  });

  AssignmentOperation.create({
    required this.id,
    required this.question,
    required this.answer,
  })  : createdAt = DateTime.now(),
        updatedAt = DateTime.now();

  NoteDocumentController get newController => NoteDocumentController(
        noteDocument: question,
      );

  NoteDocumentController get newInitializedController =>
      newController..initialize(noteDocument: question);

  AssignmentOperation.fromMap(Map<String, dynamic> map)
      : id = map['serialId'],
        question = UtilFunctions.noteDocumentFromList(map['question']),
        answer = UtilFunctions.noteDocumentFromList(map['answer']),
        createdAt = UtilFunctions.dateTimeFromMap(map['createdAt'])!,
        updatedAt = UtilFunctions.dateTimeFromMap(map['updatedAt'])!;

  Map<String, dynamic> toMap() {
    return {
      'serialId': id,
      'question': question.toSerializerList(),
      'answer': answer.toSerializerList(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  AssignmentOperation copyWith({
    String? id,
    NoteDocument? question,
    NoteDocument? answer,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return AssignmentOperation(
      id: id ?? this.id,
      question: question ?? this.question,
      answer: answer ?? this.answer,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
