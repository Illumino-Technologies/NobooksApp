import 'package:nobook/src/global/domain/fakes/fakes_barrel.dart';
import 'package:nobook/src/global/domain/models/models_barrel.dart';

abstract class FakeClasses {
  static List<Class> classes = [
    ss2,
    ss3,
  ];
  static final Class ss2 = Class(
    id: 'ss-2-x',
    name: 'SS 2',
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

  static final Class ss3 = Class(
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
