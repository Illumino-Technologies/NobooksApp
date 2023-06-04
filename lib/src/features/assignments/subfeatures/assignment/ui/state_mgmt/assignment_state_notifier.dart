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
    Assignment? assignment,
    List<NoteDocumentController>? controllers,
  })  : _assignmentsCacheManager =
            assignmentsCacheManager ?? AssignmentsCacheManager(),
        super(
          AssignmentState(
            answerControllers: controllers ?? [],
            assignment: assignment,
          ),
        );

  static StateNotifierProvider<AssignmentStateNotifier, AssignmentState>
      get provider => _assignmentStateNotifierProvider;

  static void resetAssignmentProviderWith(Assignment assignment) {
    _assignmentStateNotifierProvider =
        StateNotifierProvider<AssignmentStateNotifier, AssignmentState>(
      (ref) => AssignmentStateNotifier(
        assignment: assignment,
        controllers: _setAnswerControllersOffOf(assignment),
      ),
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

    final List<AssignmentOperation> operations = List.from(
      state.assignment.operations,
    );
    operations[currentAnswerIndex] = operations[currentAnswerIndex]
        .copyWith(question: currentAssignmentController.noteDocument);

    final Assignment assignment = state.assignment.copyWith(
      operations: operations,
    );

    await _assignmentsCacheManager.storeAssignment(assignment);
  }

  static List<NoteDocumentController> _setAnswerControllersOffOf(
    Assignment assignment,
  ) {
    final List<NoteDocumentController> answerControllers = [];

    for (final AssignmentOperation operation in assignment.operations) {
      answerControllers.add(
        NoteDocumentController(noteDocument: operation.answer)..initialize(),
      );
    }

    return answerControllers;
  }
}
