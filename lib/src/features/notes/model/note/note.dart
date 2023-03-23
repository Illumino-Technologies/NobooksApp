import 'package:nobook/src/features/notes/subfeatures/document_editing/document_editing_barrel.dart';
import 'package:nobook/src/global/domain/models/models_barrel.dart';
import 'package:nobook/src/utils/function/util_functions/util_functions.dart';

class Note {
  final String id;
  final Subject subject;
  final String topic;
  final NoteDocument noteBody;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Note({
    required this.id,
    required this.subject,
    required this.topic,
    required this.noteBody,
    required this.createdAt,
    required this.updatedAt,
  });

  Note copyWith({
    String? id,
    Subject? subject,
    String? topic,
    NoteDocument? noteBody,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Note(
      id: id ?? this.id,
      subject: subject ?? this.subject,
      topic: topic ?? this.topic,
      noteBody: noteBody ?? this.noteBody,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'subject': subject.toMap(),
      'topic': topic,
      'noteBody': noteBody.toSerializerList(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'],
      subject: Subject.fromMap((map['subject'] as Map).cast()),
      topic: map['topic'] as String,
      noteBody: (map['noteBody'] as List)
          .cast<Map>()
          .map<DocumentEditingController>((e) {
        return DocumentEditingController.fromMap(
          e.cast<String, dynamic>(),
        );
      }).toList(),
      createdAt: UtilFunctions.dateTimeFromMap(map['createdAt'])!,
      updatedAt: UtilFunctions.dateTimeFromMap(map['updatedAt'])!,
    );
  }
}
