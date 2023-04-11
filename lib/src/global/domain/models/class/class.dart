import 'package:nobook/src/global/domain/models/models_barrel.dart';

class Class {
  final String id;
  final String name;
  final List<Subject> subjects;

  //TODO: confirm adding the following fields: class rep, class teacher, list of students.
  const Class({
    required this.id,
    required this.name,
    required this.subjects,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'subjects': subjects,
    };
  }

  factory Class.fromMap(Map<String, dynamic> map) {
    return Class(
      id: map['id'] as String,
      name: map['name'] as String,
      subjects: (map['subjects'] as List?)?.cast<Subject>() ?? [],
    );
  }

  Class copyWith({
    String? id,
    String? name,
    List<Subject>? subjects,
  }) {
    return Class(
      id: id ?? this.id,
      name: name ?? this.name,
      subjects: subjects ?? this.subjects,
    );
  }
}
