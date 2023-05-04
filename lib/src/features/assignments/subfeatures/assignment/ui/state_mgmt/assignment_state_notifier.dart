import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nobook/src/features/assignments/domain/models/assignment_model.dart';
import 'package:nobook/src/features/notes/subfeatures/document_editing/document_editing_barrel.dart';
import 'package:nobook/src/utils/function/extensions/extensions.dart';

part 'states/assignment_state.dart';

StateNotifierProvider<AssignmentStateNotifier, AssignmentState>
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
          ),
        );

  static StateNotifierProvider<AssignmentStateNotifier, AssignmentState>
      get provider => _assignmentStateNotifierProvider;

  void resetAssignmentProvider() {
    _assignmentStateNotifierProvider =
        StateNotifierProvider<AssignmentStateNotifier, AssignmentState>(
      (ref) => AssignmentStateNotifier(),
    );
  }

  void initializeAssignment(Assignment assignment) {
    state = state.copyWith(
      assignment: assignment,
    );
    state.setAnswerControllersOffOfAssignment();
  }

  @override
  void dispose() {
    super.dispose();
    state.disposeAnswerControllers();
  }
}
