part of 'student_source_interface.dart';

class FakeStudentSource implements StudentSourceInterface {
  final Duration delay;

  const FakeStudentSource({
    this.delay = const Duration(milliseconds: 1000),
  });

  @override
  Future<Student> fetchStudent({
    String? studentId,
  }) async {
    await Future.delayed(delay);
    return FakeUsers.bolu;
  }
}
