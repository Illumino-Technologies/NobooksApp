part of 'school_source_interface.dart';

class FakeSchoolSource implements SchoolSourceInterface {
  final Duration delay;

  const FakeSchoolSource({
    this.delay = const Duration(milliseconds: 1000),
  });

  @override
  Future<School> fetchSchool({
    String? schoolId,
  }) {
    // TODO: implement fetchSchool
    throw UnimplementedError();
  }

  @override
  Future<School> fetchSchoolFor({
    String? studentId,
  }) {
    // TODO: implement fetchSchoolFor
    throw UnimplementedError();
  }

  @override
  Future<List<School>> fetchSchoolsByQuery({
    required String searchQuery,
  }) async {
    await Future.delayed(delay);
    return FakeSchoolData.schools
        .where((element) => element.name.contains(searchQuery.cleanLower))
        .toList();
  }
}
