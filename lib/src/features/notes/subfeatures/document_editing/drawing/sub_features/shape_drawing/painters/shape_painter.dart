import 'dart:ui';

import 'package:nobook/src/features/features_barrel.dart';

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
  ) {}
}
