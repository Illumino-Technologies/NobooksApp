import 'package:flutter/foundation.dart';
import 'package:nobook/src/features/notes/subfeatures/document_editing/document_editing_barrel.dart';

abstract class DocumentEditingController extends ChangeNotifier {
  Future<void> initialize();

  static DocumentEditingController fromMap(Map<String, dynamic> map) {
    final DocumentEditorType type = DocumentEditorType.fromString(
      map[DocumentEditorType.serializerKey],
    );
    switch (type) {
      case DocumentEditorType.general:
        // TODO: Handle this case.
        break;
      case DocumentEditorType.text:
        // TODO: Handle this case.
        break;
      case DocumentEditorType.drawing:
        // TODO: Handle this case.
        break;
      case DocumentEditorType.math:
        // TODO: Handle this case.
        break;
      case DocumentEditorType.table:
        // TODO: Handle this case.
        break;
      default:
        return DrawingController.fromMap(map['controller']);
    }
    //TODO: change
    return DrawingController.fromMap(map['controller']);
  }

  Map<String, dynamic> toDataMap() {
    DocumentEditorType? type;

    switch (runtimeType) {
      case DrawingController:
        type = DocumentEditorType.drawing;
    }
    assert(
      type != null,
      'Document Editor Type must not be null after switch-case assignment',
    );

    return {
      DocumentEditorType.serializerKey: type!.toSerializerString,
      'controller': toMap(),
    };
  }

  Map<String, dynamic> toMap();
}
