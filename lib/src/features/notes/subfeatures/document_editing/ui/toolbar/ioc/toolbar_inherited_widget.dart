import 'package:flutter/material.dart';
import 'package:nobook/src/features/notes/subfeatures/document_editing/document_editing_barrel.dart';

class NoteDocumentContainer extends InheritedWidget {
  final NoteDocumentController controller;

  const NoteDocumentContainer({
    required this.controller,
    required super.child,
    super.key,
  });

  static NoteDocumentContainer? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<NoteDocumentContainer>();
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }
}
