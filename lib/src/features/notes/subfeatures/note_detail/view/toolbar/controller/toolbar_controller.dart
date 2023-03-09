import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nobook/src/features/notes/subfeatures/note_detail/view/base_controller.dart';
import 'package:nobook/src/features/notes/subfeatures/note_detail/view/drawing_controller.dart';
import 'package:nobook/src/utils/utils_barrel.dart';

class ToolbarController extends ChangeNotifier
    implements DocumentEditingController {
  DrawingController drawingController = DrawingController();

  ToolbarController() {
    drawingController.addListener(drawingControllerListener);
  }

  bool _initialized = false;

  bool get initialized => _initialized;

  @override
  Future<void> initialize() async {
    await drawingController.initialize();
    _initialized = true;
  }

  void drawingControllerListener() {}

  late final List<DocumentEditingController> cache = [];

  void setDocumentValue(DocumentEditingController controller) {
    if (controller is DrawingController) {
      drawingController = controller;
      notifyListeners();
    }
  }

  bool get canUndo => cache.isNotEmpty && cache.length > 1;

  bool get canRedo =>
      cache.isNotEmpty &&
      cache.length > 1 &&
      cache.contains(activeController) &&
      !cache.isLast(activeController);

  void undo() {
    assertInitialized();
    if (!canUndo) return;
    setDocumentValue(cache[cache.length - 2]);
  }

  DocumentEditingController get activeController {
    //TODO: check action stack for other controllers
    return drawingController;
  }

  void redo() {
    if (!canRedo) return;
    final int currentControllerIndex = cache.indexOf(activeController);
    setDocumentValue(cache[currentControllerIndex + 1]);
  }

  void assertInitialized() {
    assert(initialized, 'controller must be initialized');
  }

  @override
  void dispose() {
    super.dispose();
    drawingController.dispose();
  }

}
