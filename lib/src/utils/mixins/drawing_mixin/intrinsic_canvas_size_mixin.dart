import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nobook/src/features/notes/notes_barrel.dart'
    show NoteDocumentController, DrawingsExentension;
import 'package:nobook/src/features/notes/subfeatures/document_editing/subfeatures/text_editor/utils/text_editor_extensions.dart';

mixin IntrinsicCanvasSizeMixin<Widget extends StatefulWidget> on State<Widget> {
  NoteDocumentController get controller;

  double get extraWidth => 50.w;

  double get extraHeight => 50.h;

  bool get mustUseExtraSize => false;

  late Size canvasSize = Size(extraWidth, extraHeight);

  Size get _extraSize => Size(extraWidth, extraHeight);

  void computeDocumentSize() {
    final bool drawingsEmpty = controller.drawingController.drawings.isEmpty;
    final bool textEmpty = controller.textController.text.isEmpty;

    if (drawingsEmpty && textEmpty) {
      canvasSize = mustUseExtraSize ? Size(extraWidth, extraHeight) : Size.zero;
      return;
    }

    final Size textLayoutSize = controller.textController.computeLayoutSize();

    final Size drawingLayoutSize =
        controller.drawingController.drawings.computeCanvasSizeByOffets();

    if (drawingsEmpty) {
      canvasSize = textLayoutSize
          .copyAddValues(height: textLayoutSize.height)
          .copyAddValues(height: (textLayoutSize / 2).height);
      return;
    }

    if (textEmpty) {
      canvasSize = drawingLayoutSize.copyAdd(_extraSize);
      return;
    }

    Size size =
        drawingLayoutSize > textLayoutSize ? drawingLayoutSize : textLayoutSize;

    if (size == Size.zero) return;
    size = Size(
      size.width + extraWidth,
      size.height + extraHeight,
    );

    print('size $size');

    canvasSize = size;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    computeDocumentSize();
  }
}

extension MyExtension on Size {
  Size copyAdd(Size other) => Size(
        width + other.width,
        height + other.height,
      );

  Size copyAddValues({
    double? height,
    double? width,
  }) =>
      Size(
        this.width + (width ?? 0),
        this.height + (height ?? 0),
      );

  Size operator +(Size other) => Size(
        width + other.width,
        height + other.height,
      );
}
