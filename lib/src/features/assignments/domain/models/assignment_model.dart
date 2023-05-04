import 'package:nobook/src/features/notes/notes_barrel.dart';
import 'package:nobook/src/features/notes/subfeatures/document_editing/document_editing_barrel.dart';
import 'package:nobook/src/global/domain/models/models_barrel.dart';
import 'package:nobook/src/utils/utils_barrel.dart';

part 'components/assignment_operation.dart';

class Assignment {
  final String id;
  final Subject subject;
  final String topic;
  final Teacher teacher;
  final List<AssignmentOperation> questions;
  final List<AssignmentOperation>? answers;
  final DateTime createdDate;
  final DateTime submissionDate;

  // final bool? submitted;

  Assignment({
    required this.id,
    required this.subject,
    required this.topic,
    required this.teacher,
    required this.questions,
    required this.answers,
    required this.createdDate,
    required this.submissionDate,
  });

  //fromMap and toMap functions
  Assignment.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        subject = Subject.fromMap(map['subject']),
        topic = map['topic'],
        teacher = Teacher.fromMap(map['teacher']),
        questions = map['questions'].map<NoteDocument>((e) {
          return UtilFunctions.noteDocumentFromList(e as List);
        }).toList(),
        answers = map['answers']?.map<NoteDocument>((e) {
          return UtilFunctions.noteDocumentFromList(e as List);
        }).toList(),
        createdDate = UtilFunctions.dateTimeFromMap(map['createdDate'])!,
        submissionDate = UtilFunctions.dateTimeFromMap(map['submissionDate'])!;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'subject': subject.toMap(),
      'topic': topic,
      'teacher': teacher.toMap(),
      'questions': questions.map((e) => e.toMap()).toList(),
      'answers': answers?.map((e) => e.toMap()).toList(),
      'createdDate': createdDate.toIso8601String(),
      'submissionDate': submissionDate.toIso8601String(),
    };
  }
}

/// Assignment
///   - id
///   - subject
///   - topic
///   - teacher
///   - List<NoteDocument> questions (read only)
///   - List<NoteDocument>? answers
///   - createdDate
///   - submissionDate
///
