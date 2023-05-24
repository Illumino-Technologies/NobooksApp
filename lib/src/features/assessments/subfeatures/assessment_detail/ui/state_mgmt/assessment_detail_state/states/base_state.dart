part of '../assessment_detail_state_notifier.dart';

sealed class AssessmentStageState extends RiverpodStateWithStatus {
  final Assessment? assessment;

  AssessmentStageState({
    required this.assessment,
    super.success = false,
    super.loading = false,
    super.error,
  });

  @override
  AssessmentStageState copyWith({
    Assessment? assessment,
    bool? success,
    bool? loading,
    Failure? error,
  });
}
