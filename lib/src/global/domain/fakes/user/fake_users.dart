import 'package:nobook/src/global/domain/domain_barrel.dart';
import 'package:nobook/src/utils/utils_barrel.dart';

abstract class FakeUsers {
  static Student bolu = Student(
    id: 'hello there unique',
    firstname: 'Boluwatife',
    lastname: 'Ogunyemi',
    profilePhoto: Assets.profileImage,
    subjects: FakeSubjects.subjects,
    studentClass: FakeClasses.ss2,
    gender: Gender.male,
    phoneNumber: '08012345678',
    dob: DateTime(2005, 1, 1),
  );

  static Teacher mrOgunyemi = Teacher(
    id: 'hello there unique',
    firstname: 'Peter',
    lastname: 'Ogunyemi',
    profilePhoto: Assets.profileImage,
    gender: Gender.male,
    dob: DateTime(1996, 1, 1),
    phoneNumber: '08012345678',
    classesTaught: [FakeClasses.ss2, FakeClasses.ss3],
    subjectsTaught: FakeSubjects.subjects,
    email: 'peterogunyemi@gmail.com',
  );
}
