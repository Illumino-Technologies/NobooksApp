import 'package:flutter/material.dart';
import 'package:nobook/src/features/notes/subfeatures/document_editing/document_editing_barrel.dart';
import 'package:nobook/src/global/ui/ui_barrel.dart';
import 'package:nobook/src/utils/utils_barrel.dart';

class DocumentEditorCanvas extends StatefulWidget {
  final Size canvasSize;
  final NoteDocumentController controller;
  final bool readOnly;

  const DocumentEditorCanvas({
    Key? key,
    this.readOnly = false,
    required this.canvasSize,
    required this.controller,
  }) : super(key: key);

  @override
  State<DocumentEditorCanvas> createState() => _DocumentEditorCanvasState();
}

class _DocumentEditorCanvasState extends State<DocumentEditorCanvas> {
  late NoteDocumentController controller = widget.controller;

  @override
  void didUpdateWidget(DocumentEditorCanvas oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      controller = widget.controller;
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.readOnly
        ? ListenableBuilder(
            listenable: controller,
            builder: (context) {
              return Stack(
                children: [
                  buildDrawingCanvas(controller),
                  buildTextEditingCanvas(controller),
                ],
              );
            },
          )
        : ChangeNotifierBuilder<NoteDocumentController>(
            listenable: controller,
            builder: (context, controller) {
              reshuffleCanvasBuildersWithLast(
                controller.activeController.runtimeType,
              );
              removeFocusIfExists(context);
              return Stack(
                children: controllerStack.map<Widget>((e) {
                  return canvasBuilderFor(e).call(controller);
                }).toList(),
              );
            },
          );
  }

  Widget buildTextEditingCanvas(NoteDocumentController controller) {
    return TextEditingCanvas(
      readOnly: widget.readOnly,
      controller: controller.textController,
      size: widget.readOnly ? null : widget.canvasSize,
    );
  }

  Widget buildDrawingCanvas(NoteDocumentController controller) {
    return DrawingCanvas(
      readOnly: widget.readOnly,
      controller: controller.drawingController,
      size: widget.canvasSize,
    );
  }

  Widget Function(NoteDocumentController) canvasBuilderFor(
    Type controllerType,
  ) {
    if (controllerType == DrawingController) {
      return buildDrawingCanvas;
    } else if (controllerType == TextEditorController) {
      return buildTextEditingCanvas;
    } else {
      throw Exception('No canvas builder found for active controller');
    }
  }

  void removeFocusIfExists(BuildContext context) {
    if (controllerStack.lastOrNull == TextEditorController) return;
    final FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  final List<Type> controllerStack = [
    DrawingController,
    TextEditorController,
  ];

  void reshuffleCanvasBuildersWithLast(Type lastControllerType) {
    if (lastControllerType == controllerStack.last) return;

    controllerStack.remove(lastControllerType);
    controllerStack.add(lastControllerType);
  }
}
