import 'package:flutter/material.dart';

class Subject {
  final String code;
  final String name;
  final Color color;

  const Subject({
    required this.code,
    required this.name,
    required this.color,
  });

  Map<String, dynamic> toMap() {
    return {
      'code': code,
      'name': name,
      'color': color.value.toRadixString(16),
    };
  }

  factory Subject.fromMap(Map<String, dynamic> map) {
    return Subject(
      code: map['code'] as String,
      name: map['name'] as String,
      color: Color(int.parse(map['color'], radix: 16)),
    );
  }
}
