part of '../drawing_canvas.dart';

class _PrimaryCanvas extends StatelessWidget {
  final DrawingController controller;
  final DrawingPainter<ShapeDrawing> shapeDrawingPainter;
  final DrawingPainter<SketchDrawing> sketchDrawingPainter;
  final DrawingPainter<LineDrawing> lineDrawingPainter;

  const _PrimaryCanvas({
    Key? key,
    required this.controller,
    required this.shapeDrawingPainter,
    required this.sketchDrawingPainter,
    required this.lineDrawingPainter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierBuilder<DrawingController>(
      listenable: controller,
      buildWhen: (previous, next) =>
          previous?.currentlyActiveDrawing == next.currentlyActiveDrawing,
      builder: (context, value) => value.currentlyActiveDrawing == null
          ? const SizedBox.shrink()
          : CustomPaint(
              painter: PrimaryDrawingsPainter(
                shapeDrawingPainter: shapeDrawingPainter,
                sketchDrawingPainter: sketchDrawingPainter,
                lineDrawingPainter: lineDrawingPainter,
                drawing: value.currentlyActiveDrawing!,
              ),
            ),
    );
  }
}
