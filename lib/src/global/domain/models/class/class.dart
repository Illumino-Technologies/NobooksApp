import 'package:nobook/src/global/domain/fakes/grading_system/fake_grading_system.dart';
import 'package:nobook/src/global/domain/models/models_barrel.dart';
import 'package:nobook/src/utils/constants/constants_barrel.dart';

part 'subject_teacher.dart';

class Class extends Equatable {
  final String id;
  final String name;
  final List<Subject> subjects;
  final Student? classCaptain;
  final Student? assistantClassCaptain;
  final Teacher classTeacher;
  final List<SubjectTeachers> subjectTeachers;
  final List<Student> students;

  const Class({
    required this.id,
    required this.name,
    required this.subjects,
    required this.classTeacher,
    required this.subjectTeachers,
    this.classCaptain,
    this.assistantClassCaptain,
    required this.students,
  });

  Map<DoubleRange, String> get gradings {
    return FakeGradingSystem.fakeGradingSystem
        .firstWhere((element) => element.gradeClassId == id)
        .gradings;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'subjects': subjects.map((e) => e.toMap()).toList(),
      'students': students.map((e) => e.toMap()).toList(),
      'subjectTeachers': subjectTeachers.map((e) => e.toMap()).toList(),
      'classTeacher': classTeacher.toMap(),
      'classCaptain': classCaptain?.toMap(),
      'assistantClassCaptain': assistantClassCaptain?.toMap(),
    };
  }

  factory Class.fromMap(Map<String, dynamic> map) {
    return Class(
      id: map['id'] as String,
      name: map['name'] as String,
      subjects: (map['subjects'] as List?)
              ?.cast<Map>()
              .map<Subject>((e) => Subject.fromMap(e.cast<String, dynamic>()))
              .toList() ??
          [],
      students: (map['students'] as List?)
              ?.cast<Map>()
              .map<Student>((e) => Student.fromMap(e.cast<String, dynamic>()))
              .toList() ??
          [],
      subjectTeachers: (map['subjectTeachers'] as List?)
              ?.cast<Map>()
              .map<SubjectTeachers>(
                  (e) => SubjectTeachers.fromMap(e.cast<String, dynamic>()))
              .toList() ??
          [],
      classTeacher:
          Teacher.fromMap(map['classTeacher'] as Map<String, dynamic>),
      classCaptain: map['classCaptain'] == null
          ? null
          : Student.fromMap(map['classCaptain'] as Map<String, dynamic>),
      assistantClassCaptain: map['assistantClassCaptain'] == null
          ? null
          : Student.fromMap(
              map['assistantClassCaptain'] as Map<String, dynamic>,
            ),
    );
  }

  Class copyWith({
    String? id,
    String? name,
    List<Subject>? subjects,
    List<SubjectTeachers>? subjectTeachers,
    List<Student>? students,
    Student? classCaptain,
    Student? assistantClassCaptain,
    Teacher? classTeacher,
  }) {
    return Class(
      id: id ?? this.id,
      name: name ?? this.name,
      subjects: subjects ?? this.subjects,
      subjectTeachers: subjectTeachers ?? this.subjectTeachers,
      students: students ?? this.students,
      classCaptain: classCaptain ?? this.classCaptain,
      assistantClassCaptain:
          assistantClassCaptain ?? this.assistantClassCaptain,
      classTeacher: classTeacher ?? this.classTeacher,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        ...subjects,
        ...subjectTeachers,
        ...students,
        classCaptain,
        assistantClassCaptain,
        classTeacher,
      ];
}
