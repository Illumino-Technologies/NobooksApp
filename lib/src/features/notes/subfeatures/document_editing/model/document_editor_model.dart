import 'dart:math';

import 'package:flutter/material.dart';
import 'package:nobook/src/features/features_barrel.dart';
import 'package:nobook/src/features/notes/subfeatures/document_editing/model/drawing_editing_delta.dart';
import 'package:nobook/src/global/ui/ui_barrel.dart';

typedef PointDouble = Point<double>;

class DrawingPainter extends CustomPainter {
  final List<Drawing> drawings;

  const DrawingPainter({
    required this.drawings,
  });

  @override
  void paint(Canvas canvas, Size size) {
    for (final Drawing drawing in drawings) {
      paintDrawing(drawing, canvas, size);
    }
  }

  void paintDrawing(Drawing drawing, Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = AppColors.black
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;

    final Path path = Path();
    path.moveTo(0, 0);
    paint.color = drawing.metadata?.color ?? AppColors.black;
    paint.strokeWidth = drawing.metadata?.strokeWidth ?? paint.strokeWidth;

    for (final DrawingDelta drawingDelta in drawing.deltas) {
      paintDelta(
        drawing: drawing,
        drawingDelta: drawingDelta,
        paint: paint,
        path: path,
        canvas: canvas,
        size: size,
      );
    }
    canvas.drawPath(path, paint);
  }

  void paintDelta({
    required Drawing drawing,
    required DrawingDelta drawingDelta,
    required Paint paint,
    required Path path,
    required Canvas canvas,
    required Size size,
  }) {
    switch (drawingDelta.operation) {
      case DrawingOperation.start:
        paint.color = drawingDelta.metadata?.color ??
            drawing.metadata?.color ??
            paint.color;
        paint.strokeWidth = drawingDelta.metadata?.strokeWidth ??
            drawing.metadata?.strokeWidth ??
            paint.strokeWidth;

        path.moveTo(drawingDelta.point.x, drawingDelta.point.y);
        break;
      case DrawingOperation.end:
        // path.reset();
        // path.lineTo(drawingDelta.point.x, drawingDelta.point.y);
        break;
      case DrawingOperation.neutral:
        paint.color = drawingDelta.metadata?.color ??
            drawing.metadata?.color ??
            paint.color;
        paint.strokeWidth = drawingDelta.metadata?.strokeWidth ??
            drawing.metadata?.strokeWidth ??
            paint.strokeWidth;
        path.lineTo(drawingDelta.point.x, drawingDelta.point.y);
        break;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate is DrawingPainter && oldDelegate.drawings != drawings;
  }
}
