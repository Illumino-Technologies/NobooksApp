import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nobook/src/features/assignments/domain/models/assignment_model.dart';
import 'package:nobook/src/features/notes/subfeatures/document_editing/document_editing_barrel.dart';

part 'states/assignment_state.dart';

final StateNotifierProvider<AssignmentStateNotifier, AssignmentState>
    _assignmentStateNotifierProvider =
    StateNotifierProvider<AssignmentStateNotifier, AssignmentState>(
  (ref) => AssignmentStateNotifier(),
);

class AssignmentStateNotifier extends StateNotifier<AssignmentState> {
  AssignmentStateNotifier()
      : super(
          AssignmentState(
            answerControllers: List.empty(growable: true),
            assignment: null,
            questionControllers: List.empty(growable: true),
          ),
        );

  static StateNotifierProvider<AssignmentStateNotifier, AssignmentState>
      get provider => _assignmentStateNotifierProvider;

  void initializeAssignment(Assignment assignment) {
    state = state.copyWith(
      assignment: assignment,
      answerControllers: [],
      questionControllers: [],
    );
    state.setControllersOffOfAssignment();
  }
}
