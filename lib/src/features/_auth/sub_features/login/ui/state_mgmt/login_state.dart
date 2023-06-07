part of 'login_state_notifier.dart';

class LoginState extends RiverpodStateWithStatus {
  const LoginState({
    super.success = false,
    super.loading = false,
    super.error,
  });

  @override
  LoginState copyWith({
    bool? success,
    bool? loading,
    Failure? error,
  }) {
    return LoginState(
      success: success ?? this.success,
      loading: loading ?? this.loading,
      error: error,
    );
  }
}
