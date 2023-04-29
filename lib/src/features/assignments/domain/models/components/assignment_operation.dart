part of '../assignment_model.dart';

class AssignmentOperation {
  final String serialId;
  final NoteDocument content;
  final DateTime createdAt;
  final DateTime updatedAt;

  const AssignmentOperation({
    required this.serialId,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
  });

  //generate fromMap and toMap functions
  AssignmentOperation.fromMap(Map<String, dynamic> map)
      : serialId = map['serialId'],
        content =  UtilFunctions.noteDocumentFromList(map['content']),
        createdAt = UtilFunctions.dateTimeFromMap(map['createdAt'])!,
        updatedAt = UtilFunctions.dateTimeFromMap(map['updatedAt'])!;

  Map<String, dynamic> toMap() {
    return {
      'serialId': serialId,
      'content': content.toSerializerList(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
