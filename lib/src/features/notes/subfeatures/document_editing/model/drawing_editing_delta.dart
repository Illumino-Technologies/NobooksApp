import 'package:flutter/material.dart';
import 'package:nobook/src/features/notes/subfeatures/document_editing/model/document_editor_model.dart';

enum DrawingOperation {
  start,
  end,
  neutral;
}

class DrawingDelta {
  final PointDouble point;
  final DrawingOperation operation;
  final DrawingDeltaMetadata? metadata;

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
    DrawingDeltaMetadata? metadata,
  }) {
    return DrawingDelta(
      point: point ?? this.point,
      operation: operation ?? this.operation,
      metadata: metadata ?? this.metadata,
    );
  }
}

class DrawingDeltaMetadata {
  final Color? color;
  final double? strokeWidth;

  const DrawingDeltaMetadata({
    this.color,
    this.strokeWidth,
  });

  @override
  String toString() {
    return 'DrawingDeltaMetadata{\ncolor: $color, \nstrokeWidth: $strokeWidth\n}';
  }
}

