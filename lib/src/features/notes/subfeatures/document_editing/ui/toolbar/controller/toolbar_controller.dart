import 'package:flutter/material.dart';
import 'package:nobook/src/features/features_barrel.dart';
import 'package:nobook/src/features/notes/subfeatures/document_editing/base/document_editing_base_barrel.dart';
import 'package:nobook/src/features/notes/subfeatures/document_editing/subfeatures/text_editor/text_editor_barrel.dart';
import 'package:nobook/src/utils/utils_barrel.dart';

class NoteDocumentController extends ChangeNotifier {
  DrawingController drawingController = DrawingController();
  TextEditorController textController = TextEditorController();
  NoteDocument _noteDocument;

  NoteDocument get noteDocument => List.from(_noteDocument);

  NoteDocumentController({
    required NoteDocument noteDocument,
  }) : _noteDocument = noteDocument {
    drawingController.addListener(drawingControllerListener);

    textController.addListener(textControllerListener);
  }

  late Color _color;

  Color get color => _color;

  bool _initialized = false;

  bool get initialized => _initialized;

  void initialize({
    Color? color,
    NoteDocument? noteDocument,
  }) {
    if (!drawingController.initialized) drawingController.initialize();
    drawingController.initialize();

    if (noteDocument != null) _setControllersFromNote(noteDocument);
    _setDefaultColor();
    _initialized = true;
  }

  void _setControllersFromNote(NoteDocument noteDocument) {
    //TODO: remove all controller listeners
    textController.removeListener(textControllerListener);
    drawingController.removeListener(drawingControllerListener);
    for (final DocumentEditingController controller in noteDocument) {
      if (controller is DrawingController) {
        drawingController = controller;
      }
      if (controller is TextEditorController) {
        textController = controller;
      }
    }
    drawingController.initialize();
    textController.initialize();
    notifyListeners();
    //TODO: add all controller listeners [back]
    drawingController.addListener(drawingControllerListener);
    textController.addListener(textControllerListener);
    notifyListeners();
  }

  void drawingControllerListener() {
    print(
        'last - last operation: ${drawingController.drawings.lastOrNull?.deltas.lastOrNull?.operation}');
    print(
        'last - first operation: ${drawingController.drawings.lastOrNull?.deltas.firstOrNull?.operation}');

    print(
        'first - last operation: ${drawingController.drawings.firstOrNull?.deltas.lastOrNull?.operation}');
    print(
        'first - first operation: ${drawingController.drawings.firstOrNull?.deltas.firstOrNull?.operation}');

    if (drawingController.drawingMode == DrawingMode.erase) {
      if (drawingController.drawings.lastOrNull?.deltas.lastOrNull?.operation ==
          DrawingOperation.end) {
        _drawingControllerListenerAction();
      }
    } else {
      if (drawingController.currentlyActiveDrawing == null) {
        _drawingControllerListenerAction();
      }
    }

    currentControllerListener();
  }

  void _drawingControllerListenerAction() {
    addControllerToCache(
      (drawingController.copy()
        ..initialize(
          currentActiveDrawing: drawingController.currentlyActiveDrawing,
        ))
        ..addListener(drawingControllerListener),
    );
  }

  void textControllerListener() {
    addControllerToCache(
      textController.copy()..addListener(textControllerListener),
    );
    currentControllerListener();
  }

  late final List<DocumentEditingController> cache = [];

  void setDrawingController(DrawingController controller) {
    print('set drawing controller called');
    drawingController = controller;
    notifyListeners();
  }

  void addControllerToCache(DocumentEditingController controller) {
    if (activeCacheIndex != null && activeCacheIndex != cache.lastIndex) {
      if (cache.isNotEmpty) {
        cache.removeRange(activeCacheIndex! + 1, cache.length);
      }
    }
    if (cache.length == 45) {
      cache.removeAt(0);
    }
    cache.add(controller);
    if (controller is DrawingController &&
        !drawingController.equalsOther(controller)) {
      setDrawingController(controller);
    }
    activeCacheIndex = cache.lastIndex;
  }

  void removeControllerFromCache(DocumentEditingController controller) {
    cache.remove(controller);
  }

