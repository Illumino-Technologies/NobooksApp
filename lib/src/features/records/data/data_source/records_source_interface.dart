part of 'records_source.dart';

abstract class RecordsSourceInterface {
  Future<Map<Class, List<Grade>>> fetchAllGrades();

  Future<List<Grade>> fetchGradesForClass(Class class_);
}
