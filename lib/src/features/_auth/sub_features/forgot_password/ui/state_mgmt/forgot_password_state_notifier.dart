import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nobook/src/features/_auth/auth_feature_barrel.dart';
import 'package:nobook/src/global/domain/domain_barrel.dart';
import 'package:nobook/src/utils/utils_barrel.dart';

part 'forgot_password_state.dart';

StateNotifierProvider<ForgotPasswordStateNotifier, ForgotPasswordState>?
    _provider;

class ForgotPasswordStateNotifier extends StateNotifier<ForgotPasswordState>
    with BasicErrorHandlerMixin, RiverpodUtilsMixin {
  final ForgotPasswordRepoInterface _repo;

  ForgotPasswordStateNotifier({
    required ForgotPasswordRepoInterface repo,
  })  : _repo = repo,
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
        repo: ForgotPasswordRepository(authSource: FakeAuthSource()),
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
    final String studentID = (await StudentManager.requireStudent).id;
    await _repo.changePassword(
      studentID: studentID,
      password: password,
    );
    notifySuccess();
  }
}