  void changeCurrentActiveController(DocumentEditingController controller) {
    if (cache.contains(controller)) {
      activeCacheIndex = cache.indexOf(controller);
    } else {
      cache.add(controller);
      activeCacheIndex = cache.lastIndex;
    }
    if (controller is TextEditorController) {
      textController = controller;
      notifyListeners();
    }
    if (controller is DrawingController) {
      drawingController = controller;
      notifyListeners();
    }
  }

  @override
  void notifyListeners() {
    _noteDocument = [
      //Todo: add other controllers
      textController,
      drawingController,
    ];
    currentControllerListener();
    super.notifyListeners();
  }

  void currentControllerListener() {
    setCanUndoOrRedo();
  }

  void setCanUndoOrRedo() {
    final bool tempCanUndo = cache.isNotEmpty && activeCacheIndex != -1;

    final bool tempCanRedo = cache.isNotEmpty &&
        cache.isNotEmpty &&
        activeCacheIndex != (cache.length - 1);

    final bool shouldChange = tempCanUndo ^ canUndo || tempCanRedo ^ canRedo;

    if (shouldChange) {
      canUndo = tempCanUndo;
      canRedo = tempCanRedo;
      notifyListeners();
    }
  }

  bool canUndo = false;
  bool canRedo = false;

  DocumentEditingController? get previousActiveController {
    final int cacheLength = cache.length;
    for (int i = cacheLength - 1; i >= 0; --i) {
      final DocumentEditingController temp = cache[i];
      if (temp is DrawingController && temp.equalsOther(drawingController)) {
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

    activeCacheIndex ??= cache.lastIndex;

    activeCacheIndex = activeCacheIndex! - 1;

    DocumentEditingController cachedController = activeCacheIndex != -1
        ? cache[activeCacheIndex!]
        : (DrawingController()
          ..initialize()
          ..addListener(drawingControllerListener));

    changeCurrentActiveController(cachedController);
  }

  DocumentEditingController get activeController {
    return activeCacheIndex == null ? textController : cache[activeCacheIndex!];
  }

  void redo() {
    assertInitialized();
    if (!canRedo) return;
    activeCacheIndex ??= cache.lastIndex;

    if (activeCacheIndex == cache.lastIndex) return;

    activeCacheIndex = activeCacheIndex! + 1;
    DocumentEditingController cachedController = cache[activeCacheIndex!];

    changeCurrentActiveController(cachedController);
  }

  void assertInitialized() {
    assert(initialized, 'controller must be initialized');
  }

  void clearCache() {
    if (cache.isEmpty) return;
    final DocumentEditingController currentActiveController = activeController;
    cache.clear();
    if (currentActiveController is DrawingController) {
      drawingController.removeListener(drawingControllerListener);
      cache.add(TextEditorController()..addListener(textControllerListener));
      cache.add(
        DrawingController()
          ..initialize()
          ..addListener(drawingControllerListener),
      );
    } else if (currentActiveController is TextEditorController) {
      textController.removeListener(textControllerListener);
      cache.add(
        DrawingController()
          ..initialize()
          ..addListener(drawingControllerListener),
      );
      cache.add(TextEditorController()..addListener(textControllerListener));
    }
    activeCacheIndex = cache.lastIndex;
  }

  void clear() {
    _noteDocument.clear();
    clearDrawings();
    clearText();
    //TODO: clear other controllers
    clearCache();
    notifyListeners();
    initialize();
  }

  void clearText() {
    textController.clear();
  }

  void clearDrawings() {
    drawingController.removeListener(drawingControllerListener);
    drawingController = drawingController.copy(drawings: []);
    drawingController.addListener(drawingControllerListener);
  }

  void dispatchColorChange(Color color) {
    drawingController.changeColor(color);
    textController.changeColor(color);
    _color = color;
  }

  void _setDefaultColor() {
    // default color is text controller's color since it'll be the first active
    // controller
    final Color color = textController.metadata?.color ??
        TextEditorController.defaultMetadata.color;
    _color = color;
  }

  bool showingRoughPaper = false;

  void toggleRoughPaper([bool? value]) {
    showingRoughPaper = value ?? !showingRoughPaper;
    notifyListeners();
  }

  @override
  void dispose() {
    drawingController.removeListener(drawingControllerListener);
    drawingController.dispose();
    textController.removeListener(textControllerListener);
    textController.dispose();
    super.dispose();
  }
}
