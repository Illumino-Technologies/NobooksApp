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
    final TextDeltas newDeltas = compareNewAndOldTextDeltasForChanges(
      TextDeltasUtils.deltasFromString(text),
      deltas.copy,
    );
    setDeltas(newDeltas);
  }

  void setDeltas(TextDeltas newDeltas) {
    deltas.clear();
    deltas.addAll(newDeltas);

    // if (selection.isCollapsed) {
    //   if (selection.end == text.length || textBeforeSelection().isNullOrEmpty) {
    //     return;
    //   }
    //   final TextMetadata newMetadata = (deltas.isNotEmpty
    //           ? deltas[text.indexOf(selection.textBefore(text).chars.last)]
    //               .metadata
    //           : metadata) ??
    //       metadata ??
    //       defaultMetadata;
    //
    //   if (selection.end != text.length) {
    //     _metadata = _metadata?.combineWith(newMetadata, false) ?? newMetadata;
    //   }
    // }
  }

  String? textBeforeSelection() {
    try {
      return selection.textBefore(text);
    } catch (e) {
      return null;
    }
  }

  TextDeltas compareNewAndOldTextDeltasForChanges(
    TextDeltas newDeltas,
    TextDeltas oldDeltas,
  ) {
    final TextDeltas modifiedDelta = oldDeltas.copy;

    final List<String> oldChars = oldDeltas.text.characters.toList();
    final List<String> newChars = newDeltas.text.characters.toList();

    final int minLength = min(oldChars.length, newChars.length);
    final bool? newIsMoreThanOld = newDeltas.length == oldDeltas.length
        ? null
        : newDeltas.length > oldDeltas.length;

    for (int i = 0; i < minLength; i++) {
      if (oldChars[i] != newChars[i]) {
        final TextDelta deltaForMetadata = newIsMoreThanOld == null
            ? oldDeltas[i]
            : newIsMoreThanOld
                ? (i <= 1 ? oldDeltas.first : oldDeltas[i - 1])
                : (i > (oldDeltas.length - 2)
                    ? oldDeltas.last
                    : oldDeltas[i + 1]);

        modifiedDelta[i] = modifiedDelta[i].copyWith(
          char: newChars[i],
          metadata: deltaForMetadata.metadata ?? metadata ?? defaultMetadata,
        );
      }
    }

    if (oldChars.length > newChars.length) {
      modifiedDelta.removeRange(minLength, oldChars.length);
    } else if (oldChars.length < newChars.length) {
      for (int i = minLength; i < newChars.length; i++) {
        modifiedDelta.add(
          TextDelta(
            char: newChars[i],
            metadata: metadata ?? defaultMetadata,
          ),
        );
      }
    }
    return modifiedDelta;
  }

  void applyDefaultMetadataChange(TextMetadata changedMetadata) {
    // metadata = changedMetadata.combineWith(metadata ?? defaultMetadata);
    metadata = changedMetadata;
  }

  void changeStyleOnSelectionChange({
    TextMetadata? changedMetadata,
    required TextDeltas modifiedDeltas,
    required TextSelection selection,
  }) {
    if (!selection.isValid) return;
    changedMetadata ??=
        deltas[text.indexOf(selection.textBefore(text).chars.last)].metadata ??
            metadata ??
            defaultMetadata;

    applyDefaultMetadataChange(changedMetadata);

    if (selection.isCollapsed) {
      // if (selection.end != text.length) {
      //   text = text.replaceRange(
      //     selection.start,
      //     selection.start + 1,
      //     '',
      //   );
      // }

      // modifiedDeltas.insert(
      //   selection.start,
      //   TextDelta(
      //     char: '',
      //     metadata: changedMetadata,
      //   ),
      // );

      return;
    }

    setDeltas(
      applyMetadataToTextInSelection(
        newMetadata: changedMetadata,
        deltas: modifiedDeltas,
        selection: selection,
      ),
    );
    notifyListeners();
  }

  TextDeltas applyMetadataToTextInSelection({
    required TextMetadata newMetadata,
    required TextDeltas deltas,
    required TextSelection selection,
  }) {
    final TextDeltas modifiedDeltas = deltas.copy;

    final int start = selection.start;
    final int end = selection.end;

    for (int i = start; i < end; i++) {
      modifiedDeltas[i] = modifiedDeltas[i].copyWith(
        metadata: modifiedDeltas[i].metadata?.combineWith(
                  newMetadata,
                ) ??
            newMetadata,
      );
    }
    return modifiedDeltas;
  }

  void toggleBold() {
    final TextMetadata tempMetadata = metadata ?? defaultMetadata;
    final TextMetadata changedMetadata = tempMetadata.copyWith(
      fontWeight: tempMetadata.fontWeight == FontWeight.normal
          ? FontWeight.w700
          : FontWeight.normal,
    );

    changeStyleOnSelectionChange(
      changedMetadata: changedMetadata,
      modifiedDeltas: deltas,
      selection: selection,
    );
  }

  void toggleItalic() {
    final TextMetadata tempMetadata = metadata ?? defaultMetadata;

    final TextMetadata changedMetadata = tempMetadata.copyWith(
      fontStyle: tempMetadata.fontStyle == FontStyle.italic
          ? FontStyle.normal
          : FontStyle.italic,
    );
    changeStyleOnSelectionChange(
      changedMetadata: changedMetadata,
      modifiedDeltas: deltas,
      selection: selection,
    );
  }

  void toggleUnderline() {
    final TextMetadata tempMetadata = metadata ?? defaultMetadata;

    final TextMetadata changedMetadata = tempMetadata.copyWith(
      decoration: tempMetadata.decoration == TextDecorationEnum.underline
          ? TextDecorationEnum.none
          : TextDecorationEnum.underline,
    );

    changeStyleOnSelectionChange(
      changedMetadata: changedMetadata,
      modifiedDeltas: deltas,
      selection: selection,
    );
  }

  void changeAlignment(TextAlign alignment) {
    applyDefaultMetadataChange(
      (metadata ?? defaultMetadata).copyWith(alignment: alignment),
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

    final TextSpan textSpan = TextSpan(
      style: metadata?.style ?? style,
      children: spanChildren,
    );
    // if (metadata?.alignment != null) {
    //   return TextSpan(
    //     style: metadata?.style ?? style,
    //     children: [
    //       WidgetSpan(
    //         child: Align(
    //           alignment:
    //               metadata?.alignment.toAlignment ?? Alignment.centerLeft,
    //           child: Text.rich(textSpan),
    //         ),
    //       ),
    //     ],
    //   );
    // }
    return textSpan;
  }

  @override
  void dispose() {
    removeListener(_internalControllerListener);
    super.dispose();
  }
}
