part of 'forgot_password_repository.dart';

abstract interface class ForgotPasswordRepoInterface {
  Future<void> changePassword({
    required String studentID,
    required String password,
  });
}
