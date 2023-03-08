import 'package:flutter/material.dart';
import 'package:nobook/src/features/notes/subfeatures/document_editing/drawing/drawing_barrel.dart';
import 'package:nobook/src/global/ui/ui_barrel.dart';

class DrawingController extends ChangeNotifier {
  late Eraser eraser;

  late DrawingMode _drawingMode;

  DrawingMode get drawingMode => _drawingMode;

  @protected
  set drawingMode(DrawingMode value) {
    _drawingMode = value;
  }

  Drawings _drawings = [];

  Drawings get drawings => List.from(_drawings);

  late DrawingMetadata lineMetadata;
  late DrawingMetadata shapeMetadata;
  late DrawingMetadata sketchMetadata;
  late Shape shape;

  void initialize({
    Eraser? eraser,
    DrawingMode? drawingMode,
    DrawingMetadata? lineMetadata,
    DrawingMetadata? shapeMetadata,
    DrawingMetadata? sketchMetadata,
    Shape? shape,
  }) {
    //TODO: initializeValues from cache/storage

    _drawings = _drawings;

    this.shape = shape ?? Shape.rectangle;

    this.lineMetadata = lineMetadata ??
        const DrawingMetadata(
          color: AppColors.black,
          strokeWidth: 4,
        );
    this.shapeMetadata = shapeMetadata ??
        const DrawingMetadata(
          color: AppColors.black,
          strokeWidth: 4,
        );
    this.sketchMetadata = sketchMetadata ??
        const DrawingMetadata(
          color: AppColors.black,
          strokeWidth: 4,
        );

    this.drawingMode = drawingMode ?? DrawingMode.sketch;
    this.eraser = eraser ??
        const Eraser(
          region: Region(
            centre: PointDouble(0, 0),
            radius: 5,
          ),
          mode: EraseMode.area,
        );
  }

  void changeDrawingMode(DrawingMode mode) {
    drawingMode = mode;
    notifyListeners();
  }

  void changeShape(Shape newShape) {
    if (shape == newShape) return;
    shape = newShape;
    notifyListeners();
  }

  void toggleErase() {
    //TODO: use action stack
    if (drawingMode == DrawingMode.drawing) {
      changeDrawingMode(DrawingMode.sketch);
    } else {
      changeDrawingMode(DrawingMode.drawing);
    }
  }

  void changeColor(Color color) {
    switch (drawingMode) {
      case DrawingMode.drawing:
        return;
      case DrawingMode.sketch:
        sketchMetadata = sketchMetadata.copyWith(color: color);
        break;
      case DrawingMode.shape:
        shapeMetadata = shapeMetadata.copyWith(color: color);
        break;
      case DrawingMode.line:
        lineMetadata = lineMetadata.copyWith(color: color);
        break;
    }
    notifyListeners();
  }

  void changeEraseMode(EraseMode mode) {
    if (eraser.mode == mode) return;
    eraser = eraser.copyWith(mode: mode);
    notifyListeners();
  }

  void changeDrawings(Drawings drawings) {
    if (drawings.isEmpty) {
      changeDrawingMode(DrawingMode.shape);
    }
    _drawings = List.from(drawings);
    notifyListeners();
  }

  void draw(DrawingDelta delta) {
    Drawings drawings = List.from(_drawings);

    switch (drawingMode) {
      case DrawingMode.drawing:
        eraser = eraser.copyWith(
          region: eraser.region.copyWith(centre: delta.point),
        );
        drawings = _erase(eraser, drawings);
        break;
      case DrawingMode.sketch:
        drawings = _sketch(delta, drawings);
        break;
      case DrawingMode.shape:
        drawings = _drawShape(delta, drawings);
        break;
      case DrawingMode.line:
        drawings = _drawLine(delta, drawings);
        break;
    }
    changeDrawings(drawings);
  }

  void clearDrawings() {
    //TODO: use action stack
    changeDrawingMode(DrawingMode.shape);
    //TODO: confirm or modify
    changeDrawings([]);
  }

  Drawings _sketch(DrawingDelta delta, Drawings drawings) {
    final Drawings sketchedDrawings = addDeltaToDrawings<SketchDrawing>(
      delta,
      drawings,
      newMetadata: sketchMetadata,
    );
    return sketchedDrawings;
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

  Drawings _drawLine(DrawingDelta delta, Drawings drawings) {
    final Drawings drawnDrawings = addDeltaToDrawings(delta, drawings);
    return drawnDrawings;
  }

  Drawings _drawShape(DrawingDelta delta, Drawings drawings) {
    final Drawings drawnDrawings = addDeltaToDrawings<ShapeDrawing>(
      delta,
      drawings,
      newMetadata: shapeMetadata,
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
}
