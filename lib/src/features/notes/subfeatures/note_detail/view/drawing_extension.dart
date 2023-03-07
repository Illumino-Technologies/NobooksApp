import 'dart:ui';

import 'package:nobook/src/features/notes/subfeatures/document_editing/drawing/drawing_barrel.dart';
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
