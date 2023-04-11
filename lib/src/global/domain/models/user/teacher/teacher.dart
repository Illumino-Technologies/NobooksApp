import 'package:nobook/src/global/domain/domain_barrel.dart';

class Teacher extends User {
  const Teacher({
    required super.id,
    required super.firstname,
    required super.lastname,
    required super.profilePhoto,
  });

  //TODO: check to add fields the following fields: subject(s) taught, class(es) taught, gender, dob, phone number, email, address, etc

  @override
  Teacher copyWith({
    String? id,
    String? firstname,
    String? profilePhoto,
    String? lastname,
  }) {
    return Teacher(
      id: id ?? this.id,
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      profilePhoto: profilePhoto ?? this.profilePhoto,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firstname': firstname,
      'lastname': lastname,
      'profilePhoto': profilePhoto,
    };
  }
}
