import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nobook/src/features/assessments/assessments_barrel.dart';
import 'package:nobook/src/utils/utils_barrel.dart';

part 'states/assessment_stage_state.dart';

part 'states/base_state.dart';

StateNotifierProvider<AssessmentStageNotifier, AssessmentStageState> _provider =
    StateNotifierProvider<AssessmentStageNotifier, AssessmentStageState>(
  (ref) => AssessmentStageNotifier(ref: ref),
);

class AssessmentStageNotifier extends StateNotifier<AssessmentStageState> {
  final Ref ref;

  AssessmentStageNotifier({
    required this.ref,
    Assessment? assessment,
  }) : super(AssessmentArenaState());

  static StateNotifierProvider<AssessmentStageNotifier, AssessmentStageState>
      get provider => _provider;

  static void refreshNotifier(Assessment assessment) {
    _provider =
        StateNotifierProvider<AssessmentStageNotifier, AssessmentStageState>(
      (ref) => AssessmentStageNotifier(ref: ref)..initializeData(assessment),
    );
  }

  void initializeData(Assessment assessment) {
    state = state.copyWith(assessment: assessment);
  }

  void updateAssessment(Assessment assessment) {
    if (AssessmentTimerStateNotifier.provider == null) return;
    if (ref.read(AssessmentTimerStateNotifier.requireProvider).inSeconds <= 1) {
      return;
    }

    state = state.copyWith(assessment: assessment);
  }

  Future<void> submit() async {}
}
