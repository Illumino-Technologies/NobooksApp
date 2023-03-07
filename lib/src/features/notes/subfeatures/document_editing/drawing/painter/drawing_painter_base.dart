import 'package:flutter/material.dart';
import 'package:nobook/src/features/notes/subfeatures/document_editing/drawing/drawing_barrel.dart';

abstract class DrawingPainter<T extends Drawing> {
  const DrawingPainter();

  void paintDrawing(Canvas canvas, Size size, T drawing);
}
