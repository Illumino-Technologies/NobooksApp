import 'package:nobook/src/global/domain/fakes/fakes_barrel.dart';
import 'package:nobook/src/global/domain/models/models_barrel.dart';

abstract class FakeClasses {
  static Class ss2 = Class(
    id: 'uniqueString-x',
    name: 'SS 3',
    subjects: FakeSubjects.subjects,
    classTeacher: FakeUsers.mrAkpan,
    students: [],
    subjectTeachers: FakeSubjects.subjects.map((e) {
      return SubjectTeachers(
        subject: e,
        teachers: [],
      );
    }).toList(),
  );

  static Class ss3 = Class(
    id: 'uniqueString-x-ss3',
    name: 'SS 3',
    subjects: FakeSubjects.subjects,
    classTeacher: FakeUsers.mrOgunyemi,
    students: [],
    subjectTeachers: FakeSubjects.subjects.map((e) {
      return SubjectTeachers(
        subject: e,
        teachers: [],
      );
    }).toList(),
  );
}
