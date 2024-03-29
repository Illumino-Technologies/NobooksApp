import 'package:nobook/src/global/domain/domain_barrel.dart';
import 'package:nobook/src/utils/constants/constants_barrel.dart';
import 'package:nobook/src/utils/function/extensions/extensions.dart';

class Grade {
  final String id;

  /// This is the subject for which the grade is being recorded
  final Subject subject;

  /// This is the exam score for the subject
  final double? examScore;

  /// This is the list of C.A. scores for the subject
  final List<double>? caScores;

  /// This is the percentage of all the CA scores in the total grade score
  final double caPercent;

  /// This is the percentage of exam score in the total grade score
  final double examPercent;
  final TermPeriod term;

  double? get _totalCa => caScores?.fold<double>(
        0,
        (previousValue, element) => element + previousValue,
      );

  double? get ca => _totalCa;

  double? get exam => examScore;

  double? get total => ((ca ?? 0) + (exam ?? 0)).nullIfZero;

  String? gradingFor(Class gClass) {
    return gClass.gradings.getGrading(total ?? 0);
  }

  const Grade({
    required this.id,
    required this.subject,
    required this.examScore,
    required this.caScores,
    required this.caPercent,
    required this.examPercent,
    required this.term,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'subject': subject.toMap(),
      'examScore': examScore,
      'caScores': caScores,
      'maxCaScore': caPercent,
      'maxExamScore': examPercent,
      'term': term.index,
    };
  }

  factory Grade.fromMap(Map<String, dynamic> map) {
    return Grade(
      id: map['id'] as String,
      subject: Subject.fromMap(map['subject'] as Map<String, dynamic>),
      examScore: map['examScore'] as double?,
      caScores: (map['caScores'] as List?)?.cast() ?? [],
      caPercent: map['maxCaScore'] as double,
      examPercent: map['maxExamScore'] as double,
      term: TermPeriod.values[map['term'] as int],
    );
  }
}
