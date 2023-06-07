import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nobook/src/features/_auth/auth_feature_barrel.dart';
import 'package:nobook/src/global/domain/domain_barrel.dart';
import 'package:nobook/src/utils/utils_barrel.dart';

part 'login_state.dart';

StateNotifierProvider<ForgotPasswordStateNotifier, ForgotPasswordState>?
    _provider;

class ForgotPasswordStateNotifier extends StateNotifier<ForgotPasswordState>
    with BasicErrorHandlerMixin, RiverpodUtilsMixin {
  final AuthSourceInterface _authSource;

  ForgotPasswordStateNotifier({
    required AuthSourceInterface source,
  })  : _authSource = source,
        super(const ForgotPasswordState());

  static StateNotifierProvider<ForgotPasswordStateNotifier, ForgotPasswordState>
      get provider {
    if (_provider == null) {
      throw Exception(
        'ForgotPasswordStateNotifier provider is not initialized',
      );
    }
    return _provider!;
  }

  static void initProvider() {
    _provider =
        StateNotifierProvider<ForgotPasswordStateNotifier, ForgotPasswordState>(
      (ref) => ForgotPasswordStateNotifier(
        source: FakeAuthSource(),
      ),
    );
  }

  static void disposeProvider() {
    _provider = null;
  }

  Future<void> resetPassword({
    required String password,
  }) =>
      handleError(_resetPassword(password));

  Future<void> _resetPassword(String password) async {
    notifyLoading();
    final String studentID = StudentManager.student!.id;
    await _authSource.changePassword(
      studentId: studentID,
      password: password,
    );
    notifySuccess();
  }
}
