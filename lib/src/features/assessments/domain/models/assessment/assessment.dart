import 'package:nobook/src/features/assessments/assessments_barrel.dart';
import 'package:nobook/src/features/notes/subfeatures/document_editing/document_editing_barrel.dart';
import 'package:nobook/src/global/domain/models/models_barrel.dart'
    show Subject, TermPeriod;
import 'package:nobook/src/utils/utils_barrel.dart';

part 'content/assessment_operation.dart';

part 'content/question_type.dart';

class Assessment implements Comparable<Assessment> {
  final String id;
  final Subject subject;
  final PaperType paperType;
  final List<AssessmentOperation> assessments;
  final int duration;
  final DateTime startTime;
  final DateTime endTime;
  final TermPeriod term;
  final String session;
  final AssessmentType type;
  final NoteDocument assessmentInstructions;
  final NoteDocument assessmentConduct;
  final NoteDocument studentDeclaration;
  final int? assessmentNumber;

  const Assessment({
    required this.term,
    required this.session,
    required this.id,
    required this.subject,
    required this.paperType,
    required this.assessments,
    required this.duration,
    required this.startTime,
    required this.endTime,
    required this.type,
    required this.assessmentInstructions,
    required this.assessmentConduct,
    required this.studentDeclaration,
    required this.assessmentNumber,
  });

  int? get totalMark {
    return assessments.fold<int>(0, (previousValue, element) {
      return previousValue + (element.marks ?? 0);
    }).nullIfZero;
  }

  int get totalQuestions {
    return assessments.length;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'subject': subject.toMap(),
      'examType': paperType.index,
      'assessments': assessments.map((e) => e.toMap()).toList(),
      'duration': duration,
      'startTime': startTime.toIso8601String(),
      'endTime': endTime.toIso8601String(),
      'term': term.index,
      'session': session,
      'type': type.index,
      'assessmentInstructions': assessmentInstructions.toSerializerList(),
      'assessmentConduct': assessmentConduct.toSerializerList(),
      'studentDeclaration': studentDeclaration.toSerializerList(),
      'assessmentNumber': assessmentNumber,
    };
  }

  factory Assessment.fromMap(Map<String, dynamic> map) {
    return Assessment(
      id: map['id'] as String,
      subject: Subject.fromMap(map['subject'] as Map<String, dynamic>),
      paperType: PaperType.values[map['examType'] as int],
      assessments: (map['assessments'] as List?)
              ?.cast<Map>()
              .map<AssessmentOperation>((e) {
            return AssessmentOperation.fromMap(e.cast<String, dynamic>());
          }).toList() ??
          [],
      duration: map['duration'] as int,
      startTime: UtilFunctions.dateTimeFromMap(map['startTime'])!,
      endTime: UtilFunctions.dateTimeFromMap(map['endTime'])!,
      term: map['term'] == null
          ? TermPeriod.first
          : TermPeriod.values[map['term'] as int],
      session: map['session'] as String? ?? '',
      type: AssessmentType.values[map['type'] as int],
      assessmentConduct: UtilFunctions.noteDocumentFromList(map['conduct']),
      assessmentInstructions: UtilFunctions.noteDocumentFromList(
        map['assessmentInstructions'],
      ),
      studentDeclaration: UtilFunctions.noteDocumentFromList(
        map['studentDeclaration'],
      ),
      assessmentNumber: map['assessmentNumber'] as int?,
    );
  }

  Assessment copyWith({
    String? id,
    Subject? subject,
    PaperType? examType,
    List<AssessmentOperation>? assessments,
    int? duration,
    DateTime? startTime,
    DateTime? endTime,
    int? totalMarks,
    TermPeriod? term,
    int? assessmentNumber,
    String? session,
    AssessmentType? type,
    NoteDocument? assessmentInstructions,
    NoteDocument? assessmentConduct,
    NoteDocument? studentDeclaration,
  }) {
    return Assessment(
      id: id ?? this.id,
      subject: subject ?? this.subject,
      paperType: examType ?? this.paperType,
      assessments: assessments ?? this.assessments,
      duration: duration ?? this.duration,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      term: term ?? this.term,
      assessmentNumber: assessmentNumber ?? this.assessmentNumber,
      session: session ?? this.session,
      type: type ?? this.type,
      assessmentInstructions:
          assessmentInstructions ?? this.assessmentInstructions,
      assessmentConduct: assessmentConduct ?? this.assessmentConduct,
      studentDeclaration: studentDeclaration ?? this.studentDeclaration,
    );
  }

  @override
  int compareTo(Assessment other) => startTime.compareTo(other.startTime);
}
