import 'dart:async';
import 'dart:math' as math;
import 'dart:ui' as ui hide TextStyle;

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart' show DragStartBehavior;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
// Examples can assume:
// late BuildContext context;

typedef SelectionChangedCallback = void Function(
    TextSelection selection, SelectionChangedCause? cause);

typedef AppPrivateCommandCallback = void Function(String, Map<String, dynamic>);

typedef EditableTextContextMenuBuilder = Widget Function(
  BuildContext context,
  EditableTextState editableTextState,
);

// The time it takes for the cursor to fade from fully opaque to fully
// transparent and vice versa. A full cursor blink, from transparent to opaque
// to transparent, is twice this duration.
const Duration _kCursorBlinkHalfPeriod = Duration(milliseconds: 500);

// Number of cursor ticks during which the most recently entered character
// is shown in an obscured text field.
const int _kObscureShowLatestCharCursorTicks = 3;

class TextEditingController extends ValueNotifier<TextEditingValue> {
  TextEditingController({String? text})
      : super(text == null
            ? TextEditingValue.empty
            : TextEditingValue(text: text));

  TextEditingController.fromValue(TextEditingValue? value)
      : assert(
          value == null ||
              !value.composing.isValid ||
              value.isComposingRangeValid,
          'New TextEditingValue $value has an invalid non-empty composing range '
          '${value.composing}. It is recommended to use a valid composing range, '
          'even for readonly text fields',
        ),
        super(value ?? TextEditingValue.empty);

  String get text => value.text;

  set text(String newText) {
    value = value.copyWith(
      text: newText,
      selection: const TextSelection.collapsed(offset: -1),
      composing: TextRange.empty,
    );
  }

  @override
  set value(TextEditingValue newValue) {
    assert(
      !newValue.composing.isValid || newValue.isComposingRangeValid,
      'New TextEditingValue $newValue has an invalid non-empty composing range '
      '${newValue.composing}. It is recommended to use a valid composing range, '
      'even for readonly text fields',
    );
    super.value = newValue;
  }

  TextSpan buildTextSpan(
      {required BuildContext context,
      TextStyle? style,
      required bool withComposing}) {
    assert(!value.composing.isValid ||
        !withComposing ||
        value.isComposingRangeValid);
    // If the composing range is out of range for the current text, ignore it to
    // preserve the tree integrity, otherwise in release mode a RangeError will
    // be thrown and this EditableText will be built with a broken subtree.
    final bool composingRegionOutOfRange =
        !value.isComposingRangeValid || !withComposing;

    if (composingRegionOutOfRange) {
      return TextSpan(style: style, text: text);
    }

    final TextStyle composingStyle =
        style?.merge(const TextStyle(decoration: TextDecoration.underline)) ??
            const TextStyle(decoration: TextDecoration.underline);
    return TextSpan(
      style: style,
      children: <TextSpan>[
        TextSpan(text: value.composing.textBefore(value.text)),
        TextSpan(
          style: composingStyle,
          text: value.composing.textInside(value.text),
        ),
        TextSpan(text: value.composing.textAfter(value.text)),
      ],
    );
  }

  TextSelection get selection => value.selection;

  set selection(TextSelection newSelection) {
    if (!isSelectionWithinTextBounds(newSelection)) {
      throw FlutterError('invalid text selection: $newSelection');
    }
    final TextRange newComposing = newSelection.isCollapsed &&
            _isSelectionWithinComposingRange(newSelection)
        ? value.composing
        : TextRange.empty;
    value = value.copyWith(selection: newSelection, composing: newComposing);
  }

  void clear() {
    value =
        const TextEditingValue(selection: TextSelection.collapsed(offset: 0));
  }

  void clearComposing() {
    value = value.copyWith(composing: TextRange.empty);
  }

  bool isSelectionWithinTextBounds(TextSelection selection) {
    return selection.start <= text.length && selection.end <= text.length;
  }

  bool _isSelectionWithinComposingRange(TextSelection selection) {
    return selection.start >= value.composing.start &&
        selection.end <= value.composing.end;
  }
}

@Deprecated(
  'Use `contextMenuBuilder` instead. '
  'This feature was deprecated after v3.3.0-0.5.pre.',
)
class ToolbarOptions {
  @Deprecated(
    'Use `contextMenuBuilder` instead. '
    'This feature was deprecated after v3.3.0-0.5.pre.',
  )
  const ToolbarOptions({
    this.copy = false,
    this.cut = false,
    this.paste = false,
    this.selectAll = false,
  })  : assert(copy != null),
        assert(cut != null),
        assert(paste != null),
        assert(selectAll != null);

  static const ToolbarOptions empty = ToolbarOptions();

  final bool copy;

  final bool cut;

  final bool paste;

  final bool selectAll;
}

// A time-value pair that represents a key frame in an animation.
class _KeyFrame {
  const _KeyFrame(this.time, this.value);

  // Values extracted from iOS 15.4 UIKit.
  static const List<_KeyFrame> iOSBlinkingCaretKeyFrames = <_KeyFrame>[
    _KeyFrame(0, 1), // 0
    _KeyFrame(0.5, 1), // 1
    _KeyFrame(0.5375, 0.75), // 2
    _KeyFrame(0.575, 0.5), // 3
    _KeyFrame(0.6125, 0.25), // 4
    _KeyFrame(0.65, 0), // 5
    _KeyFrame(0.85, 0), // 6
    _KeyFrame(0.8875, 0.25), // 7
    _KeyFrame(0.925, 0.5), // 8
    _KeyFrame(0.9625, 0.75), // 9
    _KeyFrame(1, 1), // 10
  ];

  // The timing, in seconds, of the specified animation `value`.
  final double time;
  final double value;
}

class _DiscreteKeyFrameSimulation extends Simulation {
  _DiscreteKeyFrameSimulation.iOSBlinkingCaret()
      : this._(_KeyFrame.iOSBlinkingCaretKeyFrames, 1);

  _DiscreteKeyFrameSimulation._(this._keyFrames, this.maxDuration)
      : assert(_keyFrames.isNotEmpty),
        assert(_keyFrames.last.time <= maxDuration),
        assert(() {
          for (int i = 0; i < _keyFrames.length - 1; i += 1) {
            if (_keyFrames[i].time > _keyFrames[i + 1].time) {
              return false;
            }
          }
          return true;
        }(), 'The key frame sequence must be sorted by time.');

  final double maxDuration;

  final List<_KeyFrame> _keyFrames;

  @override
  double dx(double time) => 0;

  @override
  bool isDone(double time) => time >= maxDuration;

  // The index of the KeyFrame corresponds to the most recent input `time`.
  int _lastKeyFrameIndex = 0;

  @override
  double x(double time) {
    final int length = _keyFrames.length;

    // Perform a linear search in the sorted key frame list, starting from the
    // last key frame found, since the input `time` usually monotonically
    // increases by a small amount.
    int searchIndex;
    final int endIndex;
    if (_keyFrames[_lastKeyFrameIndex].time > time) {
      // The simulation may have restarted. Search within the index range
      // [0, _lastKeyFrameIndex).
      searchIndex = 0;
      endIndex = _lastKeyFrameIndex;
    } else {
      searchIndex = _lastKeyFrameIndex;
      endIndex = length;
    }

    // Find the target key frame. Don't have to check (endIndex - 1): if
    // (endIndex - 2) doesn't work we'll have to pick (endIndex - 1) anyways.
    while (searchIndex < endIndex - 1) {
      assert(_keyFrames[searchIndex].time <= time);
      final _KeyFrame next = _keyFrames[searchIndex + 1];
      if (time < next.time) {
        break;
      }
      searchIndex += 1;
    }

    _lastKeyFrameIndex = searchIndex;
    return _keyFrames[_lastKeyFrameIndex].value;
  }
}

class EditableText extends StatefulWidget {
  EditableText({
    super.key,
    required this.controller,
    required this.focusNode,
    this.readOnly = false,
    this.obscuringCharacter = '•',
    this.obscureText = false,
    this.autocorrect = true,
    SmartDashesType? smartDashesType,
    SmartQuotesType? smartQuotesType,
    this.enableSuggestions = true,
    required this.style,
    StrutStyle? strutStyle,
    required this.cursorColor,
    required this.backgroundCursorColor,
    this.textAlign = TextAlign.start,
    this.textDirection,
    this.locale,
    this.textScaleFactor,
    this.maxLines = 1,
    this.minLines,
    this.expands = false,
    this.forceLine = true,
    this.textHeightBehavior,
    this.textWidthBasis = TextWidthBasis.parent,
    this.autofocus = false,
    bool? showCursor,
    this.showSelectionHandles = false,
    this.selectionColor,
    this.selectionControls,
    TextInputType? keyboardType,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
    this.onAppPrivateCommand,
    this.onSelectionChanged,
    this.onSelectionHandleTapped,
    this.onTapOutside,
    List<TextInputFormatter>? inputFormatters,
    this.mouseCursor,
    this.rendererIgnoresPointer = false,
    this.cursorWidth = 2.0,
    this.cursorHeight,
    this.cursorRadius,
    this.cursorOpacityAnimates = false,
    this.cursorOffset,
    this.paintCursorAboveText = false,
    this.selectionHeightStyle = ui.BoxHeightStyle.tight,
    this.selectionWidthStyle = ui.BoxWidthStyle.tight,
    this.scrollPadding = const EdgeInsets.all(20.0),
    this.keyboardAppearance = Brightness.light,
    this.dragStartBehavior = DragStartBehavior.start,
    bool? enableInteractiveSelection,
    this.scrollController,
    this.scrollPhysics,
    this.autocorrectionTextRectColor,
    @Deprecated(
      'Use `contextMenuBuilder` instead. '
      'This feature was deprecated after v3.3.0-0.5.pre.',
    )
        ToolbarOptions? toolbarOptions,
    this.autofillHints = const <String>[],
    this.autofillClient,
    this.clipBehavior = Clip.hardEdge,
    this.restorationId,
    this.scrollBehavior,
    this.scribbleEnabled = true,
    this.enableIMEPersonalizedLearning = true,
    this.contextMenuBuilder,
    this.spellCheckConfiguration,
    this.magnifierConfiguration = TextMagnifierConfiguration.disabled,
  })  : assert(controller != null),
        assert(focusNode != null),
        assert(obscuringCharacter != null && obscuringCharacter.length == 1),
        assert(obscureText != null),
        assert(autocorrect != null),
        smartDashesType = smartDashesType ??
            (obscureText ? SmartDashesType.disabled : SmartDashesType.enabled),
        smartQuotesType = smartQuotesType ??
            (obscureText ? SmartQuotesType.disabled : SmartQuotesType.enabled),
        assert(enableSuggestions != null),
        assert(showSelectionHandles != null),
        assert(readOnly != null),
        assert(forceLine != null),
        assert(style != null),
        assert(cursorColor != null),
        assert(cursorOpacityAnimates != null),
        assert(paintCursorAboveText != null),
        assert(backgroundCursorColor != null),
        assert(selectionHeightStyle != null),
        assert(selectionWidthStyle != null),
        assert(textAlign != null),
        assert(maxLines == null || maxLines > 0),
        assert(minLines == null || minLines > 0),
        assert(
          (maxLines == null) || (minLines == null) || (maxLines >= minLines),
          "minLines can't be greater than maxLines",
        ),
        assert(expands != null),
        assert(
          !expands || (maxLines == null && minLines == null),
          'minLines and maxLines must be null when expands is true.',
        ),
        assert(!obscureText || maxLines == 1,
            'Obscured fields cannot be multiline.'),
        assert(autofocus != null),
        assert(rendererIgnoresPointer != null),
        assert(scrollPadding != null),
        assert(dragStartBehavior != null),
        enableInteractiveSelection =
            enableInteractiveSelection ?? (!readOnly || !obscureText),
        toolbarOptions = selectionControls is TextSelectionHandleControls &&
                toolbarOptions == null
            ? ToolbarOptions.empty
            : toolbarOptions ??
                (obscureText
                    ? (readOnly
                        // No point in even offering "Select All" in a read-only obscured
                        // field.
                        ? ToolbarOptions.empty
                        // Writable, but obscured.
                        : const ToolbarOptions(
                            selectAll: true,
                            paste: true,
                          ))
                    : (readOnly
                        // Read-only, not obscured.
                        ? const ToolbarOptions(
                            selectAll: true,
                            copy: true,
                          )
                        // Writable, not obscured.
                        : const ToolbarOptions(
                            copy: true,
                            cut: true,
                            selectAll: true,
                            paste: true,
                          ))),
        assert(clipBehavior != null),
        assert(enableIMEPersonalizedLearning != null),
        assert(
          spellCheckConfiguration == null ||
              spellCheckConfiguration ==
                  const SpellCheckConfiguration.disabled() ||
              spellCheckConfiguration.misspelledTextStyle != null,
          'spellCheckConfiguration must specify a misspelledTextStyle if spell check behavior is desired',
        ),
        _strutStyle = strutStyle,
        keyboardType = keyboardType ??
            _inferKeyboardType(
                autofillHints: autofillHints, maxLines: maxLines),
        inputFormatters = maxLines == 1
            ? <TextInputFormatter>[
                FilteringTextInputFormatter.singleLineFormatter,
                ...inputFormatters ??
                    const Iterable<TextInputFormatter>.empty(),
              ]
            : inputFormatters,
        showCursor = showCursor ?? !readOnly;

  final TextEditingController controller;

  final FocusNode focusNode;

  final String obscuringCharacter;

  final bool obscureText;

  final TextHeightBehavior? textHeightBehavior;

  final TextWidthBasis textWidthBasis;

  final bool readOnly;

  final bool forceLine;

  final ToolbarOptions toolbarOptions;

  final bool showSelectionHandles;

  final bool showCursor;

  final bool autocorrect;

  final SmartDashesType smartDashesType;

  final SmartQuotesType smartQuotesType;

  final bool enableSuggestions;

  final TextStyle style;

  StrutStyle get strutStyle {
    if (_strutStyle == null) {
      return StrutStyle.fromTextStyle(style, forceStrutHeight: true);
    }
    return _strutStyle!.inheritFromTextStyle(style);
  }

  final StrutStyle? _strutStyle;

  final TextAlign textAlign;

  final TextDirection? textDirection;

  final TextCapitalization textCapitalization;

  final Locale? locale;

  final double? textScaleFactor;

  final Color cursorColor;

  final Color? autocorrectionTextRectColor;

  final Color backgroundCursorColor;

  final int? maxLines;

  final int? minLines;

  final bool expands;

  // See https://github.com/flutter/flutter/issues/7035 for the rationale for this
  // keyboard behavior.
  final bool autofocus;

  final Color? selectionColor;

  final TextSelectionControls? selectionControls;

  final TextInputType keyboardType;

  final TextInputAction? textInputAction;

  final ValueChanged<String>? onChanged;

  final VoidCallback? onEditingComplete;

  final ValueChanged<String>? onSubmitted;

  final AppPrivateCommandCallback? onAppPrivateCommand;

  final SelectionChangedCallback? onSelectionChanged;

  final VoidCallback? onSelectionHandleTapped;

  final TapRegionCallback? onTapOutside;

  final List<TextInputFormatter>? inputFormatters;

  final MouseCursor? mouseCursor;

  final bool rendererIgnoresPointer;

  final double cursorWidth;

  final double? cursorHeight;

  final Radius? cursorRadius;

  final bool cursorOpacityAnimates;

  final Offset? cursorOffset;

  final bool paintCursorAboveText;

  final ui.BoxHeightStyle selectionHeightStyle;

  final ui.BoxWidthStyle selectionWidthStyle;

  final Brightness keyboardAppearance;

  final EdgeInsets scrollPadding;

  final bool enableInteractiveSelection;

  static bool debugDeterministicCursor = false;

  final DragStartBehavior dragStartBehavior;

  final ScrollController? scrollController;

  final ScrollPhysics? scrollPhysics;

  final bool scribbleEnabled;

  bool get selectionEnabled => enableInteractiveSelection;

  final Iterable<String>? autofillHints;

  final AutofillClient? autofillClient;

  final Clip clipBehavior;

  final String? restorationId;

  final ScrollBehavior? scrollBehavior;

  final bool enableIMEPersonalizedLearning;

  final EditableTextContextMenuBuilder? contextMenuBuilder;

  final SpellCheckConfiguration? spellCheckConfiguration;

  final TextMagnifierConfiguration magnifierConfiguration;

  bool get _userSelectionEnabled =>
      enableInteractiveSelection && (!readOnly || !obscureText);

  static List<ContextMenuButtonItem> getEditableButtonItems({
    required final ClipboardStatus? clipboardStatus,
    required final VoidCallback? onCopy,
    required final VoidCallback? onCut,
    required final VoidCallback? onPaste,
    required final VoidCallback? onSelectAll,
  }) {
    // If the paste button is enabled, don't render anything until the state
    // of the clipboard is known, since it's used to determine if paste is
    // shown.
    if (onPaste != null && clipboardStatus == ClipboardStatus.unknown) {
      return <ContextMenuButtonItem>[];
    }

    return <ContextMenuButtonItem>[
      if (onCut != null)
        ContextMenuButtonItem(
          onPressed: onCut,
          type: ContextMenuButtonType.cut,
        ),
      if (onCopy != null)
        ContextMenuButtonItem(
          onPressed: onCopy,
          type: ContextMenuButtonType.copy,
        ),
      if (onPaste != null)
        ContextMenuButtonItem(
          onPressed: onPaste,
          type: ContextMenuButtonType.paste,
        ),
      if (onSelectAll != null)
        ContextMenuButtonItem(
          onPressed: onSelectAll,
          type: ContextMenuButtonType.selectAll,
        ),
    ];
  }

