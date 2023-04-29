import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nobook/src/features/notes/subfeatures/document_editing/subfeatures/text_editor/text_editor_barrel.dart';
import 'package:nobook/src/global/ui/ui_barrel.dart';

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
      height: 900.h,
      color: AppColors.backgroundBlack.withOpacity(0.04),
      child: ValueListenableBuilder<TextEditingValue>(
        valueListenable: controller,
        builder: (_, controllerValue, __) {
          return TextField(
            controller: controller,
            enabled: !widget.readOnly,
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
