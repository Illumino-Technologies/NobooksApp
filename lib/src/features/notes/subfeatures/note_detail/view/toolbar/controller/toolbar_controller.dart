import 'package:flutter/material.dart';
import 'package:nobook/src/features/features_barrel.dart';
import 'package:nobook/src/features/notes/subfeatures/note_detail/view/base_controller.dart';
import 'package:nobook/src/features/notes/subfeatures/note_detail/view/drawing_controller.dart';
import 'package:nobook/src/global/ui/ui_barrel.dart';
import 'package:nobook/src/utils/utils_barrel.dart';

class ToolbarController extends ChangeNotifier
    implements DocumentEditingController {
  DrawingController drawingController = DrawingController();
  late DrawingController previousDrawingController = drawingController.copy();

  String myString = 'hello world';
  late String previousMyString = myString;

  ToolbarController() {
    drawingController.addListener(drawingControllerListener);
  }

  late Color _color;

  Color get color => _color;

  bool _initialized = false;

  bool get initialized => _initialized;

  @override
  Future<void> initialize({Color? color}) async {
    _color = color ?? AppColors.black;
    await drawingController.initialize();
    _initialized = true;
  }

  void drawingControllerListener() {
    if ((drawingController.drawings.lastOrNull?.deltas.lastOrNull?.operation ==
            DrawingOperation.end) ||
        drawingController.drawings.isEmpty) {
      addControllerToCache(drawingController.copy());
    }
    // previousDrawingController = drawingController.copy();
  }

  late final List<DocumentEditingController> cache = [];

  void setDrawingController(DrawingController controller) {
    // drawingController = controller;
    notifyListeners();
  }

  void addControllerToCache(DocumentEditingController controller) {
    print('adding to cache');
    if (cache.length == 45) {
      cache.removeAt(0);
    }
    cache.add(controller);
    print('cache updated');
  }

  void removeControllerFromCache(DocumentEditingController controller) {
    cache.remove(controller);
  }

  void setDocumentValue(DocumentEditingController controller) {
    if (controller is DrawingController) {
      drawingController = controller.copy();
      drawingController.notifyListeners();
      notifyListeners();
    }
  }

  bool get canUndo => cache.isNotEmpty && cache.length > 1;

  bool get canRedo =>
      cache.isNotEmpty &&
      cache.length > 1 &&
      cache.containsWhere(
        (value) =>
            value is DrawingController &&
            value.drawingControllerEquality(drawingController),
      ) &&
      !(cache.lastIndexWhere(
            (value) =>
                value is DrawingController &&
                value.drawingControllerEquality(drawingController),
          ) ==
          (cache.length - 1));

  DocumentEditingController? get previousActiveController {
    final int cacheLength = cache.length;
    for (int i = cacheLength - 1; i >= 0; --i) {
      final DocumentEditingController temp = cache[i];
      if (temp is DrawingController &&
          temp.drawingControllerEquality(drawingController)) {
        if (i == 0) return null;
        return cache[i - 1];
      }
    }
    return null;
  }

  void undo() {
    assertInitialized();
    if (!canUndo) return;
    print('undoing');

    DocumentEditingController? cachedController = previousActiveController;
    print(cachedController);
    if (cachedController == null) return;

    cachedController = cachedController is DrawingController
        ? cachedController.copy()
        : cachedController;

    setDocumentValue(cachedController);

    // cache.removeLast();
    // print('length: ${cache.length}');
    // cache.removeRange(cache.length - 20, cache.length - 1);
    // final DrawingController tempController = cache.last as DrawingController;
    // drawingController.changeDrawings(tempController.drawings);
    // drawingController.notifyListeners();
    // notifyListeners();
    // print('length: ${cache.length}');
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

  void dispatchColorChange(Color color) {
    drawingController.changeColor(color);
  }

  @override
  void dispose() {
    super.dispose();
    drawingController.removeListener(
      drawingControllerListener,
    );
    drawingController.dispose();
  }
}
