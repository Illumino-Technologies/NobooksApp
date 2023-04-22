import 'package:nobook/src/utils/utils_barrel.dart';

class ClassGradingSystem {
  final String gradeClassId;
  final Map<DoubleRange, String> gradings;

  const ClassGradingSystem({
    required this.gradeClassId,
    required this.gradings,
  });

  Map<String, dynamic> toMap() {
    return {
      'gradeClassId': gradeClassId,
      'grading': gradings.map<List<double>, String>(
        (key, value) => MapEntry<List<double>, String>(key.toList(), value),
      ),
    };
  }

  factory ClassGradingSystem.fromMap(Map<String, dynamic> map) {
    return ClassGradingSystem(
      gradeClassId: map['gradeClassId'] as String,
      gradings: (map['grading'] as Map).cast(),
    );
  }
}
