import 'package:nobook/src/features/notes/subfeatures/document_editing/ui/toolbar/toolbar_barrel.dart'
    show ToolBarItem;

part 'document_editor_type_extension.dart';

enum DocumentEditorType {
  general([
    ToolBarItem.undo,
    ToolBarItem.redo,
    ToolBarItem.roughPaper,
    ToolBarItem.calculator,
    ToolBarItem.pen,
    ToolBarItem.table,
    ToolBarItem.equation,
    ToolBarItem.color,
  ]),
  text([
    ToolBarItem.alignLeft,
    ToolBarItem.alignCenter,
    ToolBarItem.alignRight,
    ToolBarItem.bold,
    ToolBarItem.italic,
    ToolBarItem.underline,
    ToolBarItem.subscript,
    ToolBarItem.superscript,
  ]),
  drawing([
    ToolBarItem.shapes,
    ToolBarItem.ruler,
    ToolBarItem.eraser,
    ToolBarItem.pen,
    ToolBarItem.roughPaper,
  ]),
  math([
    ToolBarItem.equation,
  ]),
  table([
    ToolBarItem.table,
  ]),
  ;

  final List<ToolBarItem> toolBarItems;

  const DocumentEditorType(this.toolBarItems);

  factory DocumentEditorType.fromString(String data) {
    switch (data) {
      case 'drawing':
        return DocumentEditorType.drawing;
      case 'text':
        return DocumentEditorType.text;
      case 'math':
        return DocumentEditorType.math;
      case 'table':
        return DocumentEditorType.table;
      default:
        //TODO: have a default
        return DocumentEditorType.drawing;
    }
  }

  String get toSerializerString => name;

  static const String serializerKey = 'document-editor-type';
}
