import 'package:nobook/src/global/domain/models/models_barrel.dart';
import 'package:nobook/src/utils/function/util_functions/util_functions.dart';

class Note {
  final Subject subject;
  final String topic;
  final dynamic noteBody;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Note({
    required this.subject,
    required this.topic,
    required this.noteBody,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'subject': subject,
      'topic': topic,
      'noteBody': noteBody,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      subject: Subject.fromMap(map['subject']),
      topic: map['topic'] as String,
      noteBody: map['noteBody'],
      createdAt: UtilFunctions.dateTimeFromMap(map['createdAt'])!,
      updatedAt: UtilFunctions.dateTimeFromMap(map['updatedAt'])!,
    );
  }
}
