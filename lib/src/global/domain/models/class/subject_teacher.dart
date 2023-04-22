part of 'class.dart';

/// a model class for subject and their respective teacher(s)
class SubjectTeachers {
  final Subject subject;
  final List<Teacher> teachers;

  const SubjectTeachers({
    required this.subject,
    required this.teachers,
  });

  Map<String, dynamic> toMap() {
    return {
      'subject': subject.toMap(),
      'teachers': teachers.map((e) => e.toMap()).toList(),
    };
  }

  factory SubjectTeachers.fromMap(Map<String, dynamic> map) {
    return SubjectTeachers(
      subject: Subject.fromMap(map['subject'] as Map<String, dynamic>),
      teachers: (map['teachers'] as List?)
              ?.cast<Map>()
              .map<Teacher>((e) => Teacher.fromMap(e.cast<String, dynamic>()))
              .toList() ??
          [],
    );
  }

  SubjectTeachers copyWith({
    Subject? subject,
    List<Teacher>? teachers,
  }) {
    return SubjectTeachers(
      subject: subject ?? this.subject,
      teachers: teachers ?? this.teachers,
    );
  }
}
