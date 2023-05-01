import 'package:flutter/material.dart';
import 'package:nobook/src/features/notes/subfeatures/document_editing/subfeatures/text_editor/text_editor_barrel.dart';
import 'package:nobook/src/global/global_barrel.dart';

class TextEditingCanvas extends StatefulWidget {
  final TextEditorController controller;
  final bool readOnly;

  const TextEditingCanvas({
    Key? key,
    this.readOnly = false,
    required this.controller,
  }) : super(key: key);

  @override
  State<TextEditingCanvas> createState() => _TextEditingCanvasState();
}

class _TextEditingCanvasState extends State<TextEditingCanvas> {
  late TextEditorController controller = widget.controller;

  @override
  void didUpdateWidget(TextEditingCanvas oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      controller = widget.controller;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.grey100,
      child: ValueListenableBuilder<TextEditingValue>(
        valueListenable: controller,
        builder: (_, controllerValue, __) {
          return TextField(
            key: UniqueKey(),
            controller: controller,
            enabled: !widget.readOnly,
            keyboardType: TextInputType.multiline,
            textAlign: controller.metadata?.alignment ?? TextAlign.start,
            style: TextEditorController.defaultMetadata.style,
            decoration: const InputDecoration(
              border: InputBorder.none,
            ),
            smartDashesType: SmartDashesType.enabled,
            maxLines: null,
          );
        },
      ),
    );
  }
}
