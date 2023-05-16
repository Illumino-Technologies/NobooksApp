part of '../assessment_detail_state_notifier.dart';

sealed class AssignmentDetailState extends RiverpodStateWithStatus {
  final Assessment assessment;

  AssignmentDetailState({
    required this.assessment,
    super.success = false,
    super.loading = false,
    super.error,
  });

  @override
  AssignmentDetailState copyWith({
    Assessment? assessment,
    bool? success,
    bool? loading,
    Failure? error,
  });
}
