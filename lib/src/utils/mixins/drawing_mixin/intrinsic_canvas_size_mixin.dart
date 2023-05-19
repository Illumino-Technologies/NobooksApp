import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nobook/src/features/notes/notes_barrel.dart'
    show NoteDocumentController, DrawingsExentension;

mixin IntrinsicCanvasSizeMixin<Widget extends StatefulWidget> on State<Widget> {
  NoteDocumentController get controller;

  double get extraWidth => 50.w;

  double get extraHeight => 50.h;

  late Size canvasSize = Size(extraWidth, extraHeight);

  void computeDrawingSize() {
    if (controller.drawingController.drawings.isEmpty) {
      canvasSize = Size(extraWidth, extraHeight);
      return;
    }

    Size size =
        controller.drawingController.drawings.computeCanvasSizeByOffets();

    print('canvas size: $size');

    if (size == Size.zero) return;
    size = Size(
      size.width + extraWidth,
      size.height + extraHeight,
    );

    canvasSize = size;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    computeDrawingSize();
  }
}
