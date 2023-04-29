part of '../assignment_state_notifier.dart';

class AssignmentState {
  final List<NoteDocumentController> questionControllers;
  final List<NoteDocumentController> answerControllers;
  final Assignment? _assignment;

  const AssignmentState({
    required this.questionControllers,
    required this.answerControllers,
    required Assignment? assignment,
  }) : _assignment = assignment;

  Assignment get assignment => _assignment!;

  void seControllersOffOfAssignment() {
    questionControllers.clear();
    answerControllers.clear();

    // NoteDocumentController(
    //   note: Note(
    //     id: id,
    //     subject: subject,
    //     topic: topic,
    //     noteBody: noteBody,
    //     createdAt: createdAt,
    //     updatedAt: updatedAt,
    //   ),
    // );
  }

  AssignmentState copyWith({
    List<NoteDocumentController>? questionControllers,
    List<NoteDocumentController>? answerControllers,
    Assignment? assignment,
  }) {
    return AssignmentState(
      questionControllers: questionControllers ?? this.questionControllers,
      answerControllers: answerControllers ?? this.answerControllers,
      assignment: assignment ?? this.assignment,
    );
  }
}