  // Infer the keyboard type of an `EditableText` if it's not specified.
  static TextInputType _inferKeyboardType({
    required Iterable<String>? autofillHints,
    required int? maxLines,
  }) {
    if (autofillHints == null || autofillHints.isEmpty) {
      return maxLines == 1 ? TextInputType.text : TextInputType.multiline;
    }

    final String effectiveHint = autofillHints.first;

    // On iOS oftentimes specifying a text content type is not enough to qualify
    // the input field for autofill. The keyboard type also needs to be compatible
    // with the content type. To get autofill to work by default on EditableText,
    // the keyboard type inference on iOS is done differently from other platforms.
    //
    // The entries with "autofill not working" comments are the iOS text content
    // types that should work with the specified keyboard type but won't trigger
    // (even within a native app). Tested on iOS 13.5.
    if (!kIsWeb) {
      switch (defaultTargetPlatform) {
        case TargetPlatform.iOS:
        case TargetPlatform.macOS:
          {
            const Map<String, TextInputType> iOSKeyboardType =
                <String, TextInputType>{
              AutofillHints.addressCity: TextInputType.name,
              AutofillHints.addressCityAndState: TextInputType.name,
              // Autofill not working.
              AutofillHints.addressState: TextInputType.name,
              AutofillHints.countryName: TextInputType.name,
              AutofillHints.creditCardNumber: TextInputType.number,
              // Couldn't test.
              AutofillHints.email: TextInputType.emailAddress,
              AutofillHints.familyName: TextInputType.name,
              AutofillHints.fullStreetAddress: TextInputType.name,
              AutofillHints.givenName: TextInputType.name,
              AutofillHints.jobTitle: TextInputType.name,
              // Autofill not working.
              AutofillHints.location: TextInputType.name,
              // Autofill not working.
              AutofillHints.middleName: TextInputType.name,
              // Autofill not working.
              AutofillHints.name: TextInputType.name,
              AutofillHints.namePrefix: TextInputType.name,
              // Autofill not working.
              AutofillHints.nameSuffix: TextInputType.name,
              // Autofill not working.
              AutofillHints.newPassword: TextInputType.text,
              AutofillHints.newUsername: TextInputType.text,
              AutofillHints.nickname: TextInputType.name,
              // Autofill not working.
              AutofillHints.oneTimeCode: TextInputType.number,
              AutofillHints.organizationName: TextInputType.text,
              // Autofill not working.
              AutofillHints.password: TextInputType.text,
              AutofillHints.postalCode: TextInputType.name,
              AutofillHints.streetAddressLine1: TextInputType.name,
              AutofillHints.streetAddressLine2: TextInputType.name,
              // Autofill not working.
              AutofillHints.sublocality: TextInputType.name,
              // Autofill not working.
              AutofillHints.telephoneNumber: TextInputType.name,
              AutofillHints.url: TextInputType.url,
              // Autofill not working.
              AutofillHints.username: TextInputType.text,
            };

            final TextInputType? keyboardType = iOSKeyboardType[effectiveHint];
            if (keyboardType != null) {
              return keyboardType;
            }
            break;
          }
        case TargetPlatform.android:
        case TargetPlatform.fuchsia:
        case TargetPlatform.linux:
        case TargetPlatform.windows:
          break;
      }
    }

    if (maxLines != 1) {
      return TextInputType.multiline;
    }

    const Map<String, TextInputType> inferKeyboardType =
        <String, TextInputType>{
      AutofillHints.addressCity: TextInputType.streetAddress,
      AutofillHints.addressCityAndState: TextInputType.streetAddress,
      AutofillHints.addressState: TextInputType.streetAddress,
      AutofillHints.birthday: TextInputType.datetime,
      AutofillHints.birthdayDay: TextInputType.datetime,
      AutofillHints.birthdayMonth: TextInputType.datetime,
      AutofillHints.birthdayYear: TextInputType.datetime,
      AutofillHints.countryCode: TextInputType.number,
      AutofillHints.countryName: TextInputType.text,
      AutofillHints.creditCardExpirationDate: TextInputType.datetime,
      AutofillHints.creditCardExpirationDay: TextInputType.datetime,
      AutofillHints.creditCardExpirationMonth: TextInputType.datetime,
      AutofillHints.creditCardExpirationYear: TextInputType.datetime,
      AutofillHints.creditCardFamilyName: TextInputType.name,
      AutofillHints.creditCardGivenName: TextInputType.name,
      AutofillHints.creditCardMiddleName: TextInputType.name,
      AutofillHints.creditCardName: TextInputType.name,
      AutofillHints.creditCardNumber: TextInputType.number,
      AutofillHints.creditCardSecurityCode: TextInputType.number,
      AutofillHints.creditCardType: TextInputType.text,
      AutofillHints.email: TextInputType.emailAddress,
      AutofillHints.familyName: TextInputType.name,
      AutofillHints.fullStreetAddress: TextInputType.streetAddress,
      AutofillHints.gender: TextInputType.text,
      AutofillHints.givenName: TextInputType.name,
      AutofillHints.impp: TextInputType.url,
      AutofillHints.jobTitle: TextInputType.text,
      AutofillHints.language: TextInputType.text,
      AutofillHints.location: TextInputType.streetAddress,
      AutofillHints.middleInitial: TextInputType.name,
      AutofillHints.middleName: TextInputType.name,
      AutofillHints.name: TextInputType.name,
      AutofillHints.namePrefix: TextInputType.name,
      AutofillHints.nameSuffix: TextInputType.name,
      AutofillHints.newPassword: TextInputType.text,
      AutofillHints.newUsername: TextInputType.text,
      AutofillHints.nickname: TextInputType.text,
      AutofillHints.oneTimeCode: TextInputType.text,
      AutofillHints.organizationName: TextInputType.text,
      AutofillHints.password: TextInputType.text,
      AutofillHints.photo: TextInputType.text,
      AutofillHints.postalAddress: TextInputType.streetAddress,
      AutofillHints.postalAddressExtended: TextInputType.streetAddress,
      AutofillHints.postalAddressExtendedPostalCode: TextInputType.number,
      AutofillHints.postalCode: TextInputType.number,
      AutofillHints.streetAddressLevel1: TextInputType.streetAddress,
      AutofillHints.streetAddressLevel2: TextInputType.streetAddress,
      AutofillHints.streetAddressLevel3: TextInputType.streetAddress,
      AutofillHints.streetAddressLevel4: TextInputType.streetAddress,
      AutofillHints.streetAddressLine1: TextInputType.streetAddress,
      AutofillHints.streetAddressLine2: TextInputType.streetAddress,
      AutofillHints.streetAddressLine3: TextInputType.streetAddress,
      AutofillHints.sublocality: TextInputType.streetAddress,
      AutofillHints.telephoneNumber: TextInputType.phone,
      AutofillHints.telephoneNumberAreaCode: TextInputType.phone,
      AutofillHints.telephoneNumberCountryCode: TextInputType.phone,
      AutofillHints.telephoneNumberDevice: TextInputType.phone,
      AutofillHints.telephoneNumberExtension: TextInputType.phone,
      AutofillHints.telephoneNumberLocal: TextInputType.phone,
      AutofillHints.telephoneNumberLocalPrefix: TextInputType.phone,
      AutofillHints.telephoneNumberLocalSuffix: TextInputType.phone,
      AutofillHints.telephoneNumberNational: TextInputType.phone,
      AutofillHints.transactionAmount:
          TextInputType.numberWithOptions(decimal: true),
      AutofillHints.transactionCurrency: TextInputType.text,
      AutofillHints.url: TextInputType.url,
      AutofillHints.username: TextInputType.text,
    };

    return inferKeyboardType[effectiveHint] ?? TextInputType.text;
  }

  @override
  EditableTextState createState() => EditableTextState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
        DiagnosticsProperty<TextEditingController>('controller', controller));
    properties.add(DiagnosticsProperty<FocusNode>('focusNode', focusNode));
    properties.add(DiagnosticsProperty<bool>('obscureText', obscureText,
        defaultValue: false));
    properties.add(
        DiagnosticsProperty<bool>('readOnly', readOnly, defaultValue: false));
    properties.add(DiagnosticsProperty<bool>('autocorrect', autocorrect,
        defaultValue: true));
    properties.add(EnumProperty<SmartDashesType>(
        'smartDashesType', smartDashesType,
        defaultValue:
            obscureText ? SmartDashesType.disabled : SmartDashesType.enabled));
    properties.add(EnumProperty<SmartQuotesType>(
        'smartQuotesType', smartQuotesType,
        defaultValue:
            obscureText ? SmartQuotesType.disabled : SmartQuotesType.enabled));
    properties.add(DiagnosticsProperty<bool>(
        'enableSuggestions', enableSuggestions,
        defaultValue: true));
    style.debugFillProperties(properties);
    properties.add(
        EnumProperty<TextAlign>('textAlign', textAlign, defaultValue: null));
    properties.add(EnumProperty<TextDirection>('textDirection', textDirection,
        defaultValue: null));
    properties
        .add(DiagnosticsProperty<Locale>('locale', locale, defaultValue: null));
    properties.add(
        DoubleProperty('textScaleFactor', textScaleFactor, defaultValue: null));
    properties.add(IntProperty('maxLines', maxLines, defaultValue: 1));
    properties.add(IntProperty('minLines', minLines, defaultValue: null));
    properties.add(
        DiagnosticsProperty<bool>('expands', expands, defaultValue: false));
    properties.add(
        DiagnosticsProperty<bool>('autofocus', autofocus, defaultValue: false));
    properties.add(DiagnosticsProperty<TextInputType>(
        'keyboardType', keyboardType,
        defaultValue: null));
    properties.add(DiagnosticsProperty<ScrollController>(
        'scrollController', scrollController,
        defaultValue: null));
    properties.add(DiagnosticsProperty<ScrollPhysics>(
        'scrollPhysics', scrollPhysics,
        defaultValue: null));
    properties.add(DiagnosticsProperty<Iterable<String>>(
        'autofillHints', autofillHints,
        defaultValue: null));
    properties.add(DiagnosticsProperty<TextHeightBehavior>(
        'textHeightBehavior', textHeightBehavior,
        defaultValue: null));
    properties.add(DiagnosticsProperty<bool>('scribbleEnabled', scribbleEnabled,
        defaultValue: true));
    properties.add(DiagnosticsProperty<bool>(
        'enableIMEPersonalizedLearning', enableIMEPersonalizedLearning,
        defaultValue: true));
    properties.add(DiagnosticsProperty<bool>(
        'enableInteractiveSelection', enableInteractiveSelection,
        defaultValue: true));
    properties.add(DiagnosticsProperty<SpellCheckConfiguration>(
        'spellCheckConfiguration', spellCheckConfiguration,
        defaultValue: null));
  }
}

