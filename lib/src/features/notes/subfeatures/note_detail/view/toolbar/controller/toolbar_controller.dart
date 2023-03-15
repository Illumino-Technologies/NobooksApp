import 'package:flutter/material.dart';
import 'package:nobook/src/features/features_barrel.dart';
import 'package:nobook/src/features/notes/subfeatures/note_detail/view/base_controller.dart';
import 'package:nobook/src/features/notes/subfeatures/note_detail/view/drawing_controller.dart';
import 'package:nobook/src/global/ui/ui_barrel.dart';
import 'package:nobook/src/utils/utils_barrel.dart';

class ToolbarController extends ChangeNotifier
    implements DocumentEditingController {
  DrawingController drawingController = DrawingController();

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
      addControllerToCache(
        drawingController.copy()..addListener(drawingControllerListener),
      );
    }
    setCanUndoOrRedo();
  }

  late final List<DocumentEditingController> cache = [];

  void setDrawingController(DrawingController controller) {
    drawingController = controller;
    notifyListeners();
  }

  void addControllerToCache(DocumentEditingController controller) {
    if (activeCacheIndex == cache.lastIndex) {
      activeCacheIndex = activeCacheIndex! + 1;
    } else if (activeCacheIndex == null) {
      activeCacheIndex = cache.lastIndex;
    } else if (activeCacheIndex != null) {
      cache.removeRange(activeCacheIndex! + 1, cache.length);
    }
    if (cache.length == 45) {
      cache.removeAt(0);
    }
    cache.add(controller);
    activeCacheIndex = cache.lastIndex;
  }

  void removeControllerFromCache(DocumentEditingController controller) {
    cache.remove(controller);
  }

  void setDocumentValue(DocumentEditingController controller) {
    if (controller is DrawingController) {
      drawingController = controller;
      notifyListeners();
    }
  }

  @override
  void notifyListeners() {
    currentControllerListener();
    super.notifyListeners();
  }

  void currentControllerListener() {
    setCanUndoOrRedo();
  }

  void setCanUndoOrRedo() {
    print('set can undo or redo called');
    final bool tempCanUndo =
        cache.isNotEmpty && cache.length > 1 && activeCacheIndex != 0;

    final bool tempCanRedo = cache.isNotEmpty &&
        cache.length > 1 &&
        activeCacheIndex != (cache.length - 1);

    final bool shouldChange = tempCanUndo ^ canUndo || tempCanRedo ^ canRedo;

    if (shouldChange) {
      canUndo = tempCanUndo;
      canRedo = tempCanRedo;
      notifyListeners();
      print('changing \n\n can undo or redo values\n\n');
    }
  }

  bool canUndo = false;
  bool canRedo = false;

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

  int? activeCacheIndex;

  void undo() {
    assertInitialized();
    if (!canUndo) return;
    print('undoing');

    print('cache length: ${cache.length}');

    print('active cache index: $activeCacheIndex');
    activeCacheIndex ??= cache.lastIndex;

    print('active cache index: $activeCacheIndex');

    if (activeCacheIndex == 0) return;
    activeCacheIndex = activeCacheIndex! - 1;
    DocumentEditingController cachedController = cache[activeCacheIndex!];

    setDocumentValue(cachedController);
  }

  DocumentEditingController get activeController {
    //TODO: check action stack for other controllers
    return drawingController;
  }

  void redo() {
    if (!canRedo) return;
    activeCacheIndex ??= cache.lastIndex;

    if (activeCacheIndex == cache.lastIndex) return;

    activeCacheIndex = activeCacheIndex! + 1;
    DocumentEditingController cachedController = cache[activeCacheIndex!];

    setDocumentValue(cachedController);
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
