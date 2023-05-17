part of '../assessment_detail_state_notifier.dart';

class AssessmentStateState extends AssignmentDetailState with TimerMixin {
  AssessmentStateState({
    required super.assessment,
    super.success = false,
    super.loading = false,
    Failure? error,
  });

  @override
  AssessmentStateState copyWith({
    Assessment? assessment,
    bool? success,
    bool? loading,
    Failure? error,
  }) {
    return AssessmentStateState(
      assessment: assessment ?? this.assessment,
      success: success ?? this.success,
      loading: loading ?? this.loading,
      error: error ?? this.error,
    );
  }

  @override
  int get timerDuration => assessment.duration * 60;
}
