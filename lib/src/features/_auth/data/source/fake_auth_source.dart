part of 'auth_source_interface.dart';

class FakeAuthSource implements AuthSourceInterface {
  final Duration delay;

  FakeAuthSource({
    this.delay = const Duration(milliseconds: 1000),
  });

  @override
  Future<NamedPair<Student, String>> login({
    required String studentID,
    required String password,
  }) async {
    await Future.delayed(delay);
    return (
      first: FakeUsers.bolu,
      second: 'my_random_token_aldsfjalsdjkfa_asfdasasdf_adsfas_!#!@fdada',
    );
  }

  @override
  Future<void> logout() async {
    await Future.delayed(delay);
  }

  @override
  Future<void> changePassword({
    required String studentId,
    required String password,
  }) async {
    await Future.delayed(delay);
  }

  @override
  Future<void> requestLoginDetails({
    required String schoolId,
    required String email,
    required String fullName,
  }) async {
    await Future.delayed(delay);
  }
}
