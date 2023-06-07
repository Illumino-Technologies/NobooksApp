part of 'login_repo_interface.dart';

class LoginRepository
    with DioErrorHandlerMixin
    implements LoginRepositoryInterface {
  final AuthSourceInterface _authSource;

  LoginRepository({
    required AuthSourceInterface authSource,
  }) : _authSource = authSource;

  @override
  Future<void> login({
    required String studentId,
    required String password,
  }) =>
      handleError(
        _login(studentID: studentId, password: password),
      );

  Future<void> _login({
    required String studentID,
    required String password,
  }) async {
    final NamedPair<Student, String> studentAndToken = await _authSource.login(
      studentID: studentID,
      password: password,
    );
    TokenManager.storeToken(studentAndToken.second);
    StudentManager.storeStudent(studentAndToken.first);
  }
}
