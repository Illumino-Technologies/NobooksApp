import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nobook/src/features/notes/notes_barrel.dart'
    show NoteDocumentController, DrawingsExentension;

mixin IntrinsicCanvasSizeMixin on State {
  NoteDocumentController get controller;

  double get extraWidth => 50.w;

  double get extraHeight => 50.h;

  late Size canvasSize = Size(extraWidth, extraHeight);

  void computeDrawingSize() {
    if (controller.drawingController.drawings.isEmpty) return;

    Size size =
        controller.drawingController.drawings.computeCanvasSizeByOffets();

    if (size == Size.zero) return;
    size = Size(
      size.width + extraWidth,
      size.height + extraHeight,
    );

    canvasSize = size;
  }

  @override
  void initState() {
    super.initState();
    computeDrawingSize();
  }
}
