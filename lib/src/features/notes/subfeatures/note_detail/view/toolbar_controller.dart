import 'package:flutter/foundation.dart';
import 'package:nobook/src/features/notes/subfeatures/note_detail/view/base_controller.dart';
import 'package:nobook/src/features/notes/subfeatures/note_detail/view/drawing_controller.dart';

import '../../document_editing/drawing/drawing_barrel.dart';

class ToolbarController extends ChangeNotifier
    implements DocumentEditingController {
  final DrawingController drawingController;

  ToolbarController({
    required this.drawingController,
  }) {
    drawingController.addListener(notifyListeners);
  }

  @override
  Future<void> initialize() async {
    await drawingController.initialize();
  }

  final List<Drawings> drawingsCache = [];

  void undo() {}

  void redo() {}

  @override
  void dispose() {
    super.dispose();
    drawingController.dispose();
  }
}
