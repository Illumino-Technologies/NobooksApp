import 'dart:ui';

import 'package:nobook/src/features/notes/subfeatures/document_editing/subfeatures/drawing/drawing_barrel.dart';
import 'package:nobook/src/global/ui/ui_barrel.dart';

final class LineDrawingPainter extends DrawingPainter<LineDrawing> {
  const LineDrawingPainter();

  @override
  void paintDrawing(Canvas canvas, Size size, LineDrawing drawing) {
    if (drawing.deltas.length == 1) return;

    final Paint paint = Paint()
      ..color = drawing.metadata?.color ?? AppColors.black
      ..strokeWidth = drawing.metadata?.strokeWidth ?? 4
      ..style = PaintingStyle.stroke;

    final Path path = Path();
    path.moveTo(0, 0);

    final DrawingDelta firstDelta = drawing.deltas.firstWhere(
      (element) => element.operation == DrawingOperation.start,
    );
    final DrawingDelta latestDelta = drawing.deltas.lastWhere(
      (element) => element.operation == DrawingOperation.neutral,
    );

    path.moveTo(firstDelta.point.x, firstDelta.point.y);
    path.lineTo(latestDelta.point.x, latestDelta.point.y);

    canvas.drawPath(path, paint);

    // for (final DrawingDelta drawingDelta in drawing.deltas) {
    //   paintDelta(
    //     delta: drawingDelta,
    //     paint: paint,
    //     path: path,
    //     canvas: canvas,
    //     size: size,
    //   );
    // }
  }

  void paintDelta({
    required DrawingDelta delta,
    required Paint paint,
    required Path path,
    required Canvas canvas,
    required Size size,
  }) {
    switch (delta.operation) {
      case DrawingOperation.start:
        paint.color = delta.metadata?.color ?? paint.color;
        paint.strokeWidth = delta.metadata?.strokeWidth ?? paint.strokeWidth;

        path.moveTo(delta.point.x, delta.point.y);
        break;
      case DrawingOperation.end:
      // path.reset();
      // path.lineTo(delta.point.x, delta.point.y);
      // break;
      case DrawingOperation.neutral:
        {
          paint.color = delta.metadata?.color ?? paint.color;
          paint.strokeWidth = delta.metadata?.strokeWidth ?? paint.strokeWidth;

          path.lineTo(delta.point.x, delta.point.y);
          break;
        }
    }
  }
}
