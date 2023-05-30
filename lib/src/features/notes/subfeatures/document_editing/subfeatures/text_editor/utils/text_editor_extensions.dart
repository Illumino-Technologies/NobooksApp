import 'package:flutter/material.dart';
import 'package:nobook/src/features/notes/subfeatures/document_editing/document_editing_barrel.dart';

extension TextEditorControllerExtension on TextEditorController {
  Size computeLayoutSize() {
    final TextSpan textSpan = TextSpan(
      text: text,
      style: metadata?.style ?? TextEditorController.defaultMetadata.style,
    );
    final TextPainter tp = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );
    tp.layout();
    return tp.size;
  }
}

extension TextAlignExtension on TextAlign {
  Alignment get toAlignment {
    switch (this) {
      case TextAlign.start:
      case TextAlign.left:
        return Alignment.centerLeft;
      case TextAlign.end:
      case TextAlign.right:
        return Alignment.centerRight;
      case TextAlign.center:
        return Alignment.center;
      case TextAlign.justify:
        return Alignment.center;
    }
  }
}
