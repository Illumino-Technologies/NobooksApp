import 'dart:math';

import 'package:flutter/material.dart';
import 'package:nobook/src/features/notes/subfeatures/document_editing/subfeatures/text_editor/models/text_deltas.dart';
import 'package:nobook/src/features/notes/subfeatures/document_editing/subfeatures/text_editor/models/text_editor_models_barrel.dart';
import 'package:nobook/src/utils/function/extensions/extensions.dart';

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

  static const TextMetadata defaultMetadata = TextMetadata(
    alignment: TextAlign.start,
    decoration: TextDecorationEnum.none,
    fontSize: 14,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w400,
    fontFeatures: null,
  );

  void _internalControllerListener() {
    setDeltas(TextDeltasUtils.deltasFromString(text));
  }

  void setDeltas(TextDeltas newDeltas) {
    deltas.clear();
    deltas.addAll(newDeltas);
  }

  TextDeltas compareNewAndOldTextDeltasForChanges(
    TextDeltas newDeltas,
    TextDeltas oldDeltas,
  ) {
    final TextDeltas modifiedDelta = oldDeltas.copy;

    final List<String> oldChars = oldDeltas.text.chars;
    final List<String> newChars = newDeltas.text.chars;

    final int minLength = min(oldChars.length, newChars.length);

    for (int i = 0; i < minLength; i++) {
      if (oldChars[i] != newChars[i]) {
        modifiedDelta[i] = modifiedDelta[i].copyWith(
          char: newChars[i],
          metadata: newDeltas[i].metadata ?? metadata ?? defaultMetadata,
        );
      }
    }

    if (oldChars.length > newChars.length) {
      for (int i = minLength; i < oldChars.length; i++) {
        modifiedDelta.removeAt(i);
      }
    } else if (oldChars.length < newChars.length) {
      for (int i = minLength; i < newChars.length; i++) {
        modifiedDelta.add(
          TextDelta(
            char: newChars[i],
            metadata: defaultMetadata,
          ),
        );
      }
    }
    return modifiedDelta;
  }

  void applyDefaultMetadataChange(TextMetadata changedMetadata) {
    metadata = changedMetadata;
  }

  void changeStyleOnSelectionChange({
    TextMetadata? currentMetadata,
    required TextDeltas modifiedDeltas,
    required TextSelection selection,
  }) {
    if (!selection.isValid) return;
    print('selection is valid');
    currentMetadata ??=
        deltas[text.indexOf(selection.textBefore(text).chars.last)].metadata ??
            metadata ??
            defaultMetadata;

    if (selection.isCollapsed) {
      print('selection is collapsed');
      applyDefaultMetadataChange(currentMetadata);
      return;
    }

    setDeltas(
      applyMetadataToTextInSelection(
        metadata: currentMetadata,
        deltas: modifiedDeltas,
        selection: selection,
      ),
    );
    notifyListeners();
  }

  TextDeltas applyMetadataToTextInSelection({
    required TextMetadata metadata,
    required TextDeltas deltas,
    required TextSelection selection,
  }) {
    final TextDeltas modifiedDeltas = deltas.copy;

    final int start = selection.start;
    final int end = selection.end;

    print('start is $start and end is $end');

    for (int i = start; i < end; i++) {
      modifiedDeltas[i] = modifiedDeltas[i].copyWith(
        metadata: metadata,
      );
    }
    return modifiedDeltas;
  }

  void toggleBold() {
    final TextMetadata tempMetadata = metadata ?? const TextMetadata();
    final TextMetadata changedMetadata = tempMetadata.copyWith(
      fontWeight: tempMetadata.fontWeight == FontWeight.normal
          ? FontWeight.w700
          : FontWeight.normal,
    );

    changeStyleOnSelectionChange(
      currentMetadata: changedMetadata,
      modifiedDeltas: deltas,
      selection: selection,
    );
  }

  void toggleItalic() {
    final TextMetadata tempMetadata = metadata ?? const TextMetadata();

    final TextMetadata changedMetadata = tempMetadata.copyWith(
      fontStyle: tempMetadata.fontStyle == FontStyle.italic
          ? FontStyle.normal
          : FontStyle.italic,
    );
    changeStyleOnSelectionChange(
      currentMetadata: changedMetadata,
      modifiedDeltas: deltas,
      selection: selection,
    );
  }

  void toggleUnderline() {
    final TextMetadata tempMetadata = metadata ?? const TextMetadata();

    final TextMetadata changedMetadata = tempMetadata.copyWith(
      decoration: tempMetadata.decoration == TextDecorationEnum.underline
          ? TextDecorationEnum.none
          : TextDecorationEnum.underline,
    );

    changeStyleOnSelectionChange(
      currentMetadata: changedMetadata,
      modifiedDeltas: deltas,
      selection: selection,
    );
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
          style: delta.metadata?.style ?? defaultMetadata.style,
        ),
      );
    }

    return TextSpan(
      style: metadata?.style ?? style,
      children: spanChildren,
    );
  }

  @override
  void dispose() {
    removeListener(_internalControllerListener);
    super.dispose();
  }
}
