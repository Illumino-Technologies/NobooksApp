part of 'drawing_delta.dart';

class DrawingMetadata {
  final Color? color;
  final double? strokeWidth;

  const DrawingMetadata({
    this.color,
    this.strokeWidth,
  });

  @override
  String toString() {
    return '''DrawingDeltaMetadata{
        color: $color,
        strokeWidth: $strokeWidth
      }''';
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
