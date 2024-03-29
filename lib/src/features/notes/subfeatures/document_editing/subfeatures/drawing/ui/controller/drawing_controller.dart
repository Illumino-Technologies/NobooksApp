import 'package:flutter/material.dart';
import 'package:nobook/src/features/notes/subfeatures/document_editing/document_editing_barrel.dart';
import 'package:nobook/src/global/ui/ui_barrel.dart';
import 'package:nobook/src/utils/utils_barrel.dart';

class DrawingController extends DocumentEditingController {
  DrawingController();

  late Eraser eraser;
  late DrawingMode _drawingMode;

  DrawingMode get drawingMode => _drawingMode;

  @protected
  set drawingMode(DrawingMode value) {
    _drawingMode = value;
  }

  Drawings _drawings = [];

  Drawings get drawings => List.from(_drawings);

  final List<DrawingMode> _actionStack = List.from([]);

  late DrawingMetadata lineMetadata;
  late DrawingMetadata shapeMetadata;
  late DrawingMetadata sketchMetadata;
  late Shape shape;

  @protected
  Drawings get mutableDrawings => _drawings;

  Drawing? _currentlyActiveDrawing;

  Drawing? get currentlyActiveDrawing => _currentlyActiveDrawing;

  set currentlyActiveDrawing(Drawing? value) {
    _currentlyActiveDrawing = value;
    notifyListeners();
  }

  @override
  void notifyListeners() {
    super.notifyListeners();
  }

  void startDrawing() {
    if (drawingMode == DrawingMode.erase) return;
    _currentlyActiveDrawing = switch (drawingMode) {
      DrawingMode.shape => ShapeDrawing(
          shape: shape,
          deltas: [],
          metadata: shapeMetadata,
        ),
      DrawingMode.line => LineDrawing(
          deltas: [],
          metadata: lineMetadata,
        ),
      _ => SketchDrawing(
          deltas: [],
          metadata: sketchMetadata,
        ),
    };
  }

  DrawingMetadata metadataFor([DrawingMode? mode]) {
    switch (_actionStack.lastOrNull) {
      case DrawingMode.erase:
        {
          final DrawingMode? lastNonEraseMode = _actionStack.lastWhereOrNull(
            (element) => element != DrawingMode.erase,
          );
          if (lastNonEraseMode == null) return sketchMetadata;
          return metadataFor(
            lastNonEraseMode,
          );
        }
      case DrawingMode.sketch:
        return sketchMetadata;
      case DrawingMode.shape:
        return shapeMetadata;
      case DrawingMode.line:
        return lineMetadata;
      case null:
        return metadataFor(DrawingMode.erase);
    }
  }

  bool _initialized = false;

  bool get initialized => _initialized;

  @override
  void initialize({
    Color? color,
    Eraser? eraser,
    DrawingMode? drawingMode,
    DrawingMetadata? lineMetadata,
    DrawingMetadata? shapeMetadata,
    DrawingMetadata? sketchMetadata,
    Drawing? currentActiveDrawing,
    Shape? shape,
    Drawings? drawings,
  }) {
    // TODO: initializeValues from cache/storage

    if (_initialized) return;
    _drawings = drawings ?? _drawings;

    this.shape = shape ?? Shape.rectangle;

    _currentlyActiveDrawing = currentActiveDrawing;

    this.lineMetadata = lineMetadata ??
        DrawingMetadata(
          color: color ?? AppColors.black,
          strokeWidth: 4,
        );
    this.shapeMetadata = shapeMetadata ??
        DrawingMetadata(
          color: color ?? AppColors.black,
          strokeWidth: 4,
        );
    this.sketchMetadata = sketchMetadata ??
        DrawingMetadata(
          color: color ?? AppColors.black,
          strokeWidth: 4,
        );

    this.drawingMode = drawingMode ?? DrawingMode.sketch;

    _actionStack.add(this.drawingMode);

    this.eraser = eraser ??
        const Eraser(
          region: Region(
            centre: PointDouble(0, 0),
            radius: 5,
          ),
          mode: EraseMode.drawing,
        );
    _initialized = true;
  }

  void changeDrawingModeToPrevious([DrawingMode? currentAction]) {
    currentAction ??= _actionStack.lastOrNull;
    if (currentAction == null) return changeDrawingMode(DrawingMode.sketch);

    _actionStack.remove(currentAction);

    if (_actionStack.isEmpty) return changeDrawingMode(DrawingMode.sketch);

    changeDrawingMode(_actionStack.last);
  }

  void changeDrawingMode(
    DrawingMode mode, [
    bool revertToPreviousAction = false,
  ]) {
    if (_actionStack.contains(mode)) _actionStack.remove(mode);
    _actionStack.add(mode);

    drawingMode = _actionStack.lastOrNull ?? mode;
    notifyListeners();
    notifyOfSignificantUpdate();
  }

