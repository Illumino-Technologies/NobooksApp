import 'package:nobook/src/features/_auth/auth_feature_barrel.dart';
import 'package:nobook/src/global/domain/domain_barrel.dart';

part 'forgot_password_repo_interface.dart';

class ForgotPasswordRepository implements ForgotPasswordRepoInterface {
  final AuthSourceInterface _authSource;

  const ForgotPasswordRepository({
    required AuthSourceInterface authSource,
  }) : _authSource = authSource;

  @override
  Future<void> changePassword({
    required String studentID,
    required String password,
  }) async {
    final String token = await _authSource.changePassword(
      studentId: studentID,
      password: password,
    );
    TokenManager.storeToken(token);
  }
}
