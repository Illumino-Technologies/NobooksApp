import 'package:flutter/material.dart';
import 'package:nobook/src/features/features_barrel.dart';
import 'package:nobook/src/features/notes/subfeatures/document_editing/base/document_editing_base_barrel.dart';
import 'package:nobook/src/utils/utils_barrel.dart';

class ToolbarController extends ChangeNotifier {
  final NoteSyncLogicInterface _noteSynchronizer;
  DrawingController drawingController = DrawingController();
  Note note;

  ToolbarController({
    required this.note,
    NoteSyncLogic? noteSynchronizer,
  }) : _noteSynchronizer =
            noteSynchronizer ?? NoteSyncLogic(currentNote: note) {
    drawingController.addListener(drawingControllerListener);
  }

  late Color _color;

  Color get color => _color;

  bool _initialized = false;

  bool get initialized => _initialized;

  Future<void> initialize({Color? color}) async {
    final Note? note = await Future.microtask(
      _noteSynchronizer.fetchStoredNote,
    );

    drawingController.initialize();

    if (note != null) _setControllersFromNote(note);
    _setDefaultColor();
    _initialized = true;
  }

  void _setControllersFromNote(Note note) {
    //TODO: remove all controller listeners
    drawingController.removeListener(drawingControllerListener);
    for (final DocumentEditingController controller in note.noteBody) {
      if (controller is DrawingController) {
        drawingController = controller;
        print('drawings: ${controller.drawings}');
        notifyListeners();
      }
    }

    //TODO: add all controller listeners [back]
    drawingController.addListener(drawingControllerListener);
    notifyListeners();
  }

  void drawingControllerListener() {
    if ((drawingController.drawings.lastOrNull?.deltas.lastOrNull?.operation ==
            DrawingOperation.end) ||
        drawingController.drawings.isEmpty) {
      addControllerToCache(
        drawingController.copy()..addListener(drawingControllerListener),
      );
    }
    currentControllerListener();
  }

  late final List<DocumentEditingController> cache = [];

  void setDrawingController(DrawingController controller) {
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

  void setDocumentValue(DocumentEditingController controller) {
    if (controller is DrawingController) {
      drawingController = controller;
      notifyListeners();
    }
  }

  @override
  void notifyListeners() {
    note = note.copyWith(
      noteBody: [
        //TODO: add other controllers
        drawingController,
      ],
    );
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

  void clear() {
    note = note.copyWith(noteBody: []);
    _noteSynchronizer.clearNotes();
    clearDrawings();
    notifyListeners();
  }

  void clearDrawings() {
    drawingController.removeListener(drawingControllerListener);
    drawingController = drawingController.copy(drawings: []);
    drawingController.addListener(drawingControllerListener);
  }

  void dispatchColorChange(Color color) {
    //TODO: dispatch across other controllers
    drawingController.changeColor(color);
  }

  void _setDefaultColor() {
    //TODO: compare with other controllers and set color
    final Color color = drawingController.color;
    _color = color;
  }

  @override
  void dispose() {
    super.dispose();
    syncNote();
    _noteSynchronizer.dispose();
    drawingController.removeListener(
      drawingControllerListener,
    );
    drawingController.dispose();
  }

  bool _syncingNote = false;

  Future<void> syncNote() async {
    if (_syncingNote) return;
    _syncingNote = true;
    print('syncing note');
    await _noteSynchronizer.syncNote(note);
    _syncingNote = false;
  }
}
