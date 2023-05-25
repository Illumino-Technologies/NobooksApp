part of '../assessment_detail_state_notifier.dart';

class AssessmentArenaState extends AssessmentStageState {
  final Assessment? _assessment;

  AssessmentArenaState({
    Assessment? assessment,
    super.success = false,
    super.loading = false,
    Failure? error,
  })  : _assessment = assessment,
        super(assessment: assessment);

  @override
  Assessment get assessment => _assessment!;

  @override
  AssessmentArenaState copyWith({
    Assessment? assessment,
    bool? success,
    bool? loading,
    Failure? error,
  }) {
    return AssessmentArenaState(
      assessment: assessment ?? this.assessment,
      success: success ?? this.success,
      loading: loading ?? this.loading,
      error: error ?? this.error,
    );
  }
}
