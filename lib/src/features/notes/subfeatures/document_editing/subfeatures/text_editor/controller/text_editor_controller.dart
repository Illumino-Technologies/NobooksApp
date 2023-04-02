// import 'package:flutter/material.dart';
//
// class TextEditorController<T  extends TextEditingValue> extends ValueNotifier<T> {
//   TextEditorController({ String? text })
//       : super(text == null ? TextEditingValue.empty : TextEditingValue(text: text));
//
//   TextEditorController.fromValue(TextEditingValue? value)
//       : assert(
//   value == null || !value.composing.isValid || value.isComposingRangeValid,
//   'New TextEditingValue $value has an invalid non-empty composing range '
//       '${value.composing}. It is recommended to use a valid composing range, '
//       'even for readonly text fields',
//   ),
//         super(value ?? TextEditingValue.empty);
//
//   String get text => value.text;
//
//   set text(String newText) {
//     value = value.copyWith(
//       text: newText,
//       selection: const TextSelection.collapsed(offset: -1),
//       composing: TextRange.empty,
//     );
//   }
//
//   @override
//   set value(TextEditingValue newValue) {
//     assert(
//     !newValue.composing.isValid || newValue.isComposingRangeValid,
//     'New TextEditingValue $newValue has an invalid non-empty composing range '
//         '${newValue.composing}. It is recommended to use a valid composing range, '
//         'even for readonly text fields',
//     );
//     super.value = newValue;
//   }
//
//   TextSpan buildTextSpan({required BuildContext context, TextStyle? style , required bool withComposing}) {
//     assert(!value.composing.isValid || !withComposing || value.isComposingRangeValid);
//     // If the composing range is out of range for the current text, ignore it to
//     // preserve the tree integrity, otherwise in release mode a RangeError will
//     // be thrown and this EditableText will be built with a broken subtree.
//     final bool composingRegionOutOfRange = !value.isComposingRangeValid || !withComposing;
//
//     if (composingRegionOutOfRange) {
//       return TextSpan(style: style, text: text);
//     }
//
//     final TextStyle composingStyle = style?.merge(const TextStyle(decoration: TextDecoration.underline))
//         ?? const TextStyle(decoration: TextDecoration.underline);
//     return TextSpan(
//       style: style,
//       children: <TextSpan>[
//         TextSpan(text: value.composing.textBefore(value.text)),
//         TextSpan(
//           style: composingStyle,
//           text: value.composing.textInside(value.text),
//         ),
//         TextSpan(text: value.composing.textAfter(value.text)),
//       ],
//     );
//   }
//
//   TextSelection get selection => value.selection;
//
//   set selection(TextSelection newSelection) {
//     if (!isSelectionWithinTextBounds(newSelection)) {
//       throw FlutterError('invalid text selection: $newSelection');
//     }
//     final TextRange newComposing =
//     newSelection.isCollapsed && _isSelectionWithinComposingRange(newSelection)
//         ? value.composing
//         : TextRange.empty;
//     value = value.copyWith(selection: newSelection, composing: newComposing);
//   }
//
//   void clear() {
//     value = const TextEditingValue(selection: TextSelection.collapsed(offset: 0));
//   }
//
//   void clearComposing() {
//     value = value.copyWith(composing: TextRange.empty);
//   }
//
//   bool isSelectionWithinTextBounds(TextSelection selection) {
//     return selection.start <= text.length && selection.end <= text.length;
//   }
//
//   bool _isSelectionWithinComposingRange(TextSelection selection) {
//     return selection.start >= value.composing.start && selection.end <= value.composing.end;
//   }
// }
