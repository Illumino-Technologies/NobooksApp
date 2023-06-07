part of 'request_login_notifier.dart';

class RequestLoginState extends RiverpodStateWithStatus {
  final List<School> schools;

  RequestLoginState({
    super.success = false,
    super.loading = false,
    super.error,
    List<School>? schools,
  }) : schools = schools ?? [];

  @override
  RequestLoginState copyWith({
    List<School>? schools,
    bool? success,
    bool? loading,
    Failure? error,
  }) {
    return RequestLoginState(
      schools: schools ?? this.schools,
      success: success ?? this.success,
      loading: loading ?? this.loading,
      error: error,
    );
  }
}
