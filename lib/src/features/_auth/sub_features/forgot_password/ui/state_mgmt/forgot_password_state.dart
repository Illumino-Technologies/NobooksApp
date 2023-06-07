part of 'forgot_password_state_notifier.dart';

class ForgotPasswordState extends RiverpodStateWithStatus {
  const ForgotPasswordState({
    super.success = false,
    super.loading = false,
    super.error,
  });

  @override
  ForgotPasswordState copyWith({
    bool? success,
    bool? loading,
    Failure? error,
  }) {
    return ForgotPasswordState(
      success: success ?? this.success,
      loading: loading ?? this.loading,
      error: error,
    );
  }
}
