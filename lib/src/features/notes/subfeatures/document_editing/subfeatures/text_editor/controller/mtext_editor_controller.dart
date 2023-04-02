import 'package:flutter/material.dart';
import 'package:nobook/src/features/notes/subfeatures/document_editing/subfeatures/text_editor/models/text_deltas.dart';
import 'package:nobook/src/features/notes/subfeatures/document_editing/subfeatures/text_editor/models/text_editor_models_barrel.dart';

class TextEditorController extends TextEditingController {
  final TextDeltas deltas;
  TextMetadata? _metadata;

  TextMetadata? get metadata => _metadata;

  set metadata(TextMetadata? value) {
    _metadata = value;
  }

  TextEditorController({
    super.text,
  }) : deltas = text == null ? [] : TextDeltasUtils.deltasFromString(text);

  void _internalControllerListener() {}

  void applyStyleChange(TextMetadata metaData) {}

  void toggleBold() {
    final TextMetadata tempMetadata = metadata ?? const TextMetadata();
    applyStyleChange(
      tempMetadata.copyWith(
        fontWeight: tempMetadata.fontWeight == FontWeight.normal
            ? FontWeight.w700
            : FontWeight.normal,
      ),
    );
  }

  void toggleItalic() {
    final TextMetadata tempMetadata = metadata ?? const TextMetadata();

    applyStyleChange(
      tempMetadata.copyWith(
        fontStyle: tempMetadata.fontStyle == FontStyle.italic
            ? FontStyle.normal
            : FontStyle.italic,
      ),
    );
  }

  void toggleUnderline() {
    final TextMetadata tempMetadata = metadata ?? const TextMetadata();

    applyStyleChange(tempMetadata.copyWith(decoration: tempMetadata.decoration == TextDecoration.underline ? TextDecoration.none))



  }

  void changeAlignment() {}

  @override
  TextSpan buildTextSpan({
    required BuildContext context,
    TextStyle? style,
    required bool withComposing,
  }) {
    final List<TextSpan> spanChildren = [];

    for (final TextDelta delta in deltas) {
      spanChildren.add(
        TextSpan(
          text: delta.char,
          style: delta.metadata?.style,
        ),
      );
    }

    return TextSpan(
      style: metadata?.style,
      children: spanChildren,
    );
  }
}
