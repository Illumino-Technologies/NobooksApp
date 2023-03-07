import 'package:nobook/src/features/notes/subfeatures/document_editing/drawing/drawing_barrel.dart';

part 'actionables/drawing_mode.dart';

class Drawing {
  final List<DrawingDelta> deltas;
  final DrawingMetadata? metadata;

  const Drawing({
    required this.deltas,
    this.metadata,
  });

  Drawing copyWith({
    List<DrawingDelta>? deltas,
    DrawingMetadata? metadata,
  }) {
    return Drawing(
      deltas: deltas ?? this.deltas,
      metadata: metadata ?? this.metadata,
    );
  }

  static Drawing drawingType<T extends Drawing>({
    required List<DrawingDelta> deltas,
    required DrawingMetadata? metadata,
  }) {
    switch (T) {
      case ShapeDrawing:
        return ShapeDrawing(
          deltas: deltas,
          metadata: metadata,
        );
      default:
        return SketchDrawing(
          deltas: deltas,
          metadata: metadata,
        );
    }
  }
}
