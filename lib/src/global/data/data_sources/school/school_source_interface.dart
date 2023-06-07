import 'package:nobook/src/global/domain/domain_barrel.dart';
import 'package:nobook/src/utils/utils_barrel.dart';

part 'fake_school_source.dart';

abstract interface class SchoolSourceInterface {
  Future<School> fetchSchool({
    String? schoolId,
  });

  Future<School> fetchSchoolFor({
    String? studentId,
  });

  Future<List<School>> fetchSchoolsByQuery({
    required String searchQuery,
  });
}
