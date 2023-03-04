import 'package:flutter/material.dart';
import 'package:nobook/src/features/notes/subfeatures/document_editing/model/document_editor_model.dart';

part 'drawing_editing_delta.dart';

typedef Drawings = List<Drawing>;

enum DrawingMode {
  erase,
  sketch,
  shape,
  line;
}

enum EraseMode {
  drawing,
  area;
}

class Eraser {
  final Region region;
  final EraseMode mode;

  const Eraser({
    required this.region,
    required this.mode,
  });

  Eraser copyWith({
    Region? region,
    EraseMode? mode,
  }) {
    return Eraser(
      region: region ?? this.region,
      mode: mode ?? this.mode,
    );
  }
}

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
}

class Region {
  final PointDouble centre;
  final double radius;

  const Region({
    required this.centre,
    required this.radius,
  });

  double get minX => centre.x - radius;

  double get maxX => centre.x + radius;

  double get minY => centre.y - radius;

  double get maxY => centre.y + radius;

  bool containsPoint(PointDouble point) {
    final double x = point.x;
    final double y = point.y;

    final bool isPointInHorizontalRegion = x >= minX && x <= maxX;
    final bool isPointInVerticalRegion = y >= minY && y <= maxY;

    return isPointInHorizontalRegion && isPointInVerticalRegion;
  }

  Region copyWith({
    PointDouble? centre,
    double? radius,
  }) {
    return Region(
      centre: centre ?? this.centre,
      radius: radius ?? this.radius,
    );
  }
}
