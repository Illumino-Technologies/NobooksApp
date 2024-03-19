abstract class ApiPaths {
  static const String baseUrl = 'https://nobooks.onrender.com/api';

  static const String login = "$baseUrl/login";
  static const String records = "$baseUrl/student/records";

  static String class_(String studentId) => "$baseUrl/class/$studentId";

  static String classes(String studentId) => "$baseUrl/classes/$studentId";

  static String recordsForClass(String classId) =>
      '$baseUrl/student/records/$classId';
}
