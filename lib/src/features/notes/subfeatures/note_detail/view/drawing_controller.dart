import 'package:flutter/material.dart';
import 'package:nobook/src/features/notes/subfeatures/document_editing/drawing/drawing_barrel.dart';
import 'package:nobook/src/global/ui/ui_barrel.dart';
import 'package:nobook/src/utils/utils_barrel.dart';

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

  void initialize({
    Eraser? eraser,
    DrawingMode? drawingMode,
    DrawingMetadata? lineMetadata,
    DrawingMetadata? shapeMetadata,
    DrawingMetadata? sketchMetadata,
  }) {
    //TODO: initializeValues from cache/storage

    _drawings = _drawings;

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

  void toggleErase() {
    //TODO: use action stack
    if (drawingMode == DrawingMode.erase) {
      changeDrawingMode(DrawingMode.sketch);
    } else {
      changeDrawingMode(DrawingMode.erase);
    }
  }

  void changeColor(Color color) {
    switch (drawingMode) {
      case DrawingMode.erase:
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
      changeDrawingMode(DrawingMode.sketch);
    }
    _drawings = List.from(drawings);
    notifyListeners();
  }

  void draw(DrawingDelta delta) {
    Drawings drawings = List.from(_drawings);

    switch (drawingMode) {
      case DrawingMode.erase:
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
    changeDrawingMode(DrawingMode.sketch);
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
        erasedDrawings = eraseDrawingFrom(eraser.region, drawings);
        break;
      case EraseMode.area:
        erasedDrawings = eraseAreaFrom(eraser.region, drawings);
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

  Drawings eraseAreaFrom(Region eraser, Drawings drawings) {
    drawings = List.from(drawings);

    Drawing? drawingToBeErased;

    for (final Drawing drawing in drawings) {
      if (drawing.deltas.containsWhere(
        (value) => eraser.containsPoint(value.point),
      )) {
        drawingToBeErased = drawing;
        break;
      }
    }
    if (drawingToBeErased == null) return drawings;

    final Drawing drawingTobeErasedCopy = drawingToBeErased;

    final DrawingDelta erasedDelta = drawingToBeErased.deltas
        .firstWhere((element) => eraser.containsPoint(element.point));

    final int erasedDeltaIndex = drawingToBeErased.deltas.indexOf(erasedDelta);

    if (drawingToBeErased.deltas.isFirst(erasedDelta)) {
      if (drawingToBeErased.deltas.length == 1) {
        drawingToBeErased.deltas.clear();
      } else {
        drawingToBeErased.deltas[1] = drawingToBeErased.deltas[1].copyWith(
          operation: DrawingOperation.start,
        );
        drawingToBeErased.deltas.removeAt(0);
      }
      drawings.replace(drawingTobeErasedCopy, [drawingToBeErased]);
    } else if (drawingToBeErased.deltas.isLast(erasedDelta)) {
      final int length = drawingToBeErased.deltas.length;
      drawingToBeErased.deltas[length - 2] = drawingToBeErased
          .deltas[length - 2]
          .copyWith(operation: DrawingOperation.end);
      drawingToBeErased.deltas.removeLast();
      drawings.replace(drawingTobeErasedCopy, [drawingToBeErased]);
    } else {
      drawingToBeErased.deltas[erasedDeltaIndex - 1] = drawingToBeErased
          .deltas[erasedDeltaIndex - 1]
          .copyWith(operation: DrawingOperation.end);

      drawingToBeErased.deltas[erasedDeltaIndex + 1] = drawingToBeErased
          .deltas[erasedDeltaIndex + 1]
          .copyWith(operation: DrawingOperation.start);

      drawingToBeErased.deltas.removeAt(erasedDeltaIndex);

      final List<Drawing> modifiedDrawings = splitDrawingDeltaToDrawings(
        drawingToBeErased.deltas,
        drawingToBeErased.metadata,
      );
      drawings.replace(drawingTobeErasedCopy, [...modifiedDrawings]);
    }

    return drawings;
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

  List<Drawing> splitDrawingDeltaToDrawings<T extends Drawing>(
    List<DrawingDelta> deltas, [
    DrawingMetadata? defaultMetadata,
  ]) {
    deltas = List.from(deltas);
    final List<Drawing> drawings = [];

    bool currentlyAddingDrawing = false;
    for (final DrawingDelta delta in deltas) {
      if (delta.operation == DrawingOperation.start) {
        currentlyAddingDrawing = true;
        drawings.add(
          Drawing(
            deltas: [delta],
            metadata: defaultMetadata ?? delta.metadata,
          ),
        );
        continue;
      }
      if (currentlyAddingDrawing) {
        drawings.last.deltas.add(delta);
      }
      if (delta.operation == DrawingOperation.end) {
        currentlyAddingDrawing = false;
      }
    }
    return drawings;
  }

  Drawings eraseDrawingAtSpecific(PointDouble point, Drawings drawings) {
    drawings = List.from(drawings);

    drawings.removeWhere(
      (element) => element.deltas.containsWhere(
        (value) => value.point == point,
      ),
    );
    return drawings;
  }

  Drawings eraseDrawingFrom(Region region, Drawings drawings) {
    drawings = List.from(drawings);

    drawings.removeWhere(
      (element) => element.deltas.containsWhere(
        (value) => region.containsPoint(value.point),
      ),
    );

    return drawings;
  }
}
