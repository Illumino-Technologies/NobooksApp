part of 'all_models.dart';

enum DrawingOperation {
  start,
  end,
  neutral;
}

class DrawingDelta {
  final PointDouble point;
  final DrawingOperation operation;
  final DrawingMetadata? metadata;

  const DrawingDelta({
    required this.point,
    this.operation = DrawingOperation.neutral,
    this.metadata,
  });

  @override
  String toString() {
    return 'DrawingDelta{\npoint: $point, operation: \n$operation, metadata: \n$metadata\n}';
  }

  DrawingDelta copyWith({
    PointDouble? point,
    DrawingOperation? operation,
    DrawingMetadata? metadata,
  }) {
    return DrawingDelta(
      point: point ?? this.point,
      operation: operation ?? this.operation,
      metadata: metadata ?? this.metadata,
    );
  }
}

class DrawingMetadata {
  final Color? color;
  final double? strokeWidth;

  const DrawingMetadata({
    this.color,
    this.strokeWidth,
  });

  @override
  String toString() {
    return 'DrawingDeltaMetadata{\ncolor: $color, \nstrokeWidth: $strokeWidth\n}';
  }

  DrawingMetadata copyWith({
    Color? color,
    double? strokeWidth,
  }) {
    return DrawingMetadata(
      color: color ?? this.color,
      strokeWidth: strokeWidth ?? this.strokeWidth,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DrawingMetadata &&
          runtimeType == other.runtimeType &&
          color == other.color &&
          strokeWidth == other.strokeWidth;

  @override
  int get hashCode => color.hashCode ^ strokeWidth.hashCode;
}
