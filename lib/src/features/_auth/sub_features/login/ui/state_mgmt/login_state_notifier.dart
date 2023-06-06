import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nobook/src/features/_auth/auth_feature_barrel.dart';
import 'package:nobook/src/utils/utils_barrel.dart';

part 'login_state.dart';

StateNotifierProvider<LoginStateNotifier, LoginState>? _provider;

class LoginStateNotifier extends StateNotifier<LoginState>
    with BasicErrorHandlerMixin, RiverpodUtilsMixin {
  final LoginRepositoryInterface _loginRepo;

  LoginStateNotifier({
    required LoginRepositoryInterface loginRepo,
  })  : _loginRepo = loginRepo,
        super(const LoginState());

  static StateNotifierProvider<LoginStateNotifier, LoginState> get provider {
    if (_provider == null) {
      throw Exception('LoginStateNotifier provider is not initialized');
    }
    return _provider!;
  }

  static void initProvider() {
    _provider = StateNotifierProvider<LoginStateNotifier, LoginState>(
      (ref) => LoginStateNotifier(
        loginRepo: LoginRepository(
          authSource: FakeAuthSource(),
        ),
      ),
    );
  }

  static void disposeProvider() {
    _provider = null;
  }

  Future<void> login({
    required String personalID,
    required String password,
  }) =>
      handleError(_login(personalID, password));

  Future<void> _login(String personalID, String password) async {
    notifyLoading();
    await _loginRepo.login(studentId: personalID, password: password);
    notifySuccess();
  }
}
