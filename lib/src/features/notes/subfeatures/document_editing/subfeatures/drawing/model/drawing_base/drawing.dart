import 'package:equatable/equatable.dart';
import 'package:nobook/src/features/notes/subfeatures/document_editing/subfeatures/drawing/drawing_barrel.dart';
import 'package:nobook/src/utils/utils_barrel.dart';

part 'actionables/drawing_mode.dart';

class Drawing with EquatableMixin {
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
    Shape? shape,
  }) {
    assert(
      () {
        if (T == ShapeDrawing) {
          return shape != null;
        }
        return true;
      }(),
      "Shape cannot be null when constructing a [ShapeDrawing] object",
    );
    switch (T) {
      case ShapeDrawing:
        return ShapeDrawing(
          shape: shape!,
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

  @override
  List<Object?> get props => [metadata, ...deltas];

  Map<String, dynamic> toMap() {
    return {
      'deltas': deltas
          .map<Map<String, dynamic>>((DrawingDelta e) => e.toMap())
          .toList(),
      'metadata': metadata?.toMap(),
    };
  }

  factory Drawing.fromMap(Map<String, dynamic> map) {
    return Drawing(
      deltas: (map['deltas'] as List)
          .cast<Map<String, dynamic>>()
          .map((e) => DrawingDelta.fromMap(e))
          .toList(),
      metadata: DrawingMetadata.fromMap(map['metadata']),
    );
  }
}
