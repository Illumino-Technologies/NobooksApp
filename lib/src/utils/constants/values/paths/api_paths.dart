abstract class ApiPaths {
  static const String _baseUrl = 'http://18.170.166.210/api/v1';
  static const String _baseAuthUrl = 'http://18.170.166.210/api-auth';

  ///sign up
  static const String users = '$_baseUrl/users';
  static const String validateEgotag = '$_baseUrl/users/validate_username';

  ///
  static const String currentUser = '$_baseUrl/users/me';

  static const String login = '$_baseUrl/users/login';

  static String user(String id) => '$_baseUrl/users/$id';

  static String verifyPhoneOtp(String id) => '$users/$id/register-phone';

  static const String resendOtp = '$users/resend-otp';
}
