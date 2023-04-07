import 'package:flutter/material.dart';

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
