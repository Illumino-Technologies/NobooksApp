abstract class ApiPaths {
  static const String _baseUrl = '';

  static const String login = "$_baseUrl/login";
  static const String records = "$_baseUrl/student/records";

  static String recordsForClass(String classId) =>
      '$_baseUrl/student/records/$classId';
}
