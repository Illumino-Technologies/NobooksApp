part of '../assignment_state_notifier.dart';

class AssignmentState {
  final List<NoteDocumentController> answerControllers;
  final Assignment? _assignment;

  const AssignmentState({
    required this.answerControllers,
    required Assignment? assignment,
  }) : _assignment = assignment;

  Assignment get assignment => _assignment!;

  void setAnswerControllersOffOfAssignment() {
    if (_assignment == null) return;

    answerControllers.clear();

    final List<NoteDocumentController> newAnswerControllers = [];

    for (final AssignmentOperation question in _assignment!.questions) {
      final bool questionAnswerHasContent = assignment.answers
              ?.containsWhere((value) => value.serialId == question.serialId) ??
          false;
      if (questionAnswerHasContent) {
        newAnswerControllers.add(
          assignment.answers!
              .firstWhere((element) => element.serialId == question.serialId)
              .newInitializedController,
        );
        continue;
      }
      newAnswerControllers.add(
        NoteDocumentController(
          noteDocument: [],
        ),
      );
    }

    answerControllers.addAll(newAnswerControllers);
  }

  AssignmentState copyWith({
    List<NoteDocumentController>? answerControllers,
    Assignment? assignment,
  }) {
    return AssignmentState(
      answerControllers: answerControllers ?? this.answerControllers,
      assignment: assignment ?? this.assignment,
    );
  }

  void disposeAnswerControllers() {
    for (final NoteDocumentController element in answerControllers) {
      element.dispose();
    }
  }
}
