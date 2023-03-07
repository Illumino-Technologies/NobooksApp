import 'package:nobook/src/features/notes/subfeatures/document_editing/drawing/model/drawing_model_barrel.dart';

class ShapeDrawing extends Drawing {
  ShapeDrawing({
    required super.deltas,
    super.metadata,
  });

  @override
  ShapeDrawing copyWith({
    List<DrawingDelta>? deltas,
    DrawingMetadata? metadata,
  }) {
    return ShapeDrawing(
      deltas: deltas ?? this.deltas,
      metadata: metadata ?? this.metadata,
    );
  }
}
