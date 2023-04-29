import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nobook/src/features/features_barrel.dart' show Note;
import 'package:nobook/src/features/notes/subfeatures/document_editing/document_editing_barrel.dart';
import 'package:nobook/src/features/notes/subfeatures/document_editing/ui/toolbar/ioc/toolbar_inherited_widget.dart';
import 'package:nobook/src/global/global_barrel.dart';
import 'package:nobook/src/utils/function/extensions/extensions.dart';
import 'package:nobook/src/utils/utils_barrel.dart';

class NoteDetailPage extends StatelessWidget {
  final Note note;

  const NoteDetailPage({
    super.key,
    required this.note,
  });

  @override
  Widget build(BuildContext context) {
    return true ? NoteDetailPageX(note: note) : Container();
  }
}

class NoteDetailPageX extends ConsumerStatefulWidget {
  final Note note;

  const NoteDetailPageX({
    super.key,
    required this.note,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NotePageState();
}

class _NotePageState extends ConsumerState<NoteDetailPageX> {
  final double drawingBoundsVertical = 500;
  final double drawingBoundsHorizontal = 600;

  @override
  Widget build(BuildContext context) {
    return NoteDocumentContainer(
      controller: toolbarController,
      child: Material(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    20.boxHeight,
                    ToolBarWidget(controller: toolbarController),
                    20.boxHeight,
                    MaterialButton(
                      onPressed: () {
                        toolbarController.clear();
                      },
                      child: const Icon(Icons.delete),
                    ),
                    20.boxHeight,
                    DocumentEditorCanvas(
                      canvasSize: Size(900.w, 546.h),
                      controller: toolbarController,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 32.w),
              alignment: Alignment.centerRight,
              child: ChangeNotifierBuilder<NoteDocumentController>(
                listenable: toolbarController,
                builder: (_, controllerValue) {
                  return controllerValue.showingRoughPaper
                      ? RoughPaper(
                          onClose: () =>
                              controllerValue.toggleRoughPaper(false),
                          size: Size(400.w, 528.h),
                        )
                      : const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void changeColor(Color color) {
    controller.changeColor(color);
  }

  final DrawingController controller = DrawingController();
  final ValueNotifier<bool> erasingNotifier = ValueNotifier<bool>(false);

  void erasingCheckingCallback() {
    final bool isCurrentlyErasing = controller.drawingMode == DrawingMode.erase;

    if (isCurrentlyErasing ^ erasingNotifier.value) {
      erasingNotifier.value = isCurrentlyErasing;
    }
  }

  late final NoteDocumentController toolbarController = NoteDocumentController(
    note: widget.note.noteBody,
  );

  @override
  void initState() {
    controller.initialize();
    toolbarController.initialize();

    controller.addListener(erasingCheckingCallback);

    super.initState();
  }

  @override
  void dispose() {
    controller.removeListener(erasingCheckingCallback);
    controller.dispose();
    erasingNotifier.dispose();
    toolbarController.dispose();

    super.dispose();
  }
}
