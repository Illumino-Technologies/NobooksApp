import 'package:nobook/src/features/assessments/assessments_barrel.dart';
import 'package:nobook/src/features/notes/subfeatures/document_editing/document_editing_barrel.dart';
import 'package:nobook/src/global/domain/models/models_barrel.dart' show Subject, TermPeriod;
import 'package:nobook/src/utils/utils_barrel.dart';

part 'content/assessment_operation.dart';

part 'content/question_type.dart';

class Assessment implements Comparable<Assessment> {
  final String id;
  final Subject subject;
  final List<QuestionType> questionTypes;
  final List<AssessmentOperation> assessments;
  final int duration;
  final DateTime startTime;
  final DateTime endTime;
  final TermPeriod term;
  final int? assessmentNumber;
  final String session;
  final int? totalMarks;
  final AssessmentType type;

  const Assessment({
    required this.term,
    required this.assessmentNumber,
    required this.session,
    required this.id,
    required this.subject,
    required this.questionTypes,
    required this.assessments,
    required this.duration,
    required this.startTime,
    required this.endTime,
    required this.type,
    this.totalMarks,
  });

  int get totalQuestions {
    return assessments.length;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'subject': subject.toMap(),
      'questionTypes': questionTypes.map((e) => e.index).toList(),
      'assessments': assessments.map((e) => e.toMap()).toList(),
      'duration': duration,
      'startTime': startTime.toIso8601String(),
      'endTime': endTime.toIso8601String(),
      'totalMarks': totalMarks,
    };
  }

  factory Assessment.fromMap(Map<String, dynamic> map) {
    return Assessment(
      id: map['id'] as String,
      subject: Subject.fromMap(map['subject'] as Map<String, dynamic>),
      questionTypes:
          (map['questionTypes'] as List?)?.cast<Map>().map<QuestionType>((e) {
                return QuestionType.values[e as int];
              }).toList() ??
              [],
      assessments: (map['assessments'] as List?)
              ?.cast<Map>()
              .map<AssessmentOperation>((e) {
            return AssessmentOperation.fromMap(e.cast<String, dynamic>());
          }).toList() ??
          [],
      duration: map['duration'] as int,
      startTime: UtilFunctions.dateTimeFromMap(map['startTime'])!,
      endTime: UtilFunctions.dateTimeFromMap(map['endTime'])!,
      totalMarks: map['totalMarks'] as int?,
      term: map['term'] == null
          ? TermPeriod.first
          : TermPeriod.values[map['term'] as int],
      assessmentNumber: map['assessmentNumber'] as int? ?? 0,
      session: map['session'] as String? ?? '',
      type: AssessmentType.values[map['type'] as int],
    );
  }

  Assessment copyWith({
    String? id,
    Subject? subject,
    List<QuestionType>? questionTypes,
    List<AssessmentOperation>? assessments,
    int? duration,
    DateTime? startTime,
    DateTime? endTime,
    int? totalMarks,
    TermPeriod? term,
    int? assessmentNumber,
    String? session,
    AssessmentType? type,
  }) {
    return Assessment(
      id: id ?? this.id,
      subject: subject ?? this.subject,
      questionTypes: questionTypes ?? this.questionTypes,
      assessments: assessments ?? this.assessments,
      duration: duration ?? this.duration,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      totalMarks: totalMarks ?? this.totalMarks,
      term: term ?? this.term,
      assessmentNumber: assessmentNumber ?? this.assessmentNumber,
      session: session ?? this.session,
      type: type ?? this.type,
    );
  }

  @override
  int compareTo(Assessment other) => startTime.compareTo(other.startTime);
}
