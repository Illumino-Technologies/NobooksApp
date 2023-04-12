import 'package:nobook/src/global/domain/domain_barrel.dart';
import 'package:nobook/src/utils/function/util_functions/util_functions.dart';

class Teacher extends User {
  final List<Subject> subjectsTaught;
  final List<Class> classesTaught;
  final String phoneNumber;
  final String email;

  const Teacher({
    required super.id,
    required super.firstname,
    required super.lastname,
    required super.profilePhoto,
    required this.subjectsTaught,
    required this.classesTaught,
    required super.gender,
    required super.dob,
    required this.phoneNumber,
    required this.email,
  });

  @override
  Teacher copyWith({
    String? id,
    String? firstname,
    String? profilePhoto,
    String? lastname,
    String? email,
    Gender? gender,
    DateTime? dob,
    String? phoneNumber,
    List<Subject>? subjectsTaught,
    List<Class>? classesTaught,
  }) {
    return Teacher(
      id: id ?? this.id,
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      profilePhoto: profilePhoto ?? this.profilePhoto,
      subjectsTaught: subjectsTaught ?? this.subjectsTaught,
      classesTaught: classesTaught ?? this.classesTaught,
      dob: dob ?? this.dob,
      email: email ?? this.email,
      gender: gender ?? this.gender,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firstname': firstname,
      'lastname': lastname,
      'profilePhoto': profilePhoto,
      'subjectsTaught': subjectsTaught.map((e) => e.toMap()).toList(),
      'classesTaught': classesTaught.map((e) => e.toMap()).toList(),
      'dob': dob,
      'email': email,
      'gender': gender.name,
      'phoneNumber': phoneNumber,
    };
  }

  factory Teacher.fromMap(Map<String, dynamic> map) {
    return Teacher(
      id: map['id'] as String,
      firstname: map['firstname'] as String,
      lastname: map['lastname'] as String,
      profilePhoto: map['profilePhoto'] as String,
      phoneNumber: map['phoneNumber'] as String,
      gender: Gender.values[map['gender'] as int],
      dob: UtilFunctions.dateTimeFromMap(map['dob'])!,
      email: map['email'] as String,
      classesTaught: (map['classesTaught'] as List?)?.map((e) {
            return Class.fromMap(e as Map<String, dynamic>);
          }).toList() ??
          [],
      subjectsTaught: (map['subjectsTaught'] as List?)?.map((e) {
            return Subject.fromMap(e as Map<String, dynamic>);
          }).toList() ??
          [],
    );
  }
}
