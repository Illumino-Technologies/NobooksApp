part of 'class_source.dart';

class FakeClassSource implements ClassSourceInterface {
  @override
  Future<Class> fetchStudentClass(String studentId) async {
    await Future.delayed(const Duration(seconds: 1));
    return FakeClasses.ss3;
  }

  @override
  Future<List<Class>> fetchStudentClasses(String studentId) async {
    await Future.delayed(const Duration(seconds: 1));
    return FakeClasses.classes;
  }
}
