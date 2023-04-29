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
    if (_assignment == null) return;
    questionControllers.clear();
    answerControllers.clear();
    for (final AssignmentOperation operation in _assignment!.questions) {
      questionControllers.add(
        NoteDocumentController(noteDocument: operation.content)..initialize(),
      );
    }
    if (_assignment?.answers == null) return;
    for (final AssignmentOperation operation in assignment.answers!) {
      answerControllers.add(
        NoteDocumentController(noteDocument: operation.content)..initialize(),
      );
    }
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
