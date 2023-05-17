import 'dart:math' as math;

import 'package:nobook/src/global/domain/domain_barrel.dart';
import 'package:nobook/src/utils/utils_barrel.dart';

abstract class FakeUsers {
  static final Student bolu = Student(
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

  static final Teacher mrOgunyemi = Teacher(
    id: 'hello there unique',
    firstname: 'Peter',
    lastname: 'Ogunyemi',
    profilePhoto: Assets.profileImage,
    gender: Gender.male,
    dob: DateTime(1996, math.Random().nextInt(10) + 1, 3),
    phoneNumber: '08012345678',
    // This is intentionally empty to avoid stackoverflow issues with
    // constructors calling themselves
    classesTaught: [],
    subjectsTaught: FakeSubjects.subjects,
    email: 'peterogunyemi@gmail.com',
  );

  static final Teacher mrAkpan = Teacher(
    id: 'hello there unique',
    firstname: 'Peter',
    lastname: 'Akpan',
    profilePhoto: Assets.profileImage,
    gender: Gender.male,
    dob: DateTime(1996, math.Random().nextInt(10) + 1, 3),
    phoneNumber: '08012345678',
    // This is intentionally empty to avoid stackoverflow issues with
    // constructors calling themselves
    classesTaught: [],
    subjectsTaught: FakeSubjects.subjects,
    email: 'peterogunyemi@gmail.com',
  );
}
