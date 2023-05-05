import 'dart:convert';
import 'dart:math' as math;
import 'dart:math';
import 'dart:ui';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nobook/src/features/notes/subfeatures/document_editing/subfeatures/drawing/drawing_barrel.dart';
import 'package:nobook/src/utils/utils_barrel.dart';

extension DrawingsExentension on Drawings {
  bool containsDrawingAt(PointDouble pointDelta) {
    final List<Drawing> drawings = List.from(this);

    for (final Drawing drawing in drawings) {
      if (drawing.deltas.containsWhere((value) => value.point == pointDelta)) {
        return true;
      }
    }
    return false;
  }

  Size computeCanvasSizeByOffets() {
    if (isEmpty) return Size.zero;
    final List<PointDouble> offsets = fold<List<PointDouble>>(
      [],
      (previousValue, element) => previousValue
        ..addAll(
          element.deltas.fold<List<PointDouble>>(
            [],
            (previousValue, element) => previousValue..add(element.point),
          ),
        ),
    );

    final double maxX = offsets.map((e) => e.x).reduce(max);
    final double maxY = offsets.map((e) => e.y).reduce(max);
    final double minX = offsets.map((e) => e.x).reduce(min);
    final double minY = offsets.map((e) => e.y).reduce(min);

    final double width = maxX - minX;
    final double height = maxY - minY;

    return Size(width, height);
  }

  Drawings copyWithRelativeSize() => map((e) {
        final List<DrawingDelta> deltas = e.deltas.map((e) {
          return DrawingDelta(
            point: PointDouble(e.point.x.w, e.point.y.h),
            metadata: e.metadata,
            operation: e.operation,
          );
        }).toList();
        return e.copyWith(deltas: deltas);
      }).toList();
}

extension NoteDocumentExtension on NoteDocument {
  String toJson() {
    return jsonEncode(toSerializerList());
  }

  List<Map<String, dynamic>> toSerializerList() {
    return map<Map<String, dynamic>>(
      (e) => e.toDataMap(),
    ).toList();
  }
}

extension PointDoubleExtension on PointDouble {
  Offset get toOffset => Offset(x, y);

  PointDouble center(PointDouble p2) {
    final double midX = ((x + p2.x) / 2);
    final double midY = ((y + p2.y) / 2);

    return PointDouble(midX, midY);
  }

  Map<String, dynamic> toMap() {
    return {'x': x, 'y': y};
  }
}

extension SizeExtension on Size {
  double get magnitude {
    return math.sqrt((height * height) + (width * width));
  }
}

extension OffsetExtension on Offset {
  Offset copyWith({
    double? dx,
    double? dy,
  }) {
    return Offset(
      dx ?? this.dx,
      dy ?? this.dy,
    );
  }

  PointDouble get point => PointDouble(dx, dy);
}

extension ColorExtension on Color {
  String get toSerializerString => value.toString().removeAll('#');
}
