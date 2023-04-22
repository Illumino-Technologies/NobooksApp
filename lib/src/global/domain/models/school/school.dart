import 'package:nobook/src/global/domain/models/models_barrel.dart';

class School {
  final String id;
  final String name;
  final String shortName;
  final String email;
  final String contactNumber;
  final String address;
  final String logo;
  final String? motto;
  final String? vision;
  final String? mission;
  final List<TimeTable> timetables;

  const School({
    required this.id,
    required this.name,
    required this.shortName,
    required this.email,
    required this.contactNumber,
    required this.address,
    required this.logo,
    required this.motto,
    required this.vision,
    required this.mission,
    required this.timetables,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'shortName': shortName,
      'email': email,
      'contactNumber': contactNumber,
      'address': address,
      'logo': logo,
      'motto': motto,
      'vision': vision,
      'mission': mission,
      'timetables': timetables.map((e) => e.toMap()).toList(),
    };
  }

  factory School.fromMap(Map<String, dynamic> map) {
    return School(
      id: map['id'] as String,
      name: map['name'] as String,
      shortName: map['shortName'] as String,
      email: map['email'] as String,
      contactNumber: map['contactNumber'] as String,
      address: map['address'] as String,
      logo: map['logo'] as String,
      motto: map['motto'] as String,
      vision: map['vision'] as String,
      mission: map['mission'] as String,
      timetables: (map['timetables'] as List?)
              ?.cast<Map>()
              .map((e) => TimeTable.fromMap(e.cast<String, dynamic>()))
              .toList() ??
          [],
    );
  }
}
