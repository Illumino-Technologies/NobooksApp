part of 'auth_source_interface.dart';

final class NetworkAuthSource implements AuthSourceInterface {
  final Dio _client;

  NetworkAuthSource({
    required NetworkApi? api,
  }) : _client = (api ?? NetworkApi()).client;

  @override
  Future<String> changePassword({
    required String studentId,
    required String password,
  }) {
    // TODO: implement changePassword
    throw UnimplementedError();
  }

  @override
  Future<NamedPair<Student, String>> login({
    required String studentID,
    required String password,
  }) async {
    final Response response = await _client.post(
      ApiPaths.login,
      options: Options(contentType: Headers.jsonContentType),
      data: jsonEncode({
        'student_id': studentID,
        'password': password,
      }),
    );

    final String token = response.data as String;

    return (first: FakeUsers.bolu, second: token);
  }

  @override
  Future<void> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  Future<void> requestLoginDetails({
    required String schoolId,
    required String email,
    required String fullName,
  }) {
    // TODO: implement requestLoginDetails
    throw UnimplementedError();
  }
}
