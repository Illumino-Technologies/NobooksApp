import 'package:flutter/foundation.dart';
import 'package:nobook/src/features/notes/subfeatures/document_editing/model/document_editor_model.dart';
import 'package:nobook/src/features/notes/subfeatures/note_detail/view/note_detail_page.dart';

class DrawingController extends ChangeNotifier {
  late Eraser eraser;
  late DrawingMode drawingMode;

  void initialize({
    Eraser? eraser,
    DrawingMode? drawingMode,
  }) {
    //TODO: initializeValues from cache/storage
    this.drawingMode = drawingMode ?? DrawingMode.sketch;
    this.eraser = eraser ??
        const Eraser(
          region: Region(
            centre: PointDouble(0, 0),
            radius: 5,
          ),
          mode: EraseMode.area,
        );
  }
}

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
}
