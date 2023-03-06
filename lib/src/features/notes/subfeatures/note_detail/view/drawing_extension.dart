import 'dart:ui';

import 'package:nobook/src/features/notes/subfeatures/document_editing/model/all_models.dart';
import 'package:nobook/src/features/notes/subfeatures/document_editing/model/sketch_painter.dart';
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
}

extension PointDoubleExtension on PointDouble {
  Offset get toOffset => Offset(x, y);
}
