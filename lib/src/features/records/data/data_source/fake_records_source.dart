part of 'records_source.dart';

class FakeRecordsSource implements RecordsSourceInterface {
  @override
  Future<Map<Class, List<Grade>>> fetchAllGrades() async {
    await Future.delayed(
      const Duration(milliseconds: 1000),
    );
    return FakeGrades.classGrades;
  }

  @override
  Future<List<Grade>> fetchGradesForClass(Class class_) async {
    await Future.delayed(
      const Duration(milliseconds: 1000),
    );
    return FakeGrades.classGrades[class_] ?? [];
  }
}
