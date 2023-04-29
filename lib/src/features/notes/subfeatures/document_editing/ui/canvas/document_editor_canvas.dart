import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nobook/src/features/notes/subfeatures/document_editing/document_editing_barrel.dart';
import 'package:nobook/src/global/ui/ui_barrel.dart';
import 'package:nobook/src/utils/utils_barrel.dart';

class DocumentEditorCanvas extends StatefulWidget {
  final Size canvasSize;
  final NoteDocumentController controller;

  const DocumentEditorCanvas({
    Key? key,
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
    return SizedBox.fromSize(
      size: widget.canvasSize,
      child: ChangeNotifierBuilder<NoteDocumentController>(
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
      ),
    );
  }

  final Size canvasSize = Size(900.w, 546.h);

  Widget buildTextEditingCanvas(NoteDocumentController controller) {
    return TextEditingCanvas(
      controller: controller.textController,
    );
  }

  Widget buildDrawingCanvas(NoteDocumentController controller) {
    return DrawingCanvas(
      controller: controller.drawingController,
      size: Size(
        900.w,
        600.h,
      ),
    );
  }

  Widget Function(NoteDocumentController) canvasBuilderFor(Type controllerType) {
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
