import 'dart:ui';

import 'package:nobook/src/features/features_barrel.dart';
import 'package:nobook/src/global/ui/ui_barrel.dart';

enum Shape {
  rectangle,
  circle,
  triangle,
  star,
}

class ShapePainter extends DrawingPainter<ShapeDrawing> {
  const ShapePainter();

  @override
  void paintDrawing(
    Canvas canvas,
    Size size,
    ShapeDrawing drawing,
  ) {
    final Paint paint = Paint()
      ..color = drawing.metadata?.color ?? AppColors.black
      ..strokeWidth = drawing.metadata?.strokeWidth ?? 4
      ..style = PaintingStyle.stroke;

    if (drawing.deltas.length == 1) return;

    // drawRectangle(canvas: canvas, size: size, drawing: drawing, paint: paint);
    drawCircle(canvas: canvas, size: size, drawing: drawing, paint: paint);
  }

  void drawCircle({
    required Canvas canvas,
    required Size size,
    required Drawing drawing,
    required Paint paint,
  }) {
    final DrawingDelta firstDelta = drawing.deltas.firstWhere(
      (element) => element.operation == DrawingOperation.start,
    );
    final DrawingDelta secondDelta = drawing.deltas.lastWhere(
      (element) =>
          element.operation == DrawingOperation.neutral ||
          element.operation == DrawingOperation.end,
    );

    final Rect rect = Rect.fromPoints(
      firstDelta.point.toOffset,
      secondDelta.point.toOffset,
    );

    final double radius = rect.size.magnitude / 2;
    canvas.drawCircle(rect.center, radius, paint);
  }

  void drawRectangle({
    required Canvas canvas,
    required Size size,
    required Drawing drawing,
    required Paint paint,
  }) {
    final DrawingDelta firstDelta = drawing.deltas.firstWhere(
      (element) => element.operation == DrawingOperation.start,
    );
    final DrawingDelta secondDelta = drawing.deltas.lastWhere(
      (element) =>
          element.operation == DrawingOperation.neutral ||
          element.operation == DrawingOperation.end,
    );

    final Path path = Path();

    final Rect rect = Rect.fromPoints(
      firstDelta.point.toOffset,
      secondDelta.point.toOffset,
    );
    path.addOval(rect);

    canvas.drawPath(path, paint);
  }
}
