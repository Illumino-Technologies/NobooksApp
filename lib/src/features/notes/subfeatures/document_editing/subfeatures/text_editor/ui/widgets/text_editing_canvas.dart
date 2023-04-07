import 'package:flutter/material.dart';
import 'package:nobook/src/features/notes/subfeatures/document_editing/subfeatures/text_editor/text_editor_barrel.dart';
import 'package:nobook/src/global/ui/ui_barrel.dart';
import 'package:nobook/src/utils/utils_barrel.dart';

class TextEditingCanvas extends StatefulWidget {
  final TextEditorController controller;

  const TextEditingCanvas({
    Key? key,
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
    return SizedBox(
      height: 900,
      child: Column(
        children: [
          20.boxHeight,
          SizedBox(
            height: 300,
            child: ValueListenableBuilder<TextEditingValue>(
              valueListenable: controller,
              builder: (_, controllerValue, __) {
                return TextField(
                  showCursor: false,
                  textAlign: controller.metadata?.alignment ?? TextAlign.start,
                  style: TextEditorController.defaultMetadata.style,
                  controller: controller,
                  maxLines: null,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
