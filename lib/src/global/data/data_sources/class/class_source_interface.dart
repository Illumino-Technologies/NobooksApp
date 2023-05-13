part of 'class_source.dart';

abstract class ClassSourceInterface {
  Future<Class> fetchStudentClass(String studentId);

  Future<List<Class>> fetchStudentClasses(String studentId);
}
