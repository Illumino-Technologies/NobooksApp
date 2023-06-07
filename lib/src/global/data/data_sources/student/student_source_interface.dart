import 'package:nobook/src/global/domain/domain_barrel.dart';

part 'fake_student_source.dart';

abstract interface class StudentSourceInterface {
  Future<Student> fetchStudent({
    String? studentId,
  });
}
