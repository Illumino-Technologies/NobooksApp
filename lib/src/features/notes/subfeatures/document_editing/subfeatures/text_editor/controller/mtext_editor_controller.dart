import 'package:flutter/material.dart';
import 'package:nobook/src/features/notes/subfeatures/document_editing/subfeatures/text_editor/models/text_deltas.dart';
import 'package:nobook/src/features/notes/subfeatures/document_editing/subfeatures/text_editor/models/text_editor_models_barrel.dart';

class TextEditorController extends TextEditingController {
  final TextDeltas deltas;
  TextMetadata? _metadata;

  TextMetadata? get metadata => _metadata;

  set metadata(TextMetadata? value) {
    _metadata = value;
    notifyListeners();
  }

  TextEditorController({
    super.text,
  }) : deltas = text == null ? [] : TextDeltasUtils.deltasFromString(text) {
    addListener(_internalControllerListener);
  }

  void _internalControllerListener() {
    deltas.clear();
    deltas.addAll(TextDeltasUtils.deltasFromString(text));
  }

  void applyDefaultMetadataChange(TextMetadata changedMetadata) {
    metadata = changedMetadata;
  }

  void toggleBold() {
    final TextMetadata tempMetadata = metadata ?? const TextMetadata();
    final TextMetadata changedMetadata = tempMetadata.copyWith(
      fontWeight: tempMetadata.fontWeight == FontWeight.normal
          ? FontWeight.w700
          : FontWeight.normal,
    );

    applyDefaultMetadataChange(changedMetadata);
    //TODO: add selection specific metadata change
  }

  void toggleItalic() {
    final TextMetadata tempMetadata = metadata ?? const TextMetadata();

    final TextMetadata changedMetadata = tempMetadata.copyWith(
      fontStyle: tempMetadata.fontStyle == FontStyle.italic
          ? FontStyle.normal
          : FontStyle.italic,
    );
    applyDefaultMetadataChange(changedMetadata);
    //TODO: add selection specific metadata change
  }

  void toggleUnderline() {
    final TextMetadata tempMetadata = metadata ?? const TextMetadata();

    final TextMetadata changedMetadata = tempMetadata.copyWith(
      decoration: tempMetadata.decoration == TextDecorationEnum.underline
          ? TextDecorationEnum.none
          : TextDecorationEnum.underline,
    );
    applyDefaultMetadataChange(changedMetadata);
    //TODO: add selection specific metadata change
  }

  void changeAlignment(TextAlign alignment) {
    applyDefaultMetadataChange(
      (metadata ?? const TextMetadata()).copyWith(alignment: alignment),
    );


    selection;
  }

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

  @override
  void dispose() {
    removeListener(_internalControllerListener);
    super.dispose();
  }
}