class EditableTextState extends State<EditableText>
    with
        AutomaticKeepAliveClientMixin<EditableText>,
        WidgetsBindingObserver,
        TickerProviderStateMixin<EditableText>,
        TextSelectionDelegate,
        TextInputClient
    implements AutofillClient {
  Timer? _cursorTimer;

  AnimationController get _cursorBlinkOpacityController {
    return _backingCursorBlinkOpacityController ??= AnimationController(
      vsync: this,
    )..addListener(_onCursorColorTick);
  }

  AnimationController? _backingCursorBlinkOpacityController;
  late final Simulation _iosBlinkCursorSimulation =
      _DiscreteKeyFrameSimulation.iOSBlinkingCaret();

  final ValueNotifier<bool> _cursorVisibilityNotifier =
      ValueNotifier<bool>(true);
  final GlobalKey _editableKey = GlobalKey();

  final ClipboardStatusNotifier? clipboardStatus =
      kIsWeb ? null : ClipboardStatusNotifier();

  TextInputConnection? _textInputConnection;

  bool get _hasInputConnection => _textInputConnection?.attached ?? false;

  TextSelectionOverlay? _selectionOverlay;

  final GlobalKey _scrollableKey = GlobalKey();
  ScrollController? _internalScrollController;

  ScrollController get _scrollController =>
      widget.scrollController ??
      (_internalScrollController ??= ScrollController());

  final LayerLink _toolbarLayerLink = LayerLink();
  final LayerLink _startHandleLayerLink = LayerLink();
  final LayerLink _endHandleLayerLink = LayerLink();

  bool _didAutoFocus = false;

  AutofillGroupState? _currentAutofillScope;

  @override
  AutofillScope? get currentAutofillScope => _currentAutofillScope;

  AutofillClient get _effectiveAutofillClient => widget.autofillClient ?? this;

  late SpellCheckConfiguration _spellCheckConfiguration;

  @visibleForTesting
  SpellCheckConfiguration get spellCheckConfiguration =>
      _spellCheckConfiguration;

  bool get spellCheckEnabled => _spellCheckConfiguration.spellCheckEnabled;

  SpellCheckResults? _spellCheckResults;

  bool get _shouldCreateInputConnection => kIsWeb || !widget.readOnly;

  // The time it takes for the floating cursor to snap to the text aligned
  // cursor position after the user has finished placing it.
  static const Duration _floatingCursorResetTime = Duration(milliseconds: 125);

  AnimationController? _floatingCursorResetController;

  Orientation? _lastOrientation;

  @override
  bool get wantKeepAlive => widget.focusNode.hasFocus;

  Color get _cursorColor =>
      widget.cursorColor.withOpacity(_cursorBlinkOpacityController.value);

  @override
  bool get cutEnabled {
    if (widget.selectionControls is! TextSelectionHandleControls) {
      return widget.toolbarOptions.cut &&
          !widget.readOnly &&
          !widget.obscureText;
    }
    return !widget.readOnly &&
        !widget.obscureText &&
        !textEditingValue.selection.isCollapsed;
  }

  @override
  bool get copyEnabled {
    if (widget.selectionControls is! TextSelectionHandleControls) {
      return widget.toolbarOptions.copy && !widget.obscureText;
    }
    return !widget.obscureText && !textEditingValue.selection.isCollapsed;
  }

  @override
  bool get pasteEnabled {
    if (widget.selectionControls is! TextSelectionHandleControls) {
      return widget.toolbarOptions.paste && !widget.readOnly;
    }
    return !widget.readOnly &&
        (clipboardStatus == null ||
            clipboardStatus!.value == ClipboardStatus.pasteable);
  }

  @override
  bool get selectAllEnabled {
    if (widget.selectionControls is! TextSelectionHandleControls) {
      return widget.toolbarOptions.selectAll &&
          (!widget.readOnly || !widget.obscureText) &&
          widget.enableInteractiveSelection;
    }

    if (!widget.enableInteractiveSelection ||
        (widget.readOnly && widget.obscureText)) {
      return false;
    }

    switch (defaultTargetPlatform) {
      case TargetPlatform.macOS:
        return false;
      case TargetPlatform.iOS:
        return textEditingValue.text.isNotEmpty &&
            textEditingValue.selection.isCollapsed;
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return textEditingValue.text.isNotEmpty &&
            !(textEditingValue.selection.start == 0 &&
                textEditingValue.selection.end == textEditingValue.text.length);
    }
  }

  void _onChangedClipboardStatus() {
    setState(() {
      // Inform the widget that the value of clipboardStatus has changed.
    });
  }

  TextEditingValue get _textEditingValueforTextLayoutMetrics {
    final Widget? editableWidget = _editableKey.currentContext?.widget;
    if (editableWidget is! _Editable) {
      throw StateError('_Editable must be mounted.');
    }
    return editableWidget.value;
  }

  @override
  void copySelection(SelectionChangedCause cause) {
    final TextSelection selection = textEditingValue.selection;
    assert(selection != null);
    if (selection.isCollapsed || widget.obscureText) {
      return;
    }
    final String text = textEditingValue.text;
    Clipboard.setData(ClipboardData(text: selection.textInside(text)));
    if (cause == SelectionChangedCause.toolbar) {
      bringIntoView(textEditingValue.selection.extent);
      hideToolbar(false);

      switch (defaultTargetPlatform) {
        case TargetPlatform.iOS:
        case TargetPlatform.macOS:
        case TargetPlatform.linux:
        case TargetPlatform.windows:
          break;
        case TargetPlatform.android:
        case TargetPlatform.fuchsia:
          // Collapse the selection and hide the toolbar and handles.
          userUpdateTextEditingValue(
            TextEditingValue(
              text: textEditingValue.text,
              selection: TextSelection.collapsed(
                  offset: textEditingValue.selection.end),
            ),
            SelectionChangedCause.toolbar,
          );
          break;
      }
    }
    clipboardStatus?.update();
  }

  @override
  void cutSelection(SelectionChangedCause cause) {
    if (widget.readOnly || widget.obscureText) {
      return;
    }
    final TextSelection selection = textEditingValue.selection;
    final String text = textEditingValue.text;
    assert(selection != null);
    if (selection.isCollapsed) {
      return;
    }
    Clipboard.setData(ClipboardData(text: selection.textInside(text)));
    _replaceText(ReplaceTextIntent(textEditingValue, '', selection, cause));
    if (cause == SelectionChangedCause.toolbar) {
      // Schedule a call to bringIntoView() after renderEditable updates.
      SchedulerBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          bringIntoView(textEditingValue.selection.extent);
        }
      });
      hideToolbar();
    }
    clipboardStatus?.update();
  }

  @override
  Future<void> pasteText(SelectionChangedCause cause) async {
    if (widget.readOnly) {
      return;
    }
    final TextSelection selection = textEditingValue.selection;
    assert(selection != null);
    if (!selection.isValid) {
      return;
    }
    // Snapshot the input before using `await`.
    // See https://github.com/flutter/flutter/issues/11427
    final ClipboardData? data = await Clipboard.getData(Clipboard.kTextPlain);
    if (data == null) {
      return;
    }

    // After the paste, the cursor should be collapsed and located after the
    // pasted content.
    final int lastSelectionIndex =
        math.max(selection.baseOffset, selection.extentOffset);
    final TextEditingValue collapsedTextEditingValue =
        textEditingValue.copyWith(
      selection: TextSelection.collapsed(offset: lastSelectionIndex),
    );

    userUpdateTextEditingValue(
      collapsedTextEditingValue.replaced(selection, data.text!),
      cause,
    );
    if (cause == SelectionChangedCause.toolbar) {
      // Schedule a call to bringIntoView() after renderEditable updates.
      SchedulerBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          bringIntoView(textEditingValue.selection.extent);
        }
      });
      hideToolbar();
    }
  }

  @override
  void selectAll(SelectionChangedCause cause) {
    if (widget.readOnly && widget.obscureText) {
      // If we can't modify it, and we can't copy it, there's no point in
      // selecting it.
      return;
    }
    userUpdateTextEditingValue(
      textEditingValue.copyWith(
        selection: TextSelection(
            baseOffset: 0, extentOffset: textEditingValue.text.length),
      ),
      cause,
    );

    if (cause == SelectionChangedCause.toolbar) {
      switch (defaultTargetPlatform) {
        case TargetPlatform.android:
        case TargetPlatform.iOS:
        case TargetPlatform.fuchsia:
          break;
        case TargetPlatform.macOS:
        case TargetPlatform.linux:
        case TargetPlatform.windows:
          hideToolbar();
      }
      switch (defaultTargetPlatform) {
        case TargetPlatform.android:
        case TargetPlatform.fuchsia:
        case TargetPlatform.linux:
        case TargetPlatform.windows:
          bringIntoView(textEditingValue.selection.extent);
          break;
        case TargetPlatform.macOS:
        case TargetPlatform.iOS:
          break;
      }
    }
  }

  static SpellCheckConfiguration _inferSpellCheckConfiguration(
      SpellCheckConfiguration? configuration) {
    if (configuration == null ||
        configuration == const SpellCheckConfiguration.disabled()) {
      return const SpellCheckConfiguration.disabled();
    }

    SpellCheckService? spellCheckService = configuration.spellCheckService;

    assert(
      spellCheckService != null ||
          WidgetsBinding
              .instance.platformDispatcher.nativeSpellCheckServiceDefined,
      'spellCheckService must be specified for this platform because no default service available',
    );

    spellCheckService = spellCheckService ?? DefaultSpellCheckService();

    return configuration.copyWith(spellCheckService: spellCheckService);
  }

  @Deprecated(
    'Use `contextMenuBuilder` instead of `toolbarOptions`. '
    'This feature was deprecated after v3.3.0-0.5.pre.',
  )
  List<ContextMenuButtonItem>? buttonItemsForToolbarOptions(
      [TargetPlatform? targetPlatform]) {
    final ToolbarOptions toolbarOptions = widget.toolbarOptions;
    if (toolbarOptions == ToolbarOptions.empty) {
      return null;
    }
    return <ContextMenuButtonItem>[
      if (toolbarOptions.cut && cutEnabled)
        ContextMenuButtonItem(
          onPressed: () {
            selectAll(SelectionChangedCause.toolbar);
          },
          type: ContextMenuButtonType.selectAll,
        ),
      if (toolbarOptions.copy && copyEnabled)
        ContextMenuButtonItem(
          onPressed: () {
            copySelection(SelectionChangedCause.toolbar);
          },
          type: ContextMenuButtonType.copy,
        ),
      if (toolbarOptions.paste && clipboardStatus != null && pasteEnabled)
        ContextMenuButtonItem(
          onPressed: () {
            pasteText(SelectionChangedCause.toolbar);
          },
          type: ContextMenuButtonType.paste,
        ),
      if (toolbarOptions.selectAll && selectAllEnabled)
        ContextMenuButtonItem(
          onPressed: () {
            selectAll(SelectionChangedCause.toolbar);
          },
          type: ContextMenuButtonType.selectAll,
        ),
    ];
  }

  _GlyphHeights _getGlyphHeights() {
    final TextSelection selection = textEditingValue.selection;

    // Only calculate handle rects if the text in the previous frame
    // is the same as the text in the current frame. This is done because
    // widget.renderObject contains the renderEditable from the previous frame.
    // If the text changed between the current and previous frames then
    // widget.renderObject.getRectForComposingRange might fail. In cases where
    // the current frame is different from the previous we fall back to
    // renderObject.preferredLineHeight.
    final InlineSpan span = renderEditable.text!;
    final String prevText = span.toPlainText();
    final String currText = textEditingValue.text;
    if (prevText != currText ||
        selection == null ||
        !selection.isValid ||
        selection.isCollapsed) {
      return _GlyphHeights(
        start: renderEditable.preferredLineHeight,
        end: renderEditable.preferredLineHeight,
      );
    }

    final String selectedGraphemes = selection.textInside(currText);
    final int firstSelectedGraphemeExtent =
        selectedGraphemes.characters.first.length;
    final Rect? startCharacterRect =
        renderEditable.getRectForComposingRange(TextRange(
      start: selection.start,
      end: selection.start + firstSelectedGraphemeExtent,
    ));
    final int lastSelectedGraphemeExtent =
        selectedGraphemes.characters.last.length;
    final Rect? endCharacterRect =
        renderEditable.getRectForComposingRange(TextRange(
      start: selection.end - lastSelectedGraphemeExtent,
      end: selection.end,
    ));
    return _GlyphHeights(
      start: startCharacterRect?.height ?? renderEditable.preferredLineHeight,
      end: endCharacterRect?.height ?? renderEditable.preferredLineHeight,
    );
  }

  TextSelectionToolbarAnchors get contextMenuAnchors {
    if (renderEditable.lastSecondaryTapDownPosition != null) {
      return TextSelectionToolbarAnchors(
        primaryAnchor: renderEditable.lastSecondaryTapDownPosition!,
      );
    }

    final _GlyphHeights glyphHeights = _getGlyphHeights();
    final TextSelection selection = textEditingValue.selection;
    final List<TextSelectionPoint> points =
        renderEditable.getEndpointsForSelection(selection);
    return TextSelectionToolbarAnchors.fromSelection(
      renderBox: renderEditable,
      startGlyphHeight: glyphHeights.start,
      endGlyphHeight: glyphHeights.end,
      selectionEndpoints: points,
    );
  }

  List<ContextMenuButtonItem> get contextMenuButtonItems {
    return buttonItemsForToolbarOptions() ??
        EditableText.getEditableButtonItems(
          clipboardStatus: clipboardStatus?.value,
          onCopy: copyEnabled
              ? () => copySelection(SelectionChangedCause.toolbar)
              : null,
          onCut: cutEnabled
              ? () => cutSelection(SelectionChangedCause.toolbar)
              : null,
          onPaste: pasteEnabled
              ? () => pasteText(SelectionChangedCause.toolbar)
              : null,
          onSelectAll: selectAllEnabled
              ? () => selectAll(SelectionChangedCause.toolbar)
              : null,
        );
  }

  // State lifecycle:

  @override
  void initState() {
    super.initState();
    clipboardStatus?.addListener(_onChangedClipboardStatus);
    widget.controller.addListener(_didChangeTextEditingValue);
    widget.focusNode.addListener(_handleFocusChanged);
    _scrollController.addListener(_onEditableScroll);
    _cursorVisibilityNotifier.value = widget.showCursor;
    _spellCheckConfiguration =
        _inferSpellCheckConfiguration(widget.spellCheckConfiguration);
  }

  // Whether `TickerMode.of(context)` is true and animations (like blinking the
  // cursor) are supposed to run.
  bool _tickersEnabled = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final AutofillGroupState? newAutofillGroup = AutofillGroup.maybeOf(context);
    if (currentAutofillScope != newAutofillGroup) {
      _currentAutofillScope?.unregister(autofillId);
      _currentAutofillScope = newAutofillGroup;
      _currentAutofillScope?.register(_effectiveAutofillClient);
    }

    if (!_didAutoFocus && widget.autofocus) {
      _didAutoFocus = true;
      SchedulerBinding.instance.addPostFrameCallback((_) {
        if (mounted && renderEditable.hasSize) {
          FocusScope.of(context).autofocus(widget.focusNode);
        }
      });
    }

    // Restart or stop the blinking cursor when TickerMode changes.
    final bool newTickerEnabled = TickerMode.of(context);
    if (_tickersEnabled != newTickerEnabled) {
      _tickersEnabled = newTickerEnabled;
      if (_tickersEnabled && _cursorActive) {
        _startCursorBlink();
      } else if (!_tickersEnabled && _cursorTimer != null) {
        // Cannot use _stopCursorTimer because it would reset _cursorActive.
        _cursorTimer!.cancel();
        _cursorTimer = null;
      }
    }

    if (defaultTargetPlatform != TargetPlatform.iOS &&
        defaultTargetPlatform != TargetPlatform.android) {
      return;
    }

    // Hide the text selection toolbar on mobile when orientation changes.
    final Orientation orientation = MediaQuery.of(context).orientation;
    if (_lastOrientation == null) {
      _lastOrientation = orientation;
      return;
    }
    if (orientation != _lastOrientation) {
      _lastOrientation = orientation;
      if (defaultTargetPlatform == TargetPlatform.iOS) {
        hideToolbar(false);
      }
      if (defaultTargetPlatform == TargetPlatform.android) {
        hideToolbar();
      }
    }
  }

  @override
  void didUpdateWidget(EditableText oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller.removeListener(_didChangeTextEditingValue);
      widget.controller.addListener(_didChangeTextEditingValue);
      _updateRemoteEditingValueIfNeeded();
    }
    if (widget.controller.selection != oldWidget.controller.selection) {
      _selectionOverlay?.update(_value);
    }
    _selectionOverlay?.handlesVisible = widget.showSelectionHandles;

    if (widget.autofillClient != oldWidget.autofillClient) {
      _currentAutofillScope
          ?.unregister(oldWidget.autofillClient?.autofillId ?? autofillId);
      _currentAutofillScope?.register(_effectiveAutofillClient);
    }

    if (widget.focusNode != oldWidget.focusNode) {
      oldWidget.focusNode.removeListener(_handleFocusChanged);
      widget.focusNode.addListener(_handleFocusChanged);
      updateKeepAlive();
    }

    if (widget.scrollController != oldWidget.scrollController) {
      (oldWidget.scrollController ?? _internalScrollController)
          ?.removeListener(_onEditableScroll);
      _scrollController.addListener(_onEditableScroll);
    }

    if (!_shouldCreateInputConnection) {
      _closeInputConnectionIfNeeded();
    } else if (oldWidget.readOnly && _hasFocus) {
      _openInputConnection();
    }

    if (kIsWeb && _hasInputConnection) {
      if (oldWidget.readOnly != widget.readOnly) {
        _textInputConnection!
            .updateConfig(_effectiveAutofillClient.textInputConfiguration);
      }
    }

    if (widget.style != oldWidget.style) {
      final TextStyle style = widget.style;
      // The _textInputConnection will pick up the new style when it attaches in
      // _openInputConnection.
      if (_hasInputConnection) {
        _textInputConnection!.setStyle(
          fontFamily: style.fontFamily,
          fontSize: style.fontSize,
          fontWeight: style.fontWeight,
          textDirection: _textDirection,
          textAlign: widget.textAlign,
        );
      }
    }
    final bool canPaste =
        widget.selectionControls is TextSelectionHandleControls
            ? pasteEnabled
            : widget.selectionControls?.canPaste(this) ?? false;
    if (widget.selectionEnabled &&
        pasteEnabled &&
        clipboardStatus != null &&
        canPaste) {
      clipboardStatus!.update();
    }
  }

  @override
  void dispose() {
    _internalScrollController?.dispose();
    _currentAutofillScope?.unregister(autofillId);
    widget.controller.removeListener(_didChangeTextEditingValue);
    _floatingCursorResetController?.dispose();
    _floatingCursorResetController = null;
    _closeInputConnectionIfNeeded();
    assert(!_hasInputConnection);
    _cursorTimer?.cancel();
    _cursorTimer = null;
    _backingCursorBlinkOpacityController?.dispose();
    _backingCursorBlinkOpacityController = null;
    _selectionOverlay?.dispose();
    _selectionOverlay = null;
    widget.focusNode.removeListener(_handleFocusChanged);
    WidgetsBinding.instance.removeObserver(this);
    clipboardStatus?.removeListener(_onChangedClipboardStatus);
    clipboardStatus?.dispose();
    _cursorVisibilityNotifier.dispose();
    super.dispose();
    assert(_batchEditDepth <= 0, 'unfinished batch edits: $_batchEditDepth');
  }

  // TextInputClient implementation:

  TextEditingValue? _lastKnownRemoteTextEditingValue;

  @override
  TextEditingValue get currentTextEditingValue => _value;

  @override
  void updateEditingValue(TextEditingValue value) {
    // This method handles text editing state updates from the platform text
    // input plugin. The [EditableText] may not have the focus or an open input
    // connection, as autofill can update a disconnected [EditableText].

    // Since we still have to support keyboard select, this is the best place
    // to disable text updating.
    if (!_shouldCreateInputConnection) {
      return;
    }

    if (_checkNeedsAdjustAffinity(value)) {
      value = value.copyWith(
          selection:
              value.selection.copyWith(affinity: _value.selection.affinity));
    }

    if (widget.readOnly) {
      // In the read-only case, we only care about selection changes, and reject
      // everything else.
      value = _value.copyWith(selection: value.selection);
    }
    _lastKnownRemoteTextEditingValue = value;

    if (value == _value) {
      // This is possible, for example, when the numeric keyboard is input,
      // the engine will notify twice for the same value.
      // Track at https://github.com/flutter/flutter/issues/65811
      return;
    }

    if (value.text == _value.text && value.composing == _value.composing) {
      // `selection` is the only change.
      _handleSelectionChanged(
          value.selection,
          (_textInputConnection?.scribbleInProgress ?? false)
              ? SelectionChangedCause.scribble
              : SelectionChangedCause.keyboard);
    } else {
      // Only hide the toolbar overlay, the selection handle's visibility will be handled
      // by `_handleSelectionChanged`. https://github.com/flutter/flutter/issues/108673
      hideToolbar(false);
      _currentPromptRectRange = null;

      final bool revealObscuredInput = _hasInputConnection &&
          widget.obscureText &&
          WidgetsBinding.instance.platformDispatcher.brieflyShowPassword &&
          value.text.length == _value.text.length + 1;

      _obscureShowCharTicksPending =
          revealObscuredInput ? _kObscureShowLatestCharCursorTicks : 0;
      _obscureLatestCharIndex =
          revealObscuredInput ? _value.selection.baseOffset : null;
      _formatAndSetValue(value, SelectionChangedCause.keyboard);
    }

    // Wherever the value is changed by the user, schedule a showCaretOnScreen
    // to make sure the user can see the changes they just made. Programmatical
    // changes to `textEditingValue` do not trigger the behavior even if the
    // text field is focused.
    _scheduleShowCaretOnScreen(withAnimation: true);
    if (_hasInputConnection) {
      // To keep the cursor from blinking while typing, we want to restart the
      // cursor timer every time a new character is typed.
      _stopCursorBlink(resetCharTicks: false);
      _startCursorBlink();
    }
  }

  bool _checkNeedsAdjustAffinity(TextEditingValue value) {
    // Trust the engine affinity if the text changes or selection changes.
    return value.text == _value.text &&
        value.selection.isCollapsed == _value.selection.isCollapsed &&
        value.selection.start == _value.selection.start &&
        value.selection.affinity != _value.selection.affinity;
  }

  @override
  void performAction(TextInputAction action) {
    switch (action) {
      case TextInputAction.newline:
        // If this is a multiline EditableText, do nothing for a "newline"
        // action; The newline is already inserted. Otherwise, finalize
        // editing.
        if (!_isMultiline) {
          _finalizeEditing(action, shouldUnfocus: true);
        }
        break;
      case TextInputAction.done:
      case TextInputAction.go:
      case TextInputAction.next:
      case TextInputAction.previous:
      case TextInputAction.search:
      case TextInputAction.send:
        _finalizeEditing(action, shouldUnfocus: true);
        break;
      case TextInputAction.continueAction:
      case TextInputAction.emergencyCall:
      case TextInputAction.join:
      case TextInputAction.none:
      case TextInputAction.route:
      case TextInputAction.unspecified:
        // Finalize editing, but don't give up focus because this keyboard
        // action does not imply the user is done inputting information.
        _finalizeEditing(action, shouldUnfocus: false);
        break;
    }
  }

  @override
  void performPrivateCommand(String action, Map<String, dynamic> data) {
    widget.onAppPrivateCommand?.call(action, data);
  }

  // The original position of the caret on FloatingCursorDragState.start.
  Rect? _startCaretRect;

  // The most recent text position as determined by the location of the floating
  // cursor.
  TextPosition? _lastTextPosition;

  // The offset of the floating cursor as determined from the start call.
  Offset? _pointOffsetOrigin;

  // The most recent position of the floating cursor.
  Offset? _lastBoundedOffset;

  // Because the center of the cursor is preferredLineHeight / 2 below the touch
  // origin, but the touch origin is used to determine which line the cursor is
  // on, we need this offset to correctly render and move the cursor.
  Offset get _floatingCursorOffset =>
      Offset(0, renderEditable.preferredLineHeight / 2);

  @override
  void updateFloatingCursor(RawFloatingCursorPoint point) {
    _floatingCursorResetController ??= AnimationController(
      vsync: this,
    )..addListener(_onFloatingCursorResetTick);
    switch (point.state) {
      case FloatingCursorDragState.Start:
        {
          if (_floatingCursorResetController!.isAnimating) {
            _floatingCursorResetController!.stop();
            _onFloatingCursorResetTick();
          }
          // Stop cursor blinking and making it visible.
          _stopCursorBlink(resetCharTicks: false);
          _cursorBlinkOpacityController.value = 1.0;
          // We want to send in points that are centered around a (0,0) origin, so
          // we cache the position.
          _pointOffsetOrigin = point.offset;

          final TextPosition currentTextPosition =
              TextPosition(offset: renderEditable.selection!.baseOffset);
          _startCaretRect =
              renderEditable.getLocalRectForCaret(currentTextPosition);

          _lastBoundedOffset = _startCaretRect!.center - _floatingCursorOffset;
          _lastTextPosition = currentTextPosition;
          renderEditable.setFloatingCursor(
              point.state, _lastBoundedOffset!, _lastTextPosition!);
          break;
        }
      case FloatingCursorDragState.Update:
        {
          final Offset centeredPoint = point.offset! - _pointOffsetOrigin!;
          final Offset rawCursorOffset =
              _startCaretRect!.center + centeredPoint - _floatingCursorOffset;

          _lastBoundedOffset = renderEditable
              .calculateBoundedFloatingCursorOffset(rawCursorOffset);
          _lastTextPosition = renderEditable.getPositionForPoint(renderEditable
              .localToGlobal(_lastBoundedOffset! + _floatingCursorOffset));
          renderEditable.setFloatingCursor(
              point.state, _lastBoundedOffset!, _lastTextPosition!);
          break;
        }
      case FloatingCursorDragState.End:
        {
          // Resume cursor blinking.
          _startCursorBlink();
          // We skip animation if no update has happened.
          if (_lastTextPosition != null && _lastBoundedOffset != null) {
            _floatingCursorResetController!.value = 0.0;
            _floatingCursorResetController!.animateTo(1.0,
                duration: _floatingCursorResetTime, curve: Curves.decelerate);
          }
        }
        break;
    }
  }

  void _onFloatingCursorResetTick() {
    final Offset finalPosition =
        renderEditable.getLocalRectForCaret(_lastTextPosition!).centerLeft -
            _floatingCursorOffset;
    if (_floatingCursorResetController!.isCompleted) {
      renderEditable.setFloatingCursor(
          FloatingCursorDragState.End, finalPosition, _lastTextPosition!);
      if (_lastTextPosition!.offset != renderEditable.selection!.baseOffset) {
        // The cause is technically the force cursor, but the cause is listed as tap as the desired functionality is the same.
        _handleSelectionChanged(
            TextSelection.collapsed(offset: _lastTextPosition!.offset),
            SelectionChangedCause.forcePress);
      }
      _startCaretRect = null;
      _lastTextPosition = null;
      _pointOffsetOrigin = null;
      _lastBoundedOffset = null;
    } else {
      final double lerpValue = _floatingCursorResetController!.value;
      final double lerpX =
          ui.lerpDouble(_lastBoundedOffset!.dx, finalPosition.dx, lerpValue)!;
      final double lerpY =
          ui.lerpDouble(_lastBoundedOffset!.dy, finalPosition.dy, lerpValue)!;

      renderEditable.setFloatingCursor(FloatingCursorDragState.Update,
          Offset(lerpX, lerpY), _lastTextPosition!,
          resetLerpValue: lerpValue);
    }
  }

  @pragma('vm:notify-debugger-on-exception')
  void _finalizeEditing(TextInputAction action, {required bool shouldUnfocus}) {
    // Take any actions necessary now that the user has completed editing.
    if (widget.onEditingComplete != null) {
      try {
        widget.onEditingComplete!();
      } catch (exception, stack) {
        FlutterError.reportError(FlutterErrorDetails(
          exception: exception,
          stack: stack,
          library: 'widgets',
          context:
              ErrorDescription('while calling onEditingComplete for $action'),
        ));
      }
    } else {
      // Default behavior if the developer did not provide an
      // onEditingComplete callback: Finalize editing and remove focus, or move
      // it to the next/previous field, depending on the action.
      widget.controller.clearComposing();
      if (shouldUnfocus) {
        switch (action) {
          case TextInputAction.none:
          case TextInputAction.unspecified:
          case TextInputAction.done:
          case TextInputAction.go:
          case TextInputAction.search:
          case TextInputAction.send:
          case TextInputAction.continueAction:
          case TextInputAction.join:
          case TextInputAction.route:
          case TextInputAction.emergencyCall:
          case TextInputAction.newline:
            widget.focusNode.unfocus();
            break;
          case TextInputAction.next:
            widget.focusNode.nextFocus();
            break;
          case TextInputAction.previous:
            widget.focusNode.previousFocus();
            break;
        }
      }
    }

    final ValueChanged<String>? onSubmitted = widget.onSubmitted;
    if (onSubmitted == null) {
      return;
    }

    // Invoke optional callback with the user's submitted content.
    try {
      onSubmitted(_value.text);
    } catch (exception, stack) {
      FlutterError.reportError(FlutterErrorDetails(
        exception: exception,
        stack: stack,
        library: 'widgets',
        context: ErrorDescription('while calling onSubmitted for $action'),
      ));
    }

    // If `shouldUnfocus` is true, the text field should no longer be focused
    // after the microtask queue is drained. But in case the developer cancelled
    // the focus change in the `onSubmitted` callback by focusing this input
    // field again, reset the soft keyboard.
    // See https://github.com/flutter/flutter/issues/84240.
    //
    // `_restartConnectionIfNeeded` creates a new TextInputConnection to replace
    // the current one. This on iOS switches to a new input view and on Android
    // restarts the input method, and in both cases the soft keyboard will be
    // reset.
    if (shouldUnfocus) {
      _scheduleRestartConnection();
    }
  }

  int _batchEditDepth = 0;

  void beginBatchEdit() {
    _batchEditDepth += 1;
  }

  void endBatchEdit() {
    _batchEditDepth -= 1;
    assert(
      _batchEditDepth >= 0,
      'Unbalanced call to endBatchEdit: beginBatchEdit must be called first.',
    );
    _updateRemoteEditingValueIfNeeded();
  }

  void _updateRemoteEditingValueIfNeeded() {
    if (_batchEditDepth > 0 || !_hasInputConnection) {
      return;
    }
    final TextEditingValue localValue = _value;
    if (localValue == _lastKnownRemoteTextEditingValue) {
      return;
    }
    _textInputConnection!.setEditingState(localValue);
    _lastKnownRemoteTextEditingValue = localValue;
  }

  TextEditingValue get _value => widget.controller.value;

  set _value(TextEditingValue value) {
    widget.controller.value = value;
  }

  bool get _hasFocus => widget.focusNode.hasFocus;

  bool get _isMultiline => widget.maxLines != 1;

  // Finds the closest scroll offset to the current scroll offset that fully
  // reveals the given caret rect. If the given rect's main axis extent is too
  // large to be fully revealed in `renderEditable`, it will be centered along
  // the main axis.
  //
  // If this is a multiline EditableText (which means the Editable can only
  // scroll vertically), the given rect's height will first be extended to match
  // `renderEditable.preferredLineHeight`, before the target scroll offset is
  // calculated.
  RevealedOffset _getOffsetToRevealCaret(Rect rect) {
    if (!_scrollController.position.allowImplicitScrolling) {
      return RevealedOffset(offset: _scrollController.offset, rect: rect);
    }

    final Size editableSize = renderEditable.size;
    final double additionalOffset;
    final Offset unitOffset;

    if (!_isMultiline) {
      additionalOffset = rect.width >= editableSize.width
          // Center `rect` if it's oversized.
          ? editableSize.width / 2 - rect.center.dx
          // Valid additional offsets range from (rect.right - size.width)
          // to (rect.left). Pick the closest one if out of range.
          : clampDouble(0.0, rect.right - editableSize.width, rect.left);
      unitOffset = const Offset(1, 0);
    } else {
      // The caret is vertically centered within the line. Expand the caret's
      // height so that it spans the line because we're going to ensure that the
      // entire expanded caret is scrolled into view.
      final Rect expandedRect = Rect.fromCenter(
        center: rect.center,
        width: rect.width,
        height: math.max(rect.height, renderEditable.preferredLineHeight),
      );

      additionalOffset = expandedRect.height >= editableSize.height
          ? editableSize.height / 2 - expandedRect.center.dy
          : clampDouble(
              0.0, expandedRect.bottom - editableSize.height, expandedRect.top);
      unitOffset = const Offset(0, 1);
    }

    // No overscrolling when encountering tall fonts/scripts that extend past
    // the ascent.
    final double targetOffset = clampDouble(
      additionalOffset + _scrollController.offset,
      _scrollController.position.minScrollExtent,
      _scrollController.position.maxScrollExtent,
    );

    final double offsetDelta = _scrollController.offset - targetOffset;
    return RevealedOffset(
        rect: rect.shift(unitOffset * offsetDelta), offset: targetOffset);
  }

  bool get _needsAutofill => _effectiveAutofillClient
      .textInputConfiguration.autofillConfiguration.enabled;

  void _openInputConnection() {
    if (!_shouldCreateInputConnection) {
      return;
    }
    if (!_hasInputConnection) {
      final TextEditingValue localValue = _value;

      // When _needsAutofill == true && currentAutofillScope == null, autofill
      // is allowed but saving the user input from the text field is
      // discouraged.
      //
      // In case the autofillScope changes from a non-null value to null, or
      // _needsAutofill changes to false from true, the platform needs to be
      // notified to exclude this field from the autofill context. So we need to
      // provide the autofillId.
      _textInputConnection = _needsAutofill && currentAutofillScope != null
          ? currentAutofillScope!
              .attach(this, _effectiveAutofillClient.textInputConfiguration)
          : TextInput.attach(
              this, _effectiveAutofillClient.textInputConfiguration);
      _updateSizeAndTransform();
      _updateComposingRectIfNeeded();
      _updateCaretRectIfNeeded();
      final TextStyle style = widget.style;
      _textInputConnection!
        ..setStyle(
          fontFamily: style.fontFamily,
          fontSize: style.fontSize,
          fontWeight: style.fontWeight,
          textDirection: _textDirection,
          textAlign: widget.textAlign,
        )
        ..setEditingState(localValue)
        ..show();
      if (_needsAutofill) {
        // Request autofill AFTER the size and the transform have been sent to
        // the platform text input plugin.
        _textInputConnection!.requestAutofill();
      }
      _lastKnownRemoteTextEditingValue = localValue;
    } else {
      _textInputConnection!.show();
    }
  }

  void _closeInputConnectionIfNeeded() {
    if (_hasInputConnection) {
      _textInputConnection!.close();
      _textInputConnection = null;
      _lastKnownRemoteTextEditingValue = null;
    }
  }

  void _openOrCloseInputConnectionIfNeeded() {
    if (_hasFocus && widget.focusNode.consumeKeyboardToken()) {
      _openInputConnection();
    } else if (!_hasFocus) {
      _closeInputConnectionIfNeeded();
      widget.controller.clearComposing();
    }
  }

  bool _restartConnectionScheduled = false;

  void _scheduleRestartConnection() {
    if (_restartConnectionScheduled) {
      return;
    }
    _restartConnectionScheduled = true;
    scheduleMicrotask(_restartConnectionIfNeeded);
  }

  // Discards the current [TextInputConnection] and establishes a new one.
  //
  // This method is rarely needed. This is currently used to reset the input
  // type when the "submit" text input action is triggered and the developer
  // puts the focus back to this input field..
  void _restartConnectionIfNeeded() {
    _restartConnectionScheduled = false;
    if (!_hasInputConnection || !_shouldCreateInputConnection) {
      return;
    }
    _textInputConnection!.close();
    _textInputConnection = null;
    _lastKnownRemoteTextEditingValue = null;

    final AutofillScope? currentAutofillScope =
        _needsAutofill ? this.currentAutofillScope : null;
    final TextInputConnection newConnection = currentAutofillScope?.attach(
            this, textInputConfiguration) ??
        TextInput.attach(this, _effectiveAutofillClient.textInputConfiguration);
    _textInputConnection = newConnection;

    final TextStyle style = widget.style;
    newConnection
      ..show()
      ..setStyle(
        fontFamily: style.fontFamily,
        fontSize: style.fontSize,
        fontWeight: style.fontWeight,
        textDirection: _textDirection,
        textAlign: widget.textAlign,
      )
      ..setEditingState(_value);
    _lastKnownRemoteTextEditingValue = _value;
  }

  @override
  void didChangeInputControl(
      TextInputControl? oldControl, TextInputControl? newControl) {
    if (_hasFocus && _hasInputConnection) {
      oldControl?.hide();
      newControl?.show();
    }
  }

  @override
  void connectionClosed() {
    if (_hasInputConnection) {
      _textInputConnection!.connectionClosedReceived();
      _textInputConnection = null;
      _lastKnownRemoteTextEditingValue = null;
      _finalizeEditing(TextInputAction.done, shouldUnfocus: true);
    }
  }

  void requestKeyboard() {
    if (_hasFocus) {
      _openInputConnection();
    } else {
      widget.focusNode
          .requestFocus(); // This eventually calls _openInputConnection also, see _handleFocusChanged.
    }
  }

  void _updateOrDisposeSelectionOverlayIfNeeded() {
    if (_selectionOverlay != null) {
      if (_hasFocus) {
        _selectionOverlay!.update(_value);
      } else {
        _selectionOverlay!.dispose();
        _selectionOverlay = null;
      }
    }
  }

  void _onEditableScroll() {
    _selectionOverlay?.updateForScroll();
    _scribbleCacheKey = null;
  }

  TextSelectionOverlay _createSelectionOverlay() {
    final TextSelectionOverlay selectionOverlay = TextSelectionOverlay(
      clipboardStatus: clipboardStatus,
      context: context,
      value: _value,
      debugRequiredFor: widget,
      toolbarLayerLink: _toolbarLayerLink,
      startHandleLayerLink: _startHandleLayerLink,
      endHandleLayerLink: _endHandleLayerLink,
      renderObject: renderEditable,
      selectionControls: widget.selectionControls,
      selectionDelegate: this,
      dragStartBehavior: widget.dragStartBehavior,
      onSelectionHandleTapped: widget.onSelectionHandleTapped,
      contextMenuBuilder: widget.contextMenuBuilder == null
          ? null
          : (BuildContext context) {
              return widget.contextMenuBuilder!(
                context,
                this,
              );
            },
      magnifierConfiguration: widget.magnifierConfiguration,
    );

    return selectionOverlay;
  }

  @pragma('vm:notify-debugger-on-exception')
  void _handleSelectionChanged(
      TextSelection selection, SelectionChangedCause? cause) {
    // We return early if the selection is not valid. This can happen when the
    // text of [EditableText] is updated at the same time as the selection is
    // changed by a gesture event.
    if (!widget.controller.isSelectionWithinTextBounds(selection)) {
      return;
    }

    widget.controller.selection = selection;

    // This will show the keyboard for all selection changes on the
    // EditableText except for those triggered by a keyboard input.
    // Typically EditableText shouldn't take user keyboard input if
    // it's not focused already. If the EditableText is being
    // autofilled it shouldn't request focus.
    switch (cause) {
      case null:
      case SelectionChangedCause.doubleTap:
      case SelectionChangedCause.drag:
      case SelectionChangedCause.forcePress:
      case SelectionChangedCause.longPress:
      case SelectionChangedCause.scribble:
      case SelectionChangedCause.tap:
      case SelectionChangedCause.toolbar:
        requestKeyboard();
        break;
      case SelectionChangedCause.keyboard:
        if (_hasFocus) {
          requestKeyboard();
        }
        break;
    }
    if (widget.selectionControls == null && widget.contextMenuBuilder == null) {
      _selectionOverlay?.dispose();
      _selectionOverlay = null;
    } else {
      if (_selectionOverlay == null) {
        _selectionOverlay = _createSelectionOverlay();
      } else {
        _selectionOverlay!.update(_value);
      }
      _selectionOverlay!.handlesVisible = widget.showSelectionHandles;
      _selectionOverlay!.showHandles();
    }
    // TODO(chunhtai): we should make sure selection actually changed before
    // we call the onSelectionChanged.
    // https://github.com/flutter/flutter/issues/76349.
    try {
      widget.onSelectionChanged?.call(selection, cause);
    } catch (exception, stack) {
      FlutterError.reportError(FlutterErrorDetails(
        exception: exception,
        stack: stack,
        library: 'widgets',
        context:
            ErrorDescription('while calling onSelectionChanged for $cause'),
      ));
    }

    // To keep the cursor from blinking while it moves, restart the timer here.
    if (_cursorTimer != null) {
      _stopCursorBlink(resetCharTicks: false);
      _startCursorBlink();
    }
  }

  Rect? _currentCaretRect;

  // ignore: use_setters_to_change_properties, (this is used as a callback, can't be a setter)
  void _handleCaretChanged(Rect caretRect) {
    _currentCaretRect = caretRect;
  }

  // Animation configuration for scrolling the caret back on screen.
  static const Duration _caretAnimationDuration = Duration(milliseconds: 100);
  static const Curve _caretAnimationCurve = Curves.fastOutSlowIn;

  bool _showCaretOnScreenScheduled = false;

  void _scheduleShowCaretOnScreen({required bool withAnimation}) {
    if (_showCaretOnScreenScheduled) {
      return;
    }
    _showCaretOnScreenScheduled = true;
    SchedulerBinding.instance.addPostFrameCallback((Duration _) {
      _showCaretOnScreenScheduled = false;
      if (_currentCaretRect == null || !_scrollController.hasClients) {
        return;
      }

      final double lineHeight = renderEditable.preferredLineHeight;

      // Enlarge the target rect by scrollPadding to ensure that caret is not
      // positioned directly at the edge after scrolling.
      double bottomSpacing = widget.scrollPadding.bottom;
      if (_selectionOverlay?.selectionControls != null) {
        final double handleHeight = _selectionOverlay!.selectionControls!
            .getHandleSize(lineHeight)
            .height;
        final double interactiveHandleHeight = math.max(
          handleHeight,
          kMinInteractiveDimension,
        );
        final Offset anchor =
            _selectionOverlay!.selectionControls!.getHandleAnchor(
          TextSelectionHandleType.collapsed,
          lineHeight,
        );
        final double handleCenter = handleHeight / 2 - anchor.dy;
        bottomSpacing = math.max(
          handleCenter + interactiveHandleHeight / 2,
          bottomSpacing,
        );
      }

      final EdgeInsets caretPadding =
          widget.scrollPadding.copyWith(bottom: bottomSpacing);

      final RevealedOffset targetOffset =
          _getOffsetToRevealCaret(_currentCaretRect!);

      final Rect rectToReveal;
      final TextSelection selection = textEditingValue.selection;
      if (selection.isCollapsed) {
        rectToReveal = targetOffset.rect;
      } else {
        final List<Rect> selectionBoxes =
            renderEditable.getBoxesForSelection(selection);
        rectToReveal = selection.baseOffset < selection.extentOffset
            ? selectionBoxes.last
            : selectionBoxes.first;
      }

      if (withAnimation) {
        _scrollController.animateTo(
          targetOffset.offset,
          duration: _caretAnimationDuration,
          curve: _caretAnimationCurve,
        );
        renderEditable.showOnScreen(
          rect: caretPadding.inflateRect(rectToReveal),
          duration: _caretAnimationDuration,
          curve: _caretAnimationCurve,
        );
      } else {
        _scrollController.jumpTo(targetOffset.offset);
        if (_value.selection.isCollapsed) {
          renderEditable.showOnScreen(
            rect: caretPadding.inflateRect(rectToReveal),
          );
        }
      }
    });
  }

  late double _lastBottomViewInset;

  @override
  void didChangeMetrics() {
    if (_lastBottomViewInset !=
        WidgetsBinding.instance.window.viewInsets.bottom) {
      SchedulerBinding.instance.addPostFrameCallback((Duration _) {
        _selectionOverlay?.updateForScroll();
      });
      if (_lastBottomViewInset <
          WidgetsBinding.instance.window.viewInsets.bottom) {
        // Because the metrics change signal from engine will come here every frame
        // (on both iOS and Android). So we don't need to show caret with animation.
        _scheduleShowCaretOnScreen(withAnimation: false);
      }
    }
    _lastBottomViewInset = WidgetsBinding.instance.window.viewInsets.bottom;
  }

  Future<void> _performSpellCheck(final String text) async {
    try {
      final Locale? localeForSpellChecking =
          widget.locale ?? Localizations.maybeLocaleOf(context);

      assert(
        localeForSpellChecking != null,
        'Locale must be specified in widget or Localization widget must be in scope',
      );

      final List<SuggestionSpan>? spellCheckResults =
          await _spellCheckConfiguration.spellCheckService!
              .fetchSpellCheckSuggestions(localeForSpellChecking!, text);

      if (spellCheckResults == null) {
        // The request to fetch spell check suggestions was canceled due to ongoing request.
        return;
      }

      _spellCheckResults = SpellCheckResults(text, spellCheckResults);
      renderEditable.text = buildTextSpan();
    } catch (exception, stack) {
      FlutterError.reportError(FlutterErrorDetails(
        exception: exception,
        stack: stack,
        library: 'widgets',
        context: ErrorDescription('while performing spell check'),
      ));
    }
  }

  @pragma('vm:notify-debugger-on-exception')
  void _formatAndSetValue(TextEditingValue value, SelectionChangedCause? cause,
      {bool userInteraction = false}) {
    final TextEditingValue oldValue = _value;
    final bool textChanged = oldValue.text != value.text;
    final bool textCommitted =
        !oldValue.composing.isCollapsed && value.composing.isCollapsed;
    final bool selectionChanged = oldValue.selection != value.selection;

    if (textChanged || textCommitted) {
      // Only apply input formatters if the text has changed (including uncommitted
      // text in the composing region), or when the user committed the composing
      // text.
      // Gboard is very persistent in restoring the composing region. Applying
      // input formatters on composing-region-only changes (except clearing the
      // current composing region) is very infinite-loop-prone: the formatters
      // will keep trying to modify the composing region while Gboard will keep
      // trying to restore the original composing region.
      try {
        value = widget.inputFormatters?.fold<TextEditingValue>(
              value,
              (TextEditingValue newValue, TextInputFormatter formatter) =>
                  formatter.formatEditUpdate(_value, newValue),
            ) ??
            value;

        if (spellCheckEnabled &&
            value.text.isNotEmpty &&
            _value.text != value.text) {
          _performSpellCheck(value.text);
        }
      } catch (exception, stack) {
        FlutterError.reportError(FlutterErrorDetails(
          exception: exception,
          stack: stack,
          library: 'widgets',
          context: ErrorDescription('while applying input formatters'),
        ));
      }
    }

    // Put all optional user callback invocations in a batch edit to prevent
    // sending multiple `TextInput.updateEditingValue` messages.
    beginBatchEdit();
    _value = value;
    // Changes made by the keyboard can sometimes be "out of band" for listening
    // components, so always send those events, even if we didn't think it
    // changed. Also, the user long pressing should always send a selection change
    // as well.
    if (selectionChanged ||
        (userInteraction &&
            (cause == SelectionChangedCause.longPress ||
                cause == SelectionChangedCause.keyboard))) {
      _handleSelectionChanged(_value.selection, cause);
    }
    final String currentText = _value.text;
    if (oldValue.text != currentText) {
      try {
        widget.onChanged?.call(currentText);
      } catch (exception, stack) {
        FlutterError.reportError(FlutterErrorDetails(
          exception: exception,
          stack: stack,
          library: 'widgets',
          context: ErrorDescription('while calling onChanged'),
        ));
      }
    }
    endBatchEdit();
  }

  void _onCursorColorTick() {
    renderEditable.cursorColor =
        widget.cursorColor.withOpacity(_cursorBlinkOpacityController.value);
    _cursorVisibilityNotifier.value =
        widget.showCursor && _cursorBlinkOpacityController.value > 0;
  }

  @visibleForTesting
  bool get cursorCurrentlyVisible => _cursorBlinkOpacityController.value > 0;

  @visibleForTesting
  Duration get cursorBlinkInterval => _kCursorBlinkHalfPeriod;

  @visibleForTesting
  TextSelectionOverlay? get selectionOverlay => _selectionOverlay;

  int _obscureShowCharTicksPending = 0;
  int? _obscureLatestCharIndex;

  // Indicates whether the cursor should be blinking right now (but it may
  // actually not blink because it's disabled via TickerMode.of(context)).
  bool _cursorActive = false;

  void _startCursorBlink() {
    assert(!(_cursorTimer?.isActive ?? false) ||
        !(_backingCursorBlinkOpacityController?.isAnimating ?? false));
    _cursorActive = true;
    if (!_tickersEnabled) {
      return;
    }
    _cursorTimer?.cancel();
    _cursorBlinkOpacityController.value = 1.0;
    if (EditableText.debugDeterministicCursor) {
      return;
    }
    if (widget.cursorOpacityAnimates) {
      _cursorBlinkOpacityController
          .animateWith(_iosBlinkCursorSimulation)
          .whenComplete(_onCursorTick);
    } else {
      _cursorTimer = Timer.periodic(_kCursorBlinkHalfPeriod, (Timer timer) {
        _onCursorTick();
      });
    }
  }

  void _onCursorTick() {
    if (_obscureShowCharTicksPending > 0) {
      _obscureShowCharTicksPending =
          WidgetsBinding.instance.platformDispatcher.brieflyShowPassword
              ? _obscureShowCharTicksPending - 1
              : 0;
      if (_obscureShowCharTicksPending == 0) {
        setState(() {});
      }
    }

    if (widget.cursorOpacityAnimates) {
      _cursorTimer?.cancel();
      // Schedule this as an async task to avoid blocking tester.pumpAndSettle
      // indefinitely.
      _cursorTimer = Timer(
          Duration.zero,
          () => _cursorBlinkOpacityController
              .animateWith(_iosBlinkCursorSimulation)
              .whenComplete(_onCursorTick));
    } else {
      if (!(_cursorTimer?.isActive ?? false) && _tickersEnabled) {
        _cursorTimer = Timer.periodic(_kCursorBlinkHalfPeriod, (Timer timer) {
          _onCursorTick();
        });
      }
      _cursorBlinkOpacityController.value =
          _cursorBlinkOpacityController.value == 0 ? 1 : 0;
    }
  }

  void _stopCursorBlink({bool resetCharTicks = true}) {
    _cursorActive = false;
    _cursorBlinkOpacityController.value = 0.0;
    _cursorTimer?.cancel();
    _cursorTimer = null;
    if (resetCharTicks) {
      _obscureShowCharTicksPending = 0;
    }
  }

  void _startOrStopCursorTimerIfNeeded() {
    if (_cursorTimer == null && _hasFocus && _value.selection.isCollapsed) {
      _startCursorBlink();
    } else if (_cursorActive && (!_hasFocus || !_value.selection.isCollapsed)) {
      _stopCursorBlink();
    }
  }

  void _didChangeTextEditingValue() {
    _updateRemoteEditingValueIfNeeded();
    _startOrStopCursorTimerIfNeeded();
    _updateOrDisposeSelectionOverlayIfNeeded();
    // TODO(abarth): Teach RenderEditable about ValueNotifier<TextEditingValue>
    // to avoid this setState().
    setState(() {
      /* We use widget.controller.value in build(). */
    });
    _verticalSelectionUpdateAction.stopCurrentVerticalRunIfSelectionChanges();
  }

  void _handleFocusChanged() {
    _openOrCloseInputConnectionIfNeeded();
    _startOrStopCursorTimerIfNeeded();
    _updateOrDisposeSelectionOverlayIfNeeded();
    if (_hasFocus) {
      // Listen for changing viewInsets, which indicates keyboard showing up.
      WidgetsBinding.instance.addObserver(this);
      _lastBottomViewInset = WidgetsBinding.instance.window.viewInsets.bottom;
      if (!widget.readOnly) {
        _scheduleShowCaretOnScreen(withAnimation: true);
      }
      if (!_value.selection.isValid) {
        // Place cursor at the end if the selection is invalid when we receive focus.
        _handleSelectionChanged(
            TextSelection.collapsed(offset: _value.text.length), null);
      }
    } else {
      WidgetsBinding.instance.removeObserver(this);
      setState(() {
        _currentPromptRectRange = null;
      });
    }
    updateKeepAlive();
  }

  _ScribbleCacheKey? _scribbleCacheKey;

  void _updateSelectionRects({bool force = false}) {
    if (!widget.scribbleEnabled ||
        defaultTargetPlatform != TargetPlatform.iOS) {
      return;
    }

    final ScrollDirection scrollDirection =
        _scrollController.position.userScrollDirection;
    if (scrollDirection != ScrollDirection.idle) {
      return;
    }

    final InlineSpan inlineSpan = renderEditable.text!;
    final _ScribbleCacheKey newCacheKey = _ScribbleCacheKey(
      inlineSpan: inlineSpan,
      textAlign: widget.textAlign,
      textDirection: _textDirection,
      textScaleFactor:
          widget.textScaleFactor ?? MediaQuery.textScaleFactorOf(context),
      textHeightBehavior: widget.textHeightBehavior ??
          DefaultTextHeightBehavior.maybeOf(context),
      locale: widget.locale,
      structStyle: widget.strutStyle,
      placeholder: _placeholderLocation,
      size: renderEditable.size,
    );

    final RenderComparison comparison = force
        ? RenderComparison.layout
        : _scribbleCacheKey?.compare(newCacheKey) ?? RenderComparison.layout;
    if (comparison.index < RenderComparison.layout.index) {
      return;
    }
    _scribbleCacheKey = newCacheKey;

    final List<SelectionRect> rects = <SelectionRect>[];
    int graphemeStart = 0;
    // Can't use _value.text here: the controller value could change between
    // frames.
    final String plainText =
        inlineSpan.toPlainText(includeSemanticsLabels: false);
    final CharacterRange characterRange = CharacterRange(plainText);
    while (characterRange.moveNext()) {
      final int graphemeEnd = graphemeStart + characterRange.current.length;
      final List<Rect> boxes = renderEditable.getBoxesForSelection(
        TextSelection(baseOffset: graphemeStart, extentOffset: graphemeEnd),
      );

      final Rect? box = boxes.isEmpty ? null : boxes.first;
      if (box != null) {
        final Rect paintBounds = renderEditable.paintBounds;
        // Stop early when characters are already below the bottom edge of the
        // RenderEditable, regardless of its clipBehavior.
        if (paintBounds.bottom <= box.top) {
          break;
        }
        if (paintBounds.contains(box.topLeft) ||
            paintBounds.contains(box.bottomRight)) {
          rects.add(SelectionRect(position: graphemeStart, bounds: box));
        }
      }
      graphemeStart = graphemeEnd;
    }
    _textInputConnection!.setSelectionRects(rects);
  }

  void _updateSizeAndTransform() {
    if (_hasInputConnection) {
      final Size size = renderEditable.size;
      final Matrix4 transform = renderEditable.getTransformTo(null);
      _textInputConnection!.setEditableSizeAndTransform(size, transform);
      _updateSelectionRects();
      SchedulerBinding.instance
          .addPostFrameCallback((Duration _) => _updateSizeAndTransform());
    } else if (_placeholderLocation != -1) {
      removeTextPlaceholder();
    }
  }

  // Sends the current composing rect to the iOS text input plugin via the text
  // input channel. We need to keep sending the information even if no text is
  // currently marked, as the information usually lags behind. The text input
  // plugin needs to estimate the composing rect based on the latest caret rect,
  // when the composing rect info didn't arrive in time.
  void _updateComposingRectIfNeeded() {
    final TextRange composingRange = _value.composing;
    if (_hasInputConnection) {
      assert(mounted);
      Rect? composingRect =
          renderEditable.getRectForComposingRange(composingRange);
      // Send the caret location instead if there's no marked text yet.
      if (composingRect == null) {
        assert(!composingRange.isValid || composingRange.isCollapsed);
        final int offset = composingRange.isValid ? composingRange.start : 0;
        composingRect =
            renderEditable.getLocalRectForCaret(TextPosition(offset: offset));
      }
      assert(composingRect != null);
      _textInputConnection!.setComposingRect(composingRect);
      SchedulerBinding.instance
          .addPostFrameCallback((Duration _) => _updateComposingRectIfNeeded());
    }
  }

  void _updateCaretRectIfNeeded() {
    if (_hasInputConnection) {
      if (renderEditable.selection != null &&
          renderEditable.selection!.isValid &&
          renderEditable.selection!.isCollapsed) {
        final TextPosition currentTextPosition =
            TextPosition(offset: renderEditable.selection!.baseOffset);
        final Rect caretRect =
            renderEditable.getLocalRectForCaret(currentTextPosition);
        _textInputConnection!.setCaretRect(caretRect);
      }
      SchedulerBinding.instance
          .addPostFrameCallback((Duration _) => _updateCaretRectIfNeeded());
    }
  }

  TextDirection get _textDirection {
    final TextDirection result =
        widget.textDirection ?? Directionality.of(context);
    assert(result != null,
        '$runtimeType created without a textDirection and with no ambient Directionality.');
    return result;
  }

  RenderEditable get renderEditable =>
      _editableKey.currentContext!.findRenderObject()! as RenderEditable;

  @override
  TextEditingValue get textEditingValue => _value;

  double get _devicePixelRatio => MediaQuery.of(context).devicePixelRatio;

  @override
  void userUpdateTextEditingValue(
      TextEditingValue value, SelectionChangedCause? cause) {
    // Compare the current TextEditingValue with the pre-format new
    // TextEditingValue value, in case the formatter would reject the change.
    final bool shouldShowCaret =
        widget.readOnly ? _value.selection != value.selection : _value != value;
    if (shouldShowCaret) {
      _scheduleShowCaretOnScreen(withAnimation: true);
    }

    // Even if the value doesn't change, it may be necessary to focus and build
    // the selection overlay. For example, this happens when right clicking an
    // unfocused field that previously had a selection in the same spot.
    if (value == textEditingValue) {
      if (!widget.focusNode.hasFocus) {
        widget.focusNode.requestFocus();
        _selectionOverlay = _createSelectionOverlay();
      }
      return;
    }

    _formatAndSetValue(value, cause, userInteraction: true);
  }

  @override
  void bringIntoView(TextPosition position) {
    final Rect localRect = renderEditable.getLocalRectForCaret(position);
    final RevealedOffset targetOffset = _getOffsetToRevealCaret(localRect);

    _scrollController.jumpTo(targetOffset.offset);
    renderEditable.showOnScreen(rect: targetOffset.rect);
  }

  @override
  bool showToolbar() {
    // Web is using native dom elements to enable clipboard functionality of the
    // toolbar: copy, paste, select, cut. It might also provide additional
    // functionality depending on the browser (such as translate). Due to this
    // we should not show a Flutter toolbar for the editable text elements.
    if (kIsWeb) {
      return false;
    }

    if (_selectionOverlay == null) {
      return false;
    }
    clipboardStatus?.update();
    _selectionOverlay!.showToolbar();
    return true;
  }

  @override
  void hideToolbar([bool hideHandles = true]) {
    if (hideHandles) {
      // Hide the handles and the toolbar.
      _selectionOverlay?.hide();
    } else if (_selectionOverlay?.toolbarIsVisible ?? false) {
      // Hide only the toolbar but not the handles.
      _selectionOverlay?.hideToolbar();
    }
  }

  void toggleToolbar([bool hideHandles = true]) {
    final TextSelectionOverlay selectionOverlay =
        _selectionOverlay ??= _createSelectionOverlay();

    if (selectionOverlay.toolbarIsVisible) {
      hideToolbar(hideHandles);
    } else {
      showToolbar();
    }
  }

  void showMagnifier(Offset positionToShow) {
    if (_selectionOverlay == null) {
      return;
    }

    if (_selectionOverlay!.magnifierIsVisible) {
      _selectionOverlay!.updateMagnifier(positionToShow);
    } else {
      _selectionOverlay!.showMagnifier(positionToShow);
    }
  }

  void hideMagnifier() {
    if (_selectionOverlay == null) {
      return;
    }

    if (_selectionOverlay!.magnifierIsVisible) {
      _selectionOverlay!.hideMagnifier();
    }
  }

  // Tracks the location a [_ScribblePlaceholder] should be rendered in the
  // text.
  //
  // A value of -1 indicates there should be no placeholder, otherwise the
  // value should be between 0 and the length of the text, inclusive.
  int _placeholderLocation = -1;

  @override
  void insertTextPlaceholder(Size size) {
    if (!widget.scribbleEnabled) {
      return;
    }

    if (!widget.controller.selection.isValid) {
      return;
    }

    setState(() {
      _placeholderLocation =
          _value.text.length - widget.controller.selection.end;
    });
  }

  @override
  void removeTextPlaceholder() {
    if (!widget.scribbleEnabled) {
      return;
    }

    setState(() {
      _placeholderLocation = -1;
    });
  }

  @override
  void performSelector(String selectorName) {
    final Intent? intent = intentForMacOSSelector(selectorName);

    if (intent != null) {
      final BuildContext? primaryContext = primaryFocus?.context;
      if (primaryContext != null) {
        Actions.invoke(primaryContext, intent);
      }
    }
  }

  @override
  String get autofillId => 'EditableText-$hashCode';

  @override
  TextInputConfiguration get textInputConfiguration {
    final List<String>? autofillHints =
        widget.autofillHints?.toList(growable: false);
    final AutofillConfiguration autofillConfiguration = autofillHints != null
        ? AutofillConfiguration(
            uniqueIdentifier: autofillId,
            autofillHints: autofillHints,
            currentEditingValue: currentTextEditingValue,
          )
        : AutofillConfiguration.disabled;

    return TextInputConfiguration(
      inputType: widget.keyboardType,
      readOnly: widget.readOnly,
      obscureText: widget.obscureText,
      autocorrect: widget.autocorrect,
      smartDashesType: widget.smartDashesType,
      smartQuotesType: widget.smartQuotesType,
      enableSuggestions: widget.enableSuggestions,
      enableInteractiveSelection: widget._userSelectionEnabled,
      inputAction: widget.textInputAction ??
          (widget.keyboardType == TextInputType.multiline
              ? TextInputAction.newline
              : TextInputAction.done),
      textCapitalization: widget.textCapitalization,
      keyboardAppearance: widget.keyboardAppearance,
      autofillConfiguration: autofillConfiguration,
      enableIMEPersonalizedLearning: widget.enableIMEPersonalizedLearning,
    );
  }

  @override
  void autofill(TextEditingValue value) => updateEditingValue(value);

  // null if no promptRect should be shown.
  TextRange? _currentPromptRectRange;

  @override
  void showAutocorrectionPromptRect(int start, int end) {
    setState(() {
      _currentPromptRectRange = TextRange(start: start, end: end);
    });
  }

  VoidCallback? _semanticsOnCopy(TextSelectionControls? controls) {
    return widget.selectionEnabled &&
            _hasFocus &&
            (widget.selectionControls is TextSelectionHandleControls
                ? copyEnabled
                : copyEnabled &&
                    (widget.selectionControls?.canCopy(this) ?? false))
        ? () {
            controls?.handleCopy(this);
            copySelection(SelectionChangedCause.toolbar);
          }
        : null;
  }

  VoidCallback? _semanticsOnCut(TextSelectionControls? controls) {
    return widget.selectionEnabled &&
            _hasFocus &&
            (widget.selectionControls is TextSelectionHandleControls
                ? cutEnabled
                : cutEnabled &&
                    (widget.selectionControls?.canCut(this) ?? false))
        ? () {
            controls?.handleCut(this);
            cutSelection(SelectionChangedCause.toolbar);
          }
        : null;
  }

  VoidCallback? _semanticsOnPaste(TextSelectionControls? controls) {
    return widget.selectionEnabled &&
            _hasFocus &&
            (widget.selectionControls is TextSelectionHandleControls
                ? pasteEnabled
                : pasteEnabled &&
                    (widget.selectionControls?.canPaste(this) ?? false)) &&
            (clipboardStatus == null ||
                clipboardStatus!.value == ClipboardStatus.pasteable)
        ? () {
            controls?.handlePaste(this);
            pasteText(SelectionChangedCause.toolbar);
          }
        : null;
  }

  // --------------------------- Text Editing Actions ---------------------------

  TextBoundary _characterBoundary(DirectionalTextEditingIntent intent) {
    final TextBoundary atomicTextBoundary = widget.obscureText
        ? _CodeUnitBoundary(_value.text)
        : CharacterBoundary(_value.text);
    return intent.forward
        ? PushTextPosition.forward + atomicTextBoundary
        : PushTextPosition.backward + atomicTextBoundary;
  }

  TextBoundary _nextWordBoundary(DirectionalTextEditingIntent intent) {
    final TextBoundary atomicTextBoundary;
    final TextBoundary boundary;

    if (widget.obscureText) {
      atomicTextBoundary = _CodeUnitBoundary(_value.text);
      boundary = DocumentBoundary(_value.text);
    } else {
      final TextEditingValue textEditingValue =
          _textEditingValueforTextLayoutMetrics;
      atomicTextBoundary = CharacterBoundary(textEditingValue.text);
      // This isn't enough. Newline characters.
      boundary = WhitespaceBoundary(textEditingValue.text) +
          WordBoundary(renderEditable);
    }

    final _MixedBoundary mixedBoundary = intent.forward
        ? _MixedBoundary(atomicTextBoundary, boundary)
        : _MixedBoundary(boundary, atomicTextBoundary);
    // Use a _MixedBoundary to make sure we don't leave invalid codepoints in
    // the field after deletion.
    return intent.forward
        ? PushTextPosition.forward + mixedBoundary
        : PushTextPosition.backward + mixedBoundary;
  }

  TextBoundary _linebreak(DirectionalTextEditingIntent intent) {
    final TextBoundary atomicTextBoundary;
    final TextBoundary boundary;

    if (widget.obscureText) {
      atomicTextBoundary = _CodeUnitBoundary(_value.text);
      boundary = DocumentBoundary(_value.text);
    } else {
      final TextEditingValue textEditingValue =
          _textEditingValueforTextLayoutMetrics;
      atomicTextBoundary = CharacterBoundary(textEditingValue.text);
      boundary = LineBreak(renderEditable);
    }

    // The _MixedBoundary is to make sure we don't leave invalid code units in
    // the field after deletion.
    // `boundary` doesn't need to be wrapped in a _CollapsedSelectionBoundary,
    // since the document boundary is unique and the linebreak boundary is
    // already caret-location based.
    final TextBoundary pushed = intent.forward
        ? PushTextPosition.forward + atomicTextBoundary
        : PushTextPosition.backward + atomicTextBoundary;
    return intent.forward
        ? _MixedBoundary(pushed, boundary)
        : _MixedBoundary(boundary, pushed);
  }

  TextBoundary _documentBoundary(DirectionalTextEditingIntent intent) =>
      DocumentBoundary(_value.text);

  Action<T> _makeOverridable<T extends Intent>(Action<T> defaultAction) {
    return Action<T>.overridable(
        context: context, defaultAction: defaultAction);
  }

  void _transposeCharacters(TransposeCharactersIntent intent) {
    if (_value.text.characters.length <= 1 ||
        _value.selection == null ||
        !_value.selection.isCollapsed ||
        _value.selection.baseOffset == 0) {
      return;
    }

    final String text = _value.text;
    final TextSelection selection = _value.selection;
    final bool atEnd = selection.baseOffset == text.length;
    final CharacterRange transposing =
        CharacterRange.at(text, selection.baseOffset);
    if (atEnd) {
      transposing.moveBack(2);
    } else {
      transposing
        ..moveBack()
        ..expandNext();
    }
    assert(transposing.currentCharacters.length == 2);

    userUpdateTextEditingValue(
      TextEditingValue(
        text: transposing.stringBefore +
            transposing.currentCharacters.last +
            transposing.currentCharacters.first +
            transposing.stringAfter,
        selection: TextSelection.collapsed(
          offset: transposing.stringBeforeLength + transposing.current.length,
        ),
      ),
      SelectionChangedCause.keyboard,
    );
  }

  late final Action<TransposeCharactersIntent> _transposeCharactersAction =
      CallbackAction<TransposeCharactersIntent>(onInvoke: _transposeCharacters);

  void _replaceText(ReplaceTextIntent intent) {
    final TextEditingValue oldValue = _value;
    final TextEditingValue newValue = intent.currentTextEditingValue.replaced(
      intent.replacementRange,
      intent.replacementText,
    );
    userUpdateTextEditingValue(newValue, intent.cause);

    // If there's no change in text and selection (e.g. when selecting and
    // pasting identical text), the widget won't be rebuilt on value update.
    // Handle this by calling _didChangeTextEditingValue() so caret and scroll
    // updates can happen.
    if (newValue == oldValue) {
      _didChangeTextEditingValue();
    }
  }

  late final Action<ReplaceTextIntent> _replaceTextAction =
      CallbackAction<ReplaceTextIntent>(onInvoke: _replaceText);

  // Scrolls either to the beginning or end of the document depending on the
  // intent's `forward` parameter.
  void _scrollToDocumentBoundary(ScrollToDocumentBoundaryIntent intent) {
    if (intent.forward) {
      bringIntoView(TextPosition(offset: _value.text.length));
    } else {
      bringIntoView(const TextPosition(offset: 0));
    }
  }

  void _scroll(ScrollIntent intent) {
    if (intent.type != ScrollIncrementType.page) {
      return;
    }

    final ScrollPosition position = _scrollController.position;
    if (widget.maxLines == 1) {
      _scrollController.jumpTo(position.maxScrollExtent);
      return;
    }

    // If the field isn't scrollable, do nothing. For example, when the lines of
    // text is less than maxLines, the field has nothing to scroll.
    if (position.maxScrollExtent == 0.0 && position.minScrollExtent == 0.0) {
      return;
    }

    final ScrollableState? state =
        _scrollableKey.currentState as ScrollableState?;
    final double increment =
        ScrollAction.getDirectionalIncrement(state!, intent);
    final double destination = clampDouble(
      position.pixels + increment,
      position.minScrollExtent,
      position.maxScrollExtent,
    );
    if (destination == position.pixels) {
      return;
    }
    _scrollController.jumpTo(destination);
  }

  void _extendSelectionByPage(ExtendSelectionByPageIntent intent) {
    if (widget.maxLines == 1) {
      return;
    }

    final TextSelection nextSelection;
    final Rect extentRect = renderEditable.getLocalRectForCaret(
      _value.selection.extent,
    );
    final ScrollableState? state =
        _scrollableKey.currentState as ScrollableState?;
    final double increment = ScrollAction.getDirectionalIncrement(
      state!,
      ScrollIntent(
        direction: intent.forward ? AxisDirection.down : AxisDirection.up,
        type: ScrollIncrementType.page,
      ),
    );
    final ScrollPosition position = _scrollController.position;
    if (intent.forward) {
      if (_value.selection.extentOffset >= _value.text.length) {
        return;
      }
      final Offset nextExtentOffset =
          Offset(extentRect.left, extentRect.top + increment);
      final double height =
          position.maxScrollExtent + renderEditable.size.height;
      final TextPosition nextExtent =
          nextExtentOffset.dy + position.pixels >= height
              ? TextPosition(offset: _value.text.length)
              : renderEditable.getPositionForPoint(
                  renderEditable.localToGlobal(nextExtentOffset),
                );
      nextSelection = _value.selection.copyWith(
        extentOffset: nextExtent.offset,
      );
    } else {
      if (_value.selection.extentOffset <= 0) {
        return;
      }
      final Offset nextExtentOffset =
          Offset(extentRect.left, extentRect.top + increment);
      final TextPosition nextExtent = nextExtentOffset.dy + position.pixels <= 0
          ? const TextPosition(offset: 0)
          : renderEditable.getPositionForPoint(
              renderEditable.localToGlobal(nextExtentOffset),
            );
      nextSelection = _value.selection.copyWith(
        extentOffset: nextExtent.offset,
      );
    }

    bringIntoView(nextSelection.extent);
    userUpdateTextEditingValue(
      _value.copyWith(selection: nextSelection),
      SelectionChangedCause.keyboard,
    );
  }

  void _updateSelection(UpdateSelectionIntent intent) {
    bringIntoView(intent.newSelection.extent);
    userUpdateTextEditingValue(
      intent.currentTextEditingValue.copyWith(selection: intent.newSelection),
      intent.cause,
    );
  }

  late final Action<UpdateSelectionIntent> _updateSelectionAction =
      CallbackAction<UpdateSelectionIntent>(onInvoke: _updateSelection);

  late final _UpdateTextSelectionVerticallyAction<
          DirectionalCaretMovementIntent> _verticalSelectionUpdateAction =
      _UpdateTextSelectionVerticallyAction<DirectionalCaretMovementIntent>(
          this);

  void _expandSelectionToDocumentBoundary(
      ExpandSelectionToDocumentBoundaryIntent intent) {
    final TextBoundary textBoundary = _documentBoundary(intent);
    _expandSelection(intent.forward, textBoundary, true);
  }

  void _expandSelectionToLinebreak(ExpandSelectionToLineBreakIntent intent) {
    final TextBoundary textBoundary = _linebreak(intent);
    _expandSelection(intent.forward, textBoundary);
  }

  void _expandSelection(bool forward, TextBoundary textBoundary,
      [bool extentAtIndex = false]) {
    final TextSelection textBoundarySelection = _value.selection;
    if (!textBoundarySelection.isValid) {
      return;
    }

    final bool inOrder =
        textBoundarySelection.baseOffset <= textBoundarySelection.extentOffset;
    final bool towardsExtent = forward == inOrder;
    final TextPosition position = towardsExtent
        ? textBoundarySelection.extent
        : textBoundarySelection.base;

    final TextPosition newExtent = forward
        ? textBoundary.getTrailingTextBoundaryAt(position)
        : textBoundary.getLeadingTextBoundaryAt(position);

    final TextSelection newSelection = textBoundarySelection.expandTo(
        newExtent, textBoundarySelection.isCollapsed || extentAtIndex);
    userUpdateTextEditingValue(
      _value.copyWith(selection: newSelection),
      SelectionChangedCause.keyboard,
    );
    bringIntoView(newSelection.extent);
  }

  Object? _hideToolbarIfVisible(DismissIntent intent) {
    if (_selectionOverlay?.toolbarIsVisible ?? false) {
      hideToolbar(false);
      return null;
    }
    return Actions.invoke(context, intent);
  }

  void _defaultOnTapOutside(PointerDownEvent event) {
    /// The focus dropping behavior is only present on desktop platforms
    /// and mobile browsers.
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
      case TargetPlatform.iOS:
      case TargetPlatform.fuchsia:
        // On mobile platforms, we don't unfocus on touch events unless they're
        // in the web browser, but we do unfocus for all other kinds of events.
        switch (event.kind) {
          case ui.PointerDeviceKind.touch:
            if (kIsWeb) {
              widget.focusNode.unfocus();
            }
            break;
          case ui.PointerDeviceKind.mouse:
          case ui.PointerDeviceKind.stylus:
          case ui.PointerDeviceKind.invertedStylus:
          case ui.PointerDeviceKind.unknown:
            widget.focusNode.unfocus();
            break;
          case ui.PointerDeviceKind.trackpad:
            throw UnimplementedError(
                'Unexpected pointer down event for trackpad');
        }
        break;
      case TargetPlatform.linux:
      case TargetPlatform.macOS:
      case TargetPlatform.windows:
        widget.focusNode.unfocus();
        break;
    }
  }

  late final Map<Type, Action<Intent>> _actions = <Type, Action<Intent>>{
    DoNothingAndStopPropagationTextIntent: DoNothingAction(consumesKey: false),
    ReplaceTextIntent: _replaceTextAction,
    UpdateSelectionIntent: _updateSelectionAction,
    DirectionalFocusIntent: DirectionalFocusAction.forTextField(),
    DismissIntent:
        CallbackAction<DismissIntent>(onInvoke: _hideToolbarIfVisible),

    // Delete
    DeleteCharacterIntent: _makeOverridable(
        _DeleteTextAction<DeleteCharacterIntent>(this, _characterBoundary)),
    DeleteToNextWordBoundaryIntent: _makeOverridable(
        _DeleteTextAction<DeleteToNextWordBoundaryIntent>(
            this, _nextWordBoundary)),
    DeleteToLineBreakIntent: _makeOverridable(
        _DeleteTextAction<DeleteToLineBreakIntent>(this, _linebreak)),

    // Extend/Move Selection
    ExtendSelectionByCharacterIntent: _makeOverridable(
        _UpdateTextSelectionAction<ExtendSelectionByCharacterIntent>(
            this, false, _characterBoundary)),
    ExtendSelectionByPageIntent: _makeOverridable(
        CallbackAction<ExtendSelectionByPageIntent>(
            onInvoke: _extendSelectionByPage)),
    ExtendSelectionToNextWordBoundaryIntent: _makeOverridable(
        _UpdateTextSelectionAction<ExtendSelectionToNextWordBoundaryIntent>(
            this, true, _nextWordBoundary)),
    ExtendSelectionToLineBreakIntent: _makeOverridable(
        _UpdateTextSelectionAction<ExtendSelectionToLineBreakIntent>(
            this, true, _linebreak)),
    ExpandSelectionToLineBreakIntent: _makeOverridable(
        CallbackAction<ExpandSelectionToLineBreakIntent>(
            onInvoke: _expandSelectionToLinebreak)),
    ExpandSelectionToDocumentBoundaryIntent: _makeOverridable(
        CallbackAction<ExpandSelectionToDocumentBoundaryIntent>(
            onInvoke: _expandSelectionToDocumentBoundary)),
    ExtendSelectionVerticallyToAdjacentLineIntent:
        _makeOverridable(_verticalSelectionUpdateAction),
    ExtendSelectionVerticallyToAdjacentPageIntent:
        _makeOverridable(_verticalSelectionUpdateAction),
    ExtendSelectionToDocumentBoundaryIntent: _makeOverridable(
        _UpdateTextSelectionAction<ExtendSelectionToDocumentBoundaryIntent>(
            this, true, _documentBoundary)),
    ExtendSelectionToNextWordBoundaryOrCaretLocationIntent: _makeOverridable(
        _ExtendSelectionOrCaretPositionAction(this, _nextWordBoundary)),
    ScrollToDocumentBoundaryIntent: _makeOverridable(
        CallbackAction<ScrollToDocumentBoundaryIntent>(
            onInvoke: _scrollToDocumentBoundary)),
    ScrollIntent: CallbackAction<ScrollIntent>(onInvoke: _scroll),

    // Copy Paste
    SelectAllTextIntent: _makeOverridable(_SelectAllAction(this)),
    CopySelectionTextIntent: _makeOverridable(_CopySelectionAction(this)),
    PasteTextIntent: _makeOverridable(CallbackAction<PasteTextIntent>(
        onInvoke: (PasteTextIntent intent) => pasteText(intent.cause))),

    TransposeCharactersIntent: _makeOverridable(_transposeCharactersAction),
  };

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMediaQuery(context));
    super.build(context); // See AutomaticKeepAliveClientMixin.

    final TextSelectionControls? controls = widget.selectionControls;
    return TextFieldTapRegion(
      onTapOutside: widget.onTapOutside ?? _defaultOnTapOutside,
      debugLabel: kReleaseMode ? null : 'EditableText',
      child: MouseRegion(
        cursor: widget.mouseCursor ?? SystemMouseCursors.text,
        child: Actions(
          actions: _actions,
          child: _TextEditingHistory(
            controller: widget.controller,
            onTriggered: (TextEditingValue value) {
              userUpdateTextEditingValue(value, SelectionChangedCause.keyboard);
            },
            child: Focus(
              focusNode: widget.focusNode,
              includeSemantics: false,
              debugLabel: kReleaseMode ? null : 'EditableText',
              child: Scrollable(
                key: _scrollableKey,
                excludeFromSemantics: true,
                axisDirection:
                    _isMultiline ? AxisDirection.down : AxisDirection.right,
                controller: _scrollController,
                physics: widget.scrollPhysics,
                dragStartBehavior: widget.dragStartBehavior,
                restorationId: widget.restorationId,
                // If a ScrollBehavior is not provided, only apply scrollbars when
                // multiline. The overscroll indicator should not be applied in
                // either case, glowing or stretching.
                scrollBehavior: widget.scrollBehavior ??
                    ScrollConfiguration.of(context).copyWith(
                      scrollbars: _isMultiline,
                      overscroll: false,
                    ),
                viewportBuilder: (BuildContext context, ViewportOffset offset) {
                  return CompositedTransformTarget(
                    link: _toolbarLayerLink,
                    child: Semantics(
                      onCopy: _semanticsOnCopy(controls),
                      onCut: _semanticsOnCut(controls),
                      onPaste: _semanticsOnPaste(controls),
                      child: _ScribbleFocusable(
                        focusNode: widget.focusNode,
                        editableKey: _editableKey,
                        enabled: widget.scribbleEnabled,
                        updateSelectionRects: () {
                          _openInputConnection();
                          _updateSelectionRects(force: true);
                        },
                        child: _Editable(
                          key: _editableKey,
                          startHandleLayerLink: _startHandleLayerLink,
                          endHandleLayerLink: _endHandleLayerLink,
                          inlineSpan: buildTextSpan(),
                          value: _value,
                          cursorColor: _cursorColor,
                          backgroundCursorColor: widget.backgroundCursorColor,
                          showCursor: EditableText.debugDeterministicCursor
                              ? ValueNotifier<bool>(widget.showCursor)
                              : _cursorVisibilityNotifier,
                          forceLine: widget.forceLine,
                          readOnly: widget.readOnly,
                          hasFocus: _hasFocus,
                          maxLines: widget.maxLines,
                          minLines: widget.minLines,
                          expands: widget.expands,
                          strutStyle: widget.strutStyle,
                          selectionColor: widget.selectionColor,
                          textScaleFactor: widget.textScaleFactor ??
                              MediaQuery.textScaleFactorOf(context),
                          textAlign: widget.textAlign,
                          textDirection: _textDirection,
                          locale: widget.locale,
                          textHeightBehavior: widget.textHeightBehavior ??
                              DefaultTextHeightBehavior.maybeOf(context),
                          textWidthBasis: widget.textWidthBasis,
                          obscuringCharacter: widget.obscuringCharacter,
                          obscureText: widget.obscureText,
                          offset: offset,
                          onCaretChanged: _handleCaretChanged,
                          rendererIgnoresPointer: widget.rendererIgnoresPointer,
                          cursorWidth: widget.cursorWidth,
                          cursorHeight: widget.cursorHeight,
                          cursorRadius: widget.cursorRadius,
                          cursorOffset: widget.cursorOffset ?? Offset.zero,
                          selectionHeightStyle: widget.selectionHeightStyle,
                          selectionWidthStyle: widget.selectionWidthStyle,
                          paintCursorAboveText: widget.paintCursorAboveText,
                          enableInteractiveSelection:
                              widget._userSelectionEnabled,
                          textSelectionDelegate: this,
                          devicePixelRatio: _devicePixelRatio,
                          promptRectRange: _currentPromptRectRange,
                          promptRectColor: widget.autocorrectionTextRectColor,
                          clipBehavior: widget.clipBehavior,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  TextSpan buildTextSpan() {
    if (widget.obscureText) {
      String text = _value.text;
      text = widget.obscuringCharacter * text.length;
      // Reveal the latest character in an obscured field only on mobile.
      // Newer verions of iOS (iOS 15+) no longer reveal the most recently
      // entered character.
      const Set<TargetPlatform> mobilePlatforms = <TargetPlatform>{
        TargetPlatform.android,
        TargetPlatform.fuchsia,
      };
      final bool breiflyShowPassword =
          WidgetsBinding.instance.platformDispatcher.brieflyShowPassword &&
              mobilePlatforms.contains(defaultTargetPlatform);
      if (breiflyShowPassword) {
        final int? o =
            _obscureShowCharTicksPending > 0 ? _obscureLatestCharIndex : null;
        if (o != null && o >= 0 && o < text.length) {
          text = text.replaceRange(o, o + 1, _value.text.substring(o, o + 1));
        }
      }
      return TextSpan(style: widget.style, text: text);
    }
    if (_placeholderLocation >= 0 &&
        _placeholderLocation <= _value.text.length) {
      final List<_ScribblePlaceholder> placeholders = <_ScribblePlaceholder>[];
      final int placeholderLocation = _value.text.length - _placeholderLocation;
      if (_isMultiline) {
        // The zero size placeholder here allows the line to break and keep the caret on the first line.
        placeholders.add(const _ScribblePlaceholder(
            child: SizedBox.shrink(), size: Size.zero));
        placeholders.add(_ScribblePlaceholder(
            child: const SizedBox.shrink(),
            size: Size(renderEditable.size.width, 0.0)));
      } else {
        placeholders.add(const _ScribblePlaceholder(
            child: SizedBox.shrink(), size: Size(100.0, 0.0)));
      }
      return TextSpan(
        style: widget.style,
        children: <InlineSpan>[
          TextSpan(text: _value.text.substring(0, placeholderLocation)),
          ...placeholders,
          TextSpan(text: _value.text.substring(placeholderLocation)),
        ],
      );
    }
    final bool spellCheckResultsReceived =
        spellCheckEnabled && _spellCheckResults != null;
    final bool withComposing = !widget.readOnly && _hasFocus;
    if (spellCheckResultsReceived) {
      // If the composing range is out of range for the current text, ignore it to
      // preserve the tree integrity, otherwise in release mode a RangeError will
      // be thrown and this EditableText will be built with a broken subtree.
      assert(!_value.composing.isValid ||
          !withComposing ||
          _value.isComposingRangeValid);

      final bool composingRegionOutOfRange =
          !_value.isComposingRangeValid || !withComposing;

      return buildTextSpanWithSpellCheckSuggestions(
        _value,
        composingRegionOutOfRange,
        widget.style,
        _spellCheckConfiguration.misspelledTextStyle!,
        _spellCheckResults!,
      );
    }

    // Read only mode should not paint text composing.
    return widget.controller.buildTextSpan(
      context: context,
      style: widget.style,
      withComposing: withComposing,
    );
  }
}

class _Editable extends MultiChildRenderObjectWidget {
  _Editable({
    super.key,
    required this.inlineSpan,
    required this.value,
    required this.startHandleLayerLink,
    required this.endHandleLayerLink,
    this.cursorColor,
    this.backgroundCursorColor,
    required this.showCursor,
    required this.forceLine,
    required this.readOnly,
    this.textHeightBehavior,
    required this.textWidthBasis,
    required this.hasFocus,
    required this.maxLines,
    this.minLines,
    required this.expands,
    this.strutStyle,
    this.selectionColor,
    required this.textScaleFactor,
    required this.textAlign,
    required this.textDirection,
    this.locale,
    required this.obscuringCharacter,
    required this.obscureText,
    required this.offset,
    this.onCaretChanged,
    this.rendererIgnoresPointer = false,
    required this.cursorWidth,
    this.cursorHeight,
    this.cursorRadius,
    required this.cursorOffset,
    required this.paintCursorAboveText,
    this.selectionHeightStyle = ui.BoxHeightStyle.tight,
    this.selectionWidthStyle = ui.BoxWidthStyle.tight,
    this.enableInteractiveSelection = true,
    required this.textSelectionDelegate,
    required this.devicePixelRatio,
    this.promptRectRange,
    this.promptRectColor,
    required this.clipBehavior,
  })  : assert(textDirection != null),
        assert(rendererIgnoresPointer != null),
        super(children: _extractChildren(inlineSpan));

  // Traverses the InlineSpan tree and depth-first collects the list of
  // child widgets that are created in WidgetSpans.
  static List<Widget> _extractChildren(InlineSpan span) {
    final List<Widget> result = <Widget>[];
    span.visitChildren((InlineSpan span) {
      if (span is WidgetSpan) {
        result.add(span.child);
      }
      return true;
    });
    return result;
  }

  final InlineSpan inlineSpan;
  final TextEditingValue value;
  final Color? cursorColor;
  final LayerLink startHandleLayerLink;
  final LayerLink endHandleLayerLink;
  final Color? backgroundCursorColor;
  final ValueNotifier<bool> showCursor;
  final bool forceLine;
  final bool readOnly;
  final bool hasFocus;
  final int? maxLines;
  final int? minLines;
  final bool expands;
  final StrutStyle? strutStyle;
  final Color? selectionColor;
  final double textScaleFactor;
  final TextAlign textAlign;
  final TextDirection textDirection;
  final Locale? locale;
  final String obscuringCharacter;
  final bool obscureText;
  final TextHeightBehavior? textHeightBehavior;
  final TextWidthBasis textWidthBasis;
  final ViewportOffset offset;
  final CaretChangedHandler? onCaretChanged;
  final bool rendererIgnoresPointer;
  final double cursorWidth;
  final double? cursorHeight;
  final Radius? cursorRadius;
  final Offset cursorOffset;
  final bool paintCursorAboveText;
  final ui.BoxHeightStyle selectionHeightStyle;
  final ui.BoxWidthStyle selectionWidthStyle;
  final bool enableInteractiveSelection;
  final TextSelectionDelegate textSelectionDelegate;
  final double devicePixelRatio;
  final TextRange? promptRectRange;
  final Color? promptRectColor;
  final Clip clipBehavior;

  @override
  RenderEditable createRenderObject(BuildContext context) {
    return RenderEditable(
      text: inlineSpan,
      cursorColor: cursorColor,
      startHandleLayerLink: startHandleLayerLink,
      endHandleLayerLink: endHandleLayerLink,
      backgroundCursorColor: backgroundCursorColor,
      showCursor: showCursor,
      forceLine: forceLine,
      readOnly: readOnly,
      hasFocus: hasFocus,
      maxLines: maxLines,
      minLines: minLines,
      expands: expands,
      strutStyle: strutStyle,
      selectionColor: selectionColor,
      textScaleFactor: textScaleFactor,
      textAlign: textAlign,
      textDirection: textDirection,
      locale: locale ?? Localizations.maybeLocaleOf(context),
      selection: value.selection,
      offset: offset,
      onCaretChanged: onCaretChanged,
      ignorePointer: rendererIgnoresPointer,
      obscuringCharacter: obscuringCharacter,
      obscureText: obscureText,
      textHeightBehavior: textHeightBehavior,
      textWidthBasis: textWidthBasis,
      cursorWidth: cursorWidth,
      cursorHeight: cursorHeight,
      cursorRadius: cursorRadius,
      cursorOffset: cursorOffset,
      paintCursorAboveText: paintCursorAboveText,
      selectionHeightStyle: selectionHeightStyle,
      selectionWidthStyle: selectionWidthStyle,
      enableInteractiveSelection: enableInteractiveSelection,
      textSelectionDelegate: textSelectionDelegate,
      devicePixelRatio: devicePixelRatio,
      promptRectRange: promptRectRange,
      promptRectColor: promptRectColor,
      clipBehavior: clipBehavior,
    );
  }

  @override
  void updateRenderObject(BuildContext context, RenderEditable renderObject) {
    renderObject
      ..text = inlineSpan
      ..cursorColor = cursorColor
      ..startHandleLayerLink = startHandleLayerLink
      ..endHandleLayerLink = endHandleLayerLink
      ..backgroundCursorColor = backgroundCursorColor
      ..showCursor = showCursor
      ..forceLine = forceLine
      ..readOnly = readOnly
      ..hasFocus = hasFocus
      ..maxLines = maxLines
      ..minLines = minLines
      ..expands = expands
      ..strutStyle = strutStyle
      ..selectionColor = selectionColor
      ..textScaleFactor = textScaleFactor
      ..textAlign = textAlign
      ..textDirection = textDirection
      ..locale = locale ?? Localizations.maybeLocaleOf(context)
      ..selection = value.selection
      ..offset = offset
      ..onCaretChanged = onCaretChanged
      ..ignorePointer = rendererIgnoresPointer
      ..textHeightBehavior = textHeightBehavior
      ..textWidthBasis = textWidthBasis
      ..obscuringCharacter = obscuringCharacter
      ..obscureText = obscureText
      ..cursorWidth = cursorWidth
      ..cursorHeight = cursorHeight
      ..cursorRadius = cursorRadius
      ..cursorOffset = cursorOffset
      ..selectionHeightStyle = selectionHeightStyle
      ..selectionWidthStyle = selectionWidthStyle
      ..enableInteractiveSelection = enableInteractiveSelection
      ..textSelectionDelegate = textSelectionDelegate
      ..devicePixelRatio = devicePixelRatio
      ..paintCursorAboveText = paintCursorAboveText
      ..promptRectColor = promptRectColor
      ..clipBehavior = clipBehavior
      ..setPromptRectRange(promptRectRange);
  }
}

@immutable
class _ScribbleCacheKey {
  const _ScribbleCacheKey({
    required this.inlineSpan,
    required this.textAlign,
    required this.textDirection,
    required this.textScaleFactor,
    required this.textHeightBehavior,
    required this.locale,
    required this.structStyle,
    required this.placeholder,
    required this.size,
  });

  final TextAlign textAlign;
  final TextDirection textDirection;
  final double textScaleFactor;
  final TextHeightBehavior? textHeightBehavior;
  final Locale? locale;
  final StrutStyle structStyle;
  final int placeholder;
  final Size size;
  final InlineSpan inlineSpan;

  RenderComparison compare(_ScribbleCacheKey other) {
    if (identical(other, this)) {
      return RenderComparison.identical;
    }
    final bool needsLayout = textAlign != other.textAlign ||
        textDirection != other.textDirection ||
        textScaleFactor != other.textScaleFactor ||
        (textHeightBehavior ?? const TextHeightBehavior()) !=
            (other.textHeightBehavior ?? const TextHeightBehavior()) ||
        locale != other.locale ||
        structStyle != other.structStyle ||
        placeholder != other.placeholder ||
        size != other.size;
    return needsLayout
        ? RenderComparison.layout
        : inlineSpan.compareTo(other.inlineSpan);
  }
}

class _ScribbleFocusable extends StatefulWidget {
  const _ScribbleFocusable({
    required this.child,
    required this.focusNode,
    required this.editableKey,
    required this.updateSelectionRects,
    required this.enabled,
  });

  final Widget child;
  final FocusNode focusNode;
  final GlobalKey editableKey;
  final VoidCallback updateSelectionRects;
  final bool enabled;

  @override
  _ScribbleFocusableState createState() => _ScribbleFocusableState();
}

class _ScribbleFocusableState extends State<_ScribbleFocusable>
    implements ScribbleClient {
  _ScribbleFocusableState()
      : _elementIdentifier = (_nextElementIdentifier++).toString();

  @override
  void initState() {
    super.initState();
    if (widget.enabled) {
      TextInput.registerScribbleElement(elementIdentifier, this);
    }
  }

  @override
  void didUpdateWidget(_ScribbleFocusable oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!oldWidget.enabled && widget.enabled) {
      TextInput.registerScribbleElement(elementIdentifier, this);
    }

    if (oldWidget.enabled && !widget.enabled) {
      TextInput.unregisterScribbleElement(elementIdentifier);
    }
  }

  @override
  void dispose() {
    TextInput.unregisterScribbleElement(elementIdentifier);
    super.dispose();
  }

  RenderEditable? get renderEditable =>
      widget.editableKey.currentContext?.findRenderObject() as RenderEditable?;

  static int _nextElementIdentifier = 1;
  final String _elementIdentifier;

  @override
  String get elementIdentifier => _elementIdentifier;

  @override
  void onScribbleFocus(Offset offset) {
    widget.focusNode.requestFocus();
    renderEditable?.selectPositionAt(
        from: offset, cause: SelectionChangedCause.scribble);
    widget.updateSelectionRects();
  }

  @override
  bool isInScribbleRect(Rect rect) {
    final Rect calculatedBounds = bounds;
    if (renderEditable?.readOnly ?? false) {
      return false;
    }
    if (calculatedBounds == Rect.zero) {
      return false;
    }
    if (!calculatedBounds.overlaps(rect)) {
      return false;
    }
    final Rect intersection = calculatedBounds.intersect(rect);
    final HitTestResult result = HitTestResult();
    WidgetsBinding.instance.hitTest(result, intersection.center);
    return result.path
        .any((HitTestEntry entry) => entry.target == renderEditable);
  }

  @override
  Rect get bounds {
    final RenderBox? box = context.findRenderObject() as RenderBox?;
    if (box == null || !mounted || !box.attached) {
      return Rect.zero;
    }
    final Matrix4 transform = box.getTransformTo(null);
    return MatrixUtils.transformRect(
        transform, Rect.fromLTWH(0, 0, box.size.width, box.size.height));
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

class _ScribblePlaceholder extends WidgetSpan {
  const _ScribblePlaceholder({
    required super.child,
    super.alignment,
    super.baseline,
    required this.size,
  })  : assert(child != null),
        assert(baseline != null ||
            !(identical(alignment, ui.PlaceholderAlignment.aboveBaseline) ||
                identical(alignment, ui.PlaceholderAlignment.belowBaseline) ||
                identical(alignment, ui.PlaceholderAlignment.baseline)));

  final Size size;

  @override
  void build(ui.ParagraphBuilder builder,
      {double textScaleFactor = 1.0, List<PlaceholderDimensions>? dimensions}) {
    assert(debugAssertIsValid());
    final bool hasStyle = style != null;
    if (hasStyle) {
      builder.pushStyle(style!.getTextStyle(textScaleFactor: textScaleFactor));
    }
    builder.addPlaceholder(
      size.width,
      size.height,
      alignment,
      scale: textScaleFactor,
    );
    if (hasStyle) {
      builder.pop();
    }
  }
}

class _CodeUnitBoundary extends TextBoundary {
  const _CodeUnitBoundary(this._text);

  final String _text;

  @override
  TextPosition getLeadingTextBoundaryAt(TextPosition position) {
    if (position.offset <= 0) {
      return const TextPosition(offset: 0);
    }
    if (position.offset > _text.length ||
        (position.offset == _text.length &&
            position.affinity == TextAffinity.downstream)) {
      return TextPosition(
          offset: _text.length, affinity: TextAffinity.upstream);
    }
    switch (position.affinity) {
      case TextAffinity.upstream:
        return TextPosition(
            offset: math.min(position.offset - 1, _text.length));
      case TextAffinity.downstream:
        return TextPosition(offset: math.min(position.offset, _text.length));
    }
  }

  @override
  TextPosition getTrailingTextBoundaryAt(TextPosition position) {
    if (position.offset < 0 ||
        (position.offset == 0 && position.affinity == TextAffinity.upstream)) {
      return const TextPosition(offset: 0);
    }
    if (position.offset >= _text.length) {
      return TextPosition(
          offset: _text.length, affinity: TextAffinity.upstream);
    }
    switch (position.affinity) {
      case TextAffinity.upstream:
        return TextPosition(
            offset: math.min(position.offset, _text.length),
            affinity: TextAffinity.upstream);
      case TextAffinity.downstream:
        return TextPosition(
            offset: math.min(position.offset + 1, _text.length),
            affinity: TextAffinity.upstream);
    }
  }
}

// ------------------------  Text Boundary Combinators ------------------------

// A _TextBoundary that creates a [TextRange] where its start is from the
// specified leading text boundary and its end is from the specified trailing
// text boundary.
class _MixedBoundary extends TextBoundary {
  _MixedBoundary(this.leadingTextBoundary, this.trailingTextBoundary);

  final TextBoundary leadingTextBoundary;
  final TextBoundary trailingTextBoundary;

  @override
  TextPosition getLeadingTextBoundaryAt(TextPosition position) =>
      leadingTextBoundary.getLeadingTextBoundaryAt(position);

  @override
  TextPosition getTrailingTextBoundaryAt(TextPosition position) =>
      trailingTextBoundary.getTrailingTextBoundaryAt(position);
}

// -------------------------------  Text Actions -------------------------------
class _DeleteTextAction<T extends DirectionalTextEditingIntent>
    extends ContextAction<T> {
  _DeleteTextAction(this.state, this.getTextBoundariesForIntent);

  final EditableTextState state;
  final TextBoundary Function(T intent) getTextBoundariesForIntent;

  TextRange _expandNonCollapsedRange(TextEditingValue value) {
    final TextRange selection = value.selection;
    assert(selection.isValid);
    assert(!selection.isCollapsed);
    final TextBoundary atomicBoundary = state.widget.obscureText
        ? _CodeUnitBoundary(value.text)
        : CharacterBoundary(value.text);

    return TextRange(
      start: atomicBoundary
          .getLeadingTextBoundaryAt(TextPosition(offset: selection.start))
          .offset,
      end: atomicBoundary
          .getTrailingTextBoundaryAt(TextPosition(offset: selection.end - 1))
          .offset,
    );
  }

  @override
  Object? invoke(T intent, [BuildContext? context]) {
    final TextSelection selection = state._value.selection;
    assert(selection.isValid);

    if (!selection.isCollapsed) {
      return Actions.invoke(
        context!,
        ReplaceTextIntent(
            state._value,
            '',
            _expandNonCollapsedRange(state._value),
            SelectionChangedCause.keyboard),
      );
    }

    final TextBoundary textBoundary = getTextBoundariesForIntent(intent);
    if (!state._value.selection.isValid) {
      return null;
    }
    if (!state._value.selection.isCollapsed) {
      return Actions.invoke(
        context!,
        ReplaceTextIntent(
            state._value,
            '',
            _expandNonCollapsedRange(state._value),
            SelectionChangedCause.keyboard),
      );
    }

    return Actions.invoke(
      context!,
      ReplaceTextIntent(
        state._value,
        '',
        textBoundary.getTextBoundaryAt(state._value.selection.base),
        SelectionChangedCause.keyboard,
      ),
    );
  }

  @override
  bool get isActionEnabled =>
      !state.widget.readOnly && state._value.selection.isValid;
}

class _UpdateTextSelectionAction<T extends DirectionalCaretMovementIntent>
    extends ContextAction<T> {
  _UpdateTextSelectionAction(
    this.state,
    this.ignoreNonCollapsedSelection,
    this.getTextBoundariesForIntent,
  );

  final EditableTextState state;
  final bool ignoreNonCollapsedSelection;
  final TextBoundary Function(T intent) getTextBoundariesForIntent;

  static const int NEWLINE_CODE_UNIT = 10;

  // Returns true iff the given position is at a wordwrap boundary in the
  // upstream position.
  bool _isAtWordwrapUpstream(TextPosition position) {
    final TextPosition end = TextPosition(
      offset: state.renderEditable.getLineAtOffset(position).end,
      affinity: TextAffinity.upstream,
    );
    return end == position &&
        end.offset != state.textEditingValue.text.length &&
        state.textEditingValue.text.codeUnitAt(position.offset) !=
            NEWLINE_CODE_UNIT;
  }

  // Returns true if the given position at a wordwrap boundary in the
  // downstream position.
  bool _isAtWordwrapDownstream(TextPosition position) {
    final TextPosition start = TextPosition(
      offset: state.renderEditable.getLineAtOffset(position).start,
    );
    return start == position &&
        start.offset != 0 &&
        state.textEditingValue.text.codeUnitAt(position.offset - 1) !=
            NEWLINE_CODE_UNIT;
  }

  @override
  Object? invoke(T intent, [BuildContext? context]) {
    final TextSelection selection = state._value.selection;
    assert(selection.isValid);

    final bool collapseSelection =
        intent.collapseSelection || !state.widget.selectionEnabled;
    // Collapse to the logical start/end.
    TextSelection collapse(TextSelection selection) {
      assert(selection.isValid);
      assert(!selection.isCollapsed);
      return selection.copyWith(
        baseOffset: intent.forward ? selection.end : selection.start,
        extentOffset: intent.forward ? selection.end : selection.start,
      );
    }

    if (!selection.isCollapsed &&
        !ignoreNonCollapsedSelection &&
        collapseSelection) {
      return Actions.invoke(
        context!,
        UpdateSelectionIntent(
            state._value, collapse(selection), SelectionChangedCause.keyboard),
      );
    }

    final TextBoundary textBoundary = getTextBoundariesForIntent(intent);

    TextPosition extent = selection.extent;
    // If continuesAtWrap is true extent and is at the relevant wordwrap, then
    // move it just to the other side of the wordwrap.
    if (intent.continuesAtWrap) {
      if (intent.forward && _isAtWordwrapUpstream(extent)) {
        extent = TextPosition(
          offset: extent.offset,
        );
      } else if (!intent.forward && _isAtWordwrapDownstream(extent)) {
        extent = TextPosition(
          offset: extent.offset,
          affinity: TextAffinity.upstream,
        );
      }
    }

    final TextPosition newExtent = intent.forward
        ? textBoundary.getTrailingTextBoundaryAt(extent)
        : textBoundary.getLeadingTextBoundaryAt(extent);
    final TextSelection newSelection = collapseSelection
        ? TextSelection.fromPosition(newExtent)
        : selection.extendTo(newExtent);

    // If collapseAtReversal is true and would have an effect, collapse it.
    if (!selection.isCollapsed &&
        intent.collapseAtReversal &&
        (selection.baseOffset < selection.extentOffset !=
            newSelection.baseOffset < newSelection.extentOffset)) {
      return Actions.invoke(
        context!,
        UpdateSelectionIntent(
          state._value,
          TextSelection.fromPosition(selection.base),
          SelectionChangedCause.keyboard,
        ),
      );
    }

    return Actions.invoke(
      context!,
      UpdateSelectionIntent(
          state._value, newSelection, SelectionChangedCause.keyboard),
    );
  }

  @override
  bool get isActionEnabled => state._value.selection.isValid;
}

class _ExtendSelectionOrCaretPositionAction extends ContextAction<
    ExtendSelectionToNextWordBoundaryOrCaretLocationIntent> {
  _ExtendSelectionOrCaretPositionAction(
      this.state, this.getTextBoundariesForIntent);

  final EditableTextState state;
  final TextBoundary Function(
          ExtendSelectionToNextWordBoundaryOrCaretLocationIntent intent)
      getTextBoundariesForIntent;

  @override
  Object? invoke(ExtendSelectionToNextWordBoundaryOrCaretLocationIntent intent,
      [BuildContext? context]) {
    final TextSelection selection = state._value.selection;
    assert(selection.isValid);

    final TextBoundary textBoundary = getTextBoundariesForIntent(intent);
    final TextSelection textBoundarySelection = state._value.selection;
    if (!textBoundarySelection.isValid) {
      return null;
    }

    final TextPosition extent = textBoundarySelection.extent;
    final TextPosition newExtent = intent.forward
        ? textBoundary.getTrailingTextBoundaryAt(extent)
        : textBoundary.getLeadingTextBoundaryAt(extent);

    final TextSelection newSelection =
        (newExtent.offset - textBoundarySelection.baseOffset) *
                    (textBoundarySelection.extentOffset -
                        textBoundarySelection.baseOffset) <
                0
            ? textBoundarySelection.copyWith(
                extentOffset: textBoundarySelection.baseOffset,
                affinity: textBoundarySelection.extentOffset >
                        textBoundarySelection.baseOffset
                    ? TextAffinity.downstream
                    : TextAffinity.upstream,
              )
            : textBoundarySelection.extendTo(newExtent);

    return Actions.invoke(
      context!,
      UpdateSelectionIntent(
          state._value, newSelection, SelectionChangedCause.keyboard),
    );
  }

  @override
  bool get isActionEnabled =>
      state.widget.selectionEnabled && state._value.selection.isValid;
}

class _UpdateTextSelectionVerticallyAction<
    T extends DirectionalCaretMovementIntent> extends ContextAction<T> {
  _UpdateTextSelectionVerticallyAction(this.state);

  final EditableTextState state;

  VerticalCaretMovementRun? _verticalMovementRun;
  TextSelection? _runSelection;

  void stopCurrentVerticalRunIfSelectionChanges() {
    final TextSelection? runSelection = _runSelection;
    if (runSelection == null) {
      assert(_verticalMovementRun == null);
      return;
    }
    _runSelection = state._value.selection;
    final TextSelection currentSelection = state.widget.controller.selection;
    final bool continueCurrentRun = currentSelection.isValid &&
        currentSelection.isCollapsed &&
        currentSelection.baseOffset == runSelection.baseOffset &&
        currentSelection.extentOffset == runSelection.extentOffset;
    if (!continueCurrentRun) {
      _verticalMovementRun = null;
      _runSelection = null;
    }
  }

  @override
  void invoke(T intent, [BuildContext? context]) {
    assert(state._value.selection.isValid);

    final bool collapseSelection =
        intent.collapseSelection || !state.widget.selectionEnabled;
    final TextEditingValue value = state._textEditingValueforTextLayoutMetrics;
    if (!value.selection.isValid) {
      return;
    }

    if (_verticalMovementRun?.isValid == false) {
      _verticalMovementRun = null;
      _runSelection = null;
    }

    final VerticalCaretMovementRun currentRun = _verticalMovementRun ??
        state.renderEditable
            .startVerticalCaretMovement(state.renderEditable.selection!.extent);

    final bool shouldMove = intent
            is ExtendSelectionVerticallyToAdjacentPageIntent
        ? currentRun.moveByOffset(
            (intent.forward ? 1.0 : -1.0) * state.renderEditable.size.height)
        : intent.forward
            ? currentRun.moveNext()
            : currentRun.movePrevious();
    final TextPosition newExtent = shouldMove
        ? currentRun.current
        : intent.forward
            ? TextPosition(offset: state._value.text.length)
            : const TextPosition(offset: 0);
    final TextSelection newSelection = collapseSelection
        ? TextSelection.fromPosition(newExtent)
        : value.selection.extendTo(newExtent);

    Actions.invoke(
      context!,
      UpdateSelectionIntent(
          value, newSelection, SelectionChangedCause.keyboard),
    );
    if (state._value.selection == newSelection) {
      _verticalMovementRun = currentRun;
      _runSelection = newSelection;
    }
  }

  @override
  bool get isActionEnabled => state._value.selection.isValid;
}

class _SelectAllAction extends ContextAction<SelectAllTextIntent> {
  _SelectAllAction(this.state);

  final EditableTextState state;

  @override
  Object? invoke(SelectAllTextIntent intent, [BuildContext? context]) {
    return Actions.invoke(
      context!,
      UpdateSelectionIntent(
        state._value,
        TextSelection(baseOffset: 0, extentOffset: state._value.text.length),
        intent.cause,
      ),
    );
  }

  @override
  bool get isActionEnabled => state.widget.selectionEnabled;
}

class _CopySelectionAction extends ContextAction<CopySelectionTextIntent> {
  _CopySelectionAction(this.state);

  final EditableTextState state;

  @override
  void invoke(CopySelectionTextIntent intent, [BuildContext? context]) {
    if (intent.collapseSelection) {
      state.cutSelection(intent.cause);
    } else {
      state.copySelection(intent.cause);
    }
  }

  @override
  bool get isActionEnabled =>
      state._value.selection.isValid && !state._value.selection.isCollapsed;
}

@visibleForTesting
typedef TextEditingValueCallback = void Function(TextEditingValue value);

class _TextEditingHistory extends StatefulWidget {
  const _TextEditingHistory({
    required this.child,
    required this.controller,
    required this.onTriggered,
  });

  final Widget child;

  final TextEditingController controller;

  final TextEditingValueCallback onTriggered;

  @override
  State<_TextEditingHistory> createState() => _TextEditingHistoryState();
}

class _TextEditingHistoryState extends State<_TextEditingHistory> {
  final _UndoStack<TextEditingValue> _stack = _UndoStack<TextEditingValue>();
  late final _Throttled<TextEditingValue> _throttledPush;
  Timer? _throttleTimer;

  // This duration was chosen as a best fit for the behavior of Mac, Linux,
  // and Windows undo/redo state save durations, but it is not perfect for any
  // of them.
  static const Duration _kThrottleDuration = Duration(milliseconds: 500);

  void _undo(UndoTextIntent intent) {
    _update(_stack.undo());
  }

  void _redo(RedoTextIntent intent) {
    _update(_stack.redo());
  }

  void _update(TextEditingValue? nextValue) {
    if (nextValue == null) {
      return;
    }
    if (nextValue.text == widget.controller.text) {
      return;
    }
    widget.onTriggered(widget.controller.value.copyWith(
      text: nextValue.text,
      selection: nextValue.selection,
    ));
  }

  void _push() {
    if (widget.controller.value == TextEditingValue.empty) {
      return;
    }

    switch (defaultTargetPlatform) {
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        // Composing text is not counted in history coalescing.
        if (!widget.controller.value.composing.isCollapsed) {
          return;
        }
        break;
      case TargetPlatform.android:
        // Gboard on Android puts non-CJK words in composing regions. Coalesce
        // composing text in order to allow the saving of partial words in that
        // case.
        break;
    }

    _throttleTimer = _throttledPush(widget.controller.value);
  }

  @override
  void initState() {
    super.initState();
    _throttledPush = _throttle<TextEditingValue>(
      duration: _kThrottleDuration,
      function: _stack.push,
    );
    _push();
    widget.controller.addListener(_push);
  }

  @override
  void didUpdateWidget(_TextEditingHistory oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      _stack.clear();
      oldWidget.controller.removeListener(_push);
      widget.controller.addListener(_push);
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(_push);
    _throttleTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Actions(
      actions: <Type, Action<Intent>>{
        UndoTextIntent: Action<UndoTextIntent>.overridable(
            context: context,
            defaultAction: CallbackAction<UndoTextIntent>(onInvoke: _undo)),
        RedoTextIntent: Action<RedoTextIntent>.overridable(
            context: context,
            defaultAction: CallbackAction<RedoTextIntent>(onInvoke: _redo)),
      },
      child: widget.child,
    );
  }
}

class _UndoStack<T> {
  _UndoStack();

  final List<T> _list = <T>[];

  // The index of the current value, or null if the list is emtpy.
  late int _index;

  T? get currentValue => _list.isEmpty ? null : _list[_index];

  void push(T value) {
    if (_list.isEmpty) {
      _index = 0;
      _list.add(value);
      return;
    }

    assert(_index < _list.length && _index >= 0);

    if (value == currentValue) {
      return;
    }

    // If anything has been undone in this stack, remove those irrelevant states
    // before adding the new one.
    if (_index != null && _index != _list.length - 1) {
      _list.removeRange(_index + 1, _list.length);
    }
    _list.add(value);
    _index = _list.length - 1;
  }

  T? undo() {
    if (_list.isEmpty) {
      return null;
    }

    assert(_index < _list.length && _index >= 0);

    if (_index != 0) {
      _index = _index - 1;
    }

    return currentValue;
  }

  T? redo() {
    if (_list.isEmpty) {
      return null;
    }

    assert(_index < _list.length && _index >= 0);

    if (_index < _list.length - 1) {
      _index = _index + 1;
    }

    return currentValue;
  }

  void clear() {
    _list.clear();
    _index = -1;
  }

  @override
  String toString() {
    return '_UndoStack $_list';
  }
}

typedef _Throttleable<T> = void Function(T currentArg);

typedef _Throttled<T> = Timer Function(T currentArg);

_Throttled<T> _throttle<T>({
  required Duration duration,
  required _Throttleable<T> function,
  // If true, calls at the start of the timer.
  bool leadingEdge = false,
}) {
  Timer? timer;
  bool calledDuringTimer = false;
  late T arg;

  return (T currentArg) {
    arg = currentArg;
    if (timer != null) {
      calledDuringTimer = true;
      return timer!;
    }
    if (leadingEdge) {
      function(arg);
    }
    calledDuringTimer = false;
    timer = Timer(duration, () {
      if (!leadingEdge || calledDuringTimer) {
        function(arg);
      }
      timer = null;
    });
    return timer!;
  };
}

@immutable
class _GlyphHeights {
  const _GlyphHeights({
    required this.start,
    required this.end,
  });

  final double start;

  final double end;
}
