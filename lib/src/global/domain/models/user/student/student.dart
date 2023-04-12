import 'package:nobook/src/global/domain/domain_barrel.dart';
import 'package:nobook/src/utils/function/util_functions/util_functions.dart';

class Student extends User {
  final Class studentClass;
  final List<Subject> subjects;

  const Student({
    required super.id,
    required this.studentClass,
    required this.subjects,
    required super.firstname,
    required super.lastname,
    required super.profilePhoto,
    required super.gender,
    required super.dob,
    required super.phoneNumber,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'studentClass': studentClass.toMap(),
      'subjects': subjects.map((e) => e.toMap()).toList(),
      'firstname': firstname,
      'lastname': lastname,
      'profilePhoto': profilePhoto,
      'gender': gender,
      'dob': dob,
      'phoneNumber': phoneNumber,
    };
  }

  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      id: map['id'] as String,
      studentClass: Class.fromMap((map['studentClass'] as Map).cast()),
      subjects: (map['subjects'] as List?)?.map((e) {
            return Subject.fromMap(e);
          }).toList() ??
          [],
      firstname: map['firstname'] as String,
      lastname: map['lastname'] as String,
      profilePhoto: map['profilePhoto'] as String,
      gender: Gender.values[(map['gender'])],
      phoneNumber: map['phoneNumber'] as String,
      dob: UtilFunctions.dateTimeFromMap(map['dob'])!,
    );
  }

  @override
  Student copyWith({
    String? id,
    String? firstname,
    String? profilePhoto,
    String? lastname,
    Class? studentClass,
    List<Subject>? subjects,
    final Gender? gender,
    final DateTime? dob,
    final String? phoneNumber,
  }) {
    return Student(
      id: id ?? this.id,
      studentClass: studentClass ?? this.studentClass,
      subjects: subjects ?? this.subjects,
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      profilePhoto: profilePhoto ?? this.profilePhoto,
      dob: dob ?? this.dob,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      gender: gender ?? this.gender,
    );
  }
}