  void changeShape(Shape newShape) {
    if (shape == newShape) return;
    shape = newShape;
    notifyListeners();
    notifyOfSignificantUpdate();
  }

  void toggleErase() {
    //TODO: use action stack
    if (drawingMode == DrawingMode.erase) {
      changeDrawingModeToPrevious(DrawingMode.erase);
    } else {
      changeDrawingMode(DrawingMode.erase);
    }
  }

  void changeColor(Color color) {
    sketchMetadata = sketchMetadata.copyWith(color: color);
    shapeMetadata = shapeMetadata.copyWith(color: color);
    lineMetadata = lineMetadata.copyWith(color: color);

    // notifyListeners();
    notifyOfSignificantUpdate();
  }

  void changeStrokeWidth(double strokeWidth) {
    sketchMetadata = sketchMetadata.copyWith(strokeWidth: strokeWidth);
    shapeMetadata = shapeMetadata.copyWith(strokeWidth: strokeWidth);
    lineMetadata = lineMetadata.copyWith(strokeWidth: strokeWidth);
    // notifyListeners();
    notifyOfSignificantUpdate();
  }

  void changeEraseMode(EraseMode mode) {
    if (eraser.mode == mode) return;
    eraser = eraser.copyWith(mode: mode);
    notifyListeners();
    notifyOfSignificantUpdate();
  }

  void changeDrawings(Drawings drawings) {
    if (drawings.isEmpty) {
      changeDrawingMode(_actionStack.lastOrNull ?? DrawingMode.sketch);
    }
    _drawings = List.from(drawings);
    notifyListeners();
  }

  void draw(DrawingDelta delta) {
    Drawings drawings = List.from(_drawings);
    if (delta.operation == DrawingOperation.start) {
      startDrawing();
    }
    Drawing? drawing = currentlyActiveDrawing;

    switch (drawingMode) {
      case DrawingMode.erase:
        {
          eraser = eraser.copyWith(
            region: eraser.region.copyWith(centre: delta.point),
          );
          drawings = _erase(eraser, drawings);
          if (drawings.length != _drawings.length) {
            changeDrawings(drawings);
          }
          return;
        }
      case DrawingMode.sketch:
        {
          drawing = _sketch(delta, drawing!);
          break;
        }
      case DrawingMode.shape:
        {
          if (delta.operation == DrawingOperation.end) {
            drawing = drawing!.copyWith(
              deltas: List.from(drawing.deltas)
                ..replaceRange(
                  drawing.deltas.lastIndex,
                  drawing.deltas.lastIndex,
                  [
                    drawing.deltas.last.copyWith(
                      operation: DrawingOperation.end,
                    )
                  ],
                ),
            );
            break;
          }
          drawing = _drawShape(delta, drawing!);
        }
        break;
      case DrawingMode.line:
        drawing = _drawLine(delta, drawing!);
        break;
    }

    // adds drawing if it's the last operation in the drawing, else updates the
    // current drawing
    if (delta.operation == DrawingOperation.end) {
      _currentlyActiveDrawing = null;
      drawings.add(drawing);
      changeDrawings(drawings);
    } else {
      currentlyActiveDrawing = drawing;
    }
  }

  void notifyOfSignificantUpdate() {
    // significantUpdateNotifier.value = this;
  }

  void clearDrawings() {
    if (_actionStack.lastOrNull == DrawingMode.erase) _actionStack.removeLast();
    //TODO: use action stack
    changeDrawingMode(_actionStack.lastOrNull ?? DrawingMode.sketch);
    //TODO: confirm or modify
    changeDrawings([]);
    notifyOfSignificantUpdate();
    notifyListeners();
  }

  Drawing _sketch(DrawingDelta delta, Drawing drawing) {
    drawing = drawing.copyWith(
      deltas: List.from(drawing.deltas)..add(delta),
    );
    return drawing;
  }

  Drawings _erase(Eraser eraser, Drawings drawings) {
    Drawings erasedDrawings;
    switch (eraser.mode) {
      case EraseMode.drawing:
        erasedDrawings = eraser.eraseDrawingFrom(drawings);
        break;
      case EraseMode.area:
        erasedDrawings = eraser.eraseAreaFrom(drawings);
        break;
    }
    if (erasedDrawings.every((element) => element.deltas.isEmpty)) {
      erasedDrawings.clear();
    }

    return erasedDrawings;
  }

  Drawing _drawLine(DrawingDelta delta, Drawing drawing) {
    drawing = drawing.copyWith(
      deltas: List.from(drawing.deltas)..add(delta),
      metadata: drawing.metadata,
    );
    return drawing;
  }

