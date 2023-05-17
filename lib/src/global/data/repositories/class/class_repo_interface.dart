part of 'class_repository.dart';

abstract class ClassRepoInterface {
  Class? get currentClass;

  List<Class> get classes;

  Future<List<Class>> fetchClassesIfEmpty(String studentId);

  Future<Class> fetchCurrentClass(String studentId);

  Future<List<Class>> fetchStudentClasses(
    String studentId, {
    bool fetchAFresh = false,
  });
}
