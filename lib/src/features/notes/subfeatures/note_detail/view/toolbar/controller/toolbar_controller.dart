import 'package:flutter/material.dart';
import 'package:nobook/src/features/notes/subfeatures/note_detail/view/base_controller.dart';
import 'package:nobook/src/features/notes/subfeatures/note_detail/view/drawing_controller.dart';
import 'package:nobook/src/global/ui/ui_barrel.dart';
import 'package:nobook/src/utils/utils_barrel.dart';

class ToolbarController extends ChangeNotifier
    implements DocumentEditingController {
  late DrawingController drawingController = DrawingController(
    controllerChanger: controllerChanger,
  );
  late final ValueNotifier<DocumentEditingController?> controllerNotifier =
      ValueNotifier<DocumentEditingController>(drawingController);

  void controllerChanger(newController) {
    controllerNotifier.value = newController;
  }

  ToolbarController() {
    controllerNotifier.addListener(drawingControllerListener);
    // drawingController.significantUpdateNotifier.addListener(
    //   drawingControllerListener,
    // );
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
    print('drawing controller listener');

    addControllerToCache(drawingController);
    print(cache);
  }

  late final List<DocumentEditingController> cache = [];

  void setDrawingController(DrawingController controller) {
    // drawingController = controller;
    notifyListeners();
  }

  void addControllerToCache(DocumentEditingController controller) {
    // if (cache.length == 45) {
    cache.removeAt(0);
    // }
    cache.add(controller);
    print('cache updated');
  }

  void removeControllerFromCache(DocumentEditingController controller) {
    cache.remove(controller);
  }

  void setDocumentValue(DocumentEditingController controller) {
    if (controller is DrawingController) {
      // drawingController = controller;
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
    // setDocumentValue(cache[cache.length - 20]);
    // cache.removeLast();
    print('length: ${cache.length}');
    cache.removeRange(cache.length - 20, cache.length - 1);
    final DrawingController tempController = cache.last as DrawingController;
    drawingController.changeDrawings(tempController.drawings);
    drawingController.notifyListeners();
    notifyListeners();
    print('length: ${cache.length}');
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
    controllerNotifier.removeListener(drawingControllerListener);
    controllerNotifier.dispose();
    // drawingController.significantUpdateNotifier.removeListener(
    //   drawingControllerListener,
    // );
    drawingController.dispose();
  }
}
