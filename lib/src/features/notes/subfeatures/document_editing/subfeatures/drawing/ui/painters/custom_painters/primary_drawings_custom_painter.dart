import 'package:flutter/cupertino.dart';
import 'package:nobook/src/features/notes/subfeatures/document_editing/subfeatures/drawing/drawing_barrel.dart';

/// This class is holds the methods used to paint the currently active [Drawing] on a canvas.
class PrimaryDrawingsPainter extends CustomPainter {
  final Drawing drawing;
  final DrawingPainter<ShapeDrawing> shapeDrawingPainter;
  final DrawingPainter<SketchDrawing> sketchDrawingPainter;
  final DrawingPainter<LineDrawing> lineDrawingPainter;

  const PrimaryDrawingsPainter({
    required this.shapeDrawingPainter,
    required this.sketchDrawingPainter,
    required this.lineDrawingPainter,
    required this.drawing,
  });

  @override
  void paint(Canvas canvas, Size size) {
    switch (drawing.runtimeType) {
      case ShapeDrawing:
        shapeDrawingPainter.paintDrawing(
          canvas,
          size,
          drawing as ShapeDrawing,
        );
        break;
      case LineDrawing:
        lineDrawingPainter.paintDrawing(
          canvas,
          size,
          drawing as LineDrawing,
        );
      case SketchDrawing:
        sketchDrawingPainter.paintDrawing(
          canvas,
          size,
          drawing as SketchDrawing,
        );
        break;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate is PrimaryDrawingsPainter &&
        oldDelegate.drawing != drawing;
  }
}
