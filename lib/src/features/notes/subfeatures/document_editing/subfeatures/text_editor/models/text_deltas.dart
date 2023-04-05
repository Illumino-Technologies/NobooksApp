import 'package:nobook/src/features/notes/subfeatures/document_editing/subfeatures/text_editor/models/text_editor_models_barrel.dart';
import 'package:nobook/src/utils/utils_barrel.dart';

typedef TextDeltas = List<TextDelta>;

extension TextDeltasExtension on TextDeltas {
  String get text {
    if (isEmpty) return '';
    final StringBuffer stringBuffer = StringBuffer(first.char);
    for (int i = 1; i < length; i++) {
      stringBuffer.write(this[i].char);
    }
    return stringBuffer.toString();
  }

  void zipStringInto(String string) {
    final List<String> chars = string.chars;
    for (int i = 0; i < chars.length; ++i) {
      if (i > length) {
        add(TextDelta(char: chars[i]));
        continue;
      }
    }
  }

  TextDeltas get copy => List.from(this);
}

abstract class TextDeltasUtils {
  static TextDeltas deltasFromString(
    String string, [
    TextMetadata? metadata,
  ]) {
    final TextDeltas deltas = [];
    final List<String> chars = string.chars;

    for (final String char in chars) {
      deltas.add(TextDelta(char: char, metadata: metadata));
    }
    return deltas;
  }
}
