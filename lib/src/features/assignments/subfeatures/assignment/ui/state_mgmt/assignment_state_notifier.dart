import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nobook/src/features/assignments/domain/models/assignment_model.dart';
import 'package:nobook/src/features/assignments/subfeatures/assignment/domain/logic/cache_manager/assignment_cache_manager.dart';
import 'package:nobook/src/features/notes/subfeatures/document_editing/document_editing_barrel.dart';
import 'package:nobook/src/utils/utils_barrel.dart';

part 'states/assignment_state.dart';

StateNotifierProvider<AssignmentStateNotifier, AssignmentState>
    _assignmentStateNotifierProvider =
    StateNotifierProvider<AssignmentStateNotifier, AssignmentState>(
  (ref) => AssignmentStateNotifier(),
);

class AssignmentStateNotifier extends StateNotifier<AssignmentState>
    with BasicErrorHandlerMixin {
  final AssignmentsCacheManager _assignmentsCacheManager;

  AssignmentStateNotifier({
    AssignmentsCacheManager? assignmentsCacheManager,
  })  : _assignmentsCacheManager =
            assignmentsCacheManager ?? AssignmentsCacheManager(),
        super(
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
      (ref) => AssignmentStateNotifier()
        ..initializeAssignment(state.assignment)
        ..fetchAssignment(),
    );
  }

  Future<void> fetchAssignment() => handleError(
        _fetchAssignment(),
      );

  Future<void> _fetchAssignment() async {
    final Assignment? assignment =
        _assignmentsCacheManager.fetchStoredAssignment(state.assignment.id);
    if (assignment == null) return;
    initializeAssignment(assignment);
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

  Future<void> syncAssignmentAnswer(int currentAnswerIndex) => handleError(
        _syncAssignmentAnswer(currentAnswerIndex),
      );

  Future<void> _syncAssignmentAnswer(int currentAnswerIndex) async {
    final NoteDocumentController currentAssignmentController =
        state.answerControllers[currentAnswerIndex];

    final AssignmentOperation answer =
        state.assignment.answers?.firstWhereOrNull(
              (element) =>
                  element.serialId ==
                  state.assignment.questions[currentAnswerIndex].serialId,
            ) ??
            AssignmentOperation.create(
              serialId: state.assignment.questions[currentAnswerIndex].serialId,
              content: currentAssignmentController.noteDocument,
            );

    final List<AssignmentOperation> answers = List.from(
      state.assignment.answers ?? [],
    );
    if (answers.isEmpty) {
      answers.add(answer);
    } else {
      final bool replaced = answers.tryReplaceWhere([answer], (element) {
        return element.serialId == answer.serialId;
      });
      if (!replaced) {
        answers.add(answer);
      }
    }

    final Assignment assignment = state.assignment.copyWith(
      answers: answers,
    );

    await _assignmentsCacheManager.storeAssignment(assignment);
  }
}