  Drawing _drawShape(DrawingDelta delta, Drawing drawing) {
    final Drawing drawnDrawings = drawing.copyWith(
      deltas: List.from(drawing.deltas)..add(delta),
    );
    return drawnDrawings;
  }

  Drawings removeLastDrawingFrom(Drawings drawings) {
    drawings = List.from(drawings);
    drawings.removeLast();

    return drawings;
  }

  Drawings addDeltaToDrawings<T extends Drawing>(
    DrawingDelta delta,
    Drawings drawings, {
    DrawingMetadata? newMetadata,
  }) {
    drawings = List.from(drawings);

    delta = delta.copyWith(
      metadata: newMetadata,
    );

    switch (delta.operation) {
      case DrawingOperation.start:
        drawings.add(
          Drawing.drawingType<T>(
            deltas: [delta],
            metadata: delta.metadata,
            shape: shape,
          ),
        );
        break;
      case DrawingOperation.end:
        if (drawings.isEmpty) return drawings;
        drawings.last.deltas.add(delta);
        break;
      case DrawingOperation.neutral:
        if (drawings.isEmpty) return drawings;
        drawings.last.deltas.add(delta);
        break;
    }
    return drawings;
  }

  bool equalsOther(
    DrawingController controller,
  ) {
    return controller.lineMetadata == lineMetadata &&
        controller.shapeMetadata == shapeMetadata &&
        controller.drawingMode == drawingMode &&
        controller.eraser == eraser &&
        controller.shape == shape &&
        controller.currentlyActiveDrawing == currentlyActiveDrawing &&
        UtilFunctions.listEqual(controller._actionStack, _actionStack) &&
        UtilFunctions.listEqual(controller._drawings, _drawings) &&
        controller.sketchMetadata == sketchMetadata;
  }

  Color get color {
    //TODO: modify if should modify
    return sketchMetadata.color ??
        shapeMetadata.color ??
        lineMetadata.color ??
        AppColors.black;
  }

  DrawingController copy({
    Color? color,
    Shape? shape,
    DrawingMode? drawingMode,
    Eraser? eraser,
    DrawingMetadata? lineMetadata,
    DrawingMetadata? shapeMetadata,
    DrawingMetadata? sketchMetadata,
    List<DrawingMode>? actionStack,
    List<Drawing>? drawings,
  }) {
    final DrawingController drawingController = DrawingController();

    drawingController._actionStack.clear();
    drawingController._actionStack.addAll(actionStack ?? _actionStack);
    drawingController.changeDrawings([]);
    drawingController.changeDrawings(drawings ?? this.drawings);

    return drawingController
      ..initialize(
        color: color ?? this.sketchMetadata.color,
        shape: shape ?? this.shape,
        drawingMode: drawingMode ?? this.drawingMode,
        eraser: eraser ?? this.eraser,
        lineMetadata: lineMetadata ?? this.lineMetadata,
        shapeMetadata: shapeMetadata ?? this.shapeMetadata,
        sketchMetadata: sketchMetadata ?? this.sketchMetadata,
      );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'eraser': eraser.toMap(),
      'drawingMode': drawingMode.index,
      'drawings': drawings.map<Map<String, dynamic>>((Drawing drawing) {
        return drawing.toMap();
      }).toList(),
      'lineMetadata': lineMetadata.toMap(),
      'shapeMetadata': shapeMetadata.toMap(),
      'sketchMetadata': sketchMetadata.toMap(),
      'shape': shape.index,
    };
  }

  factory DrawingController.fromMap(Map<String, dynamic> map) {
    final Color? color = int.tryParse(map['color'].toString()) == null
        ? null
        : Color(int.parse(map['color'].toString()));

    final DrawingController controller = DrawingController()
      ..initialize(
        eraser: Eraser.fromMap((map['eraser'] as Map).cast()),
        drawingMode: DrawingMode.values[map['drawingMode'] as int],
        currentActiveDrawing: map['currentActiveDrawing'] == null
            ? null
            : Drawing.fromMap((map['currentActiveDrawing'] as Map).cast()),
        drawings: (map['drawings'] as List)
            .cast<Map>()
            .map((data) => Drawing.fromMap(data.cast()))
            .toList(),
        lineMetadata:
            DrawingMetadata.fromMap((map['lineMetadata'] as Map).cast()),
        shapeMetadata:
            DrawingMetadata.fromMap((map['shapeMetadata'] as Map).cast()),
        sketchMetadata:
            DrawingMetadata.fromMap((map['sketchMetadata'] as Map).cast()),
        shape: Shape.values[map['shape'] as int],
      );
    if (color != null) {
      controller.changeColor(color);
    }
    return controller;
  }
}
