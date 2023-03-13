import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:nobook/src/features/notes/subfeatures/document_editing/drawing/utils/drawing_utils_barrel.dart';

part 'actionable/drawing_operation.dart';

part 'drawing_metadata.dart';

class DrawingDelta with EquatableMixin {
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
    return '''DrawingDelta{
      point: $point,
      operation: $operation,
      metadata: $metadata
    }''';
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

  @override
  List<Object?> get props => [point, operation, metadata];
}
