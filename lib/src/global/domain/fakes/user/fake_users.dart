import 'package:nobook/src/global/domain/domain_barrel.dart';
import 'package:nobook/src/utils/utils_barrel.dart';

abstract class FakeUsers {
  static const Student bolu = Student(
    id: 'hello there unique',
    firstname: 'Boluwatife',
    lastname: 'Ogunyemi',
    profilePhoto: Assets.profileImage,
    subjects: FakeSubjects.subjects,
    studentClass: FakeClasses.ss2,
  );

  static const Teacher mrOgunyemi = Teacher(
    id: 'hello there unique',
    firstname: 'Peter',
    lastname: 'Ogunyemi',
    profilePhoto: Assets.profileImage,
  );
}
