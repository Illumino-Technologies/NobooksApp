import 'package:nobook/src/global/domain/models/models_barrel.dart';

abstract class User {
  final String id;
  final String firstname;
  final String lastname;
  final String profilePhoto;
  final Gender gender;
  final DateTime dob;
  final String? phoneNumber;

  const User({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.profilePhoto,
    required this.gender,
    required this.dob,
    this.phoneNumber,
  });

  Map<String, dynamic> toMap();

  User copyWith({
    String? id,
    String? firstname,
    String? profilePhoto,
    String? lastname,
  });
}
