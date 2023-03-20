import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nobook/src/features/features_barrel.dart' show Note;
import 'package:nobook/src/features/notes/subfeatures/document_editing/subfeatures/drawing/drawing_barrel.dart';
import 'package:nobook/src/features/notes/subfeatures/document_editing/ui/toolbar/toolbar_barrel.dart'
    show ToolBarWidget, ToolbarController;
import 'package:nobook/src/global/global_barrel.dart';
import 'package:nobook/src/utils/function/extensions/extensions.dart';

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
    return Material(
      child: Center(
        child: Column(
          children: [
            20.boxHeight,
            ToolBarWidget(controller: toolbarController),
            20.boxHeight,
            ChangeNotifierBuilder<ToolbarController>(
              listenable: toolbarController,
              // buildWhen: (previous, next) =>
              //     previous?.drawingController == next.drawingController,
              builder: (_, controller) {
                print('drawing controller changed');
                return Container(
                  color: AppColors.subjectOrange,
                  child: DrawingCanvas(
                    controller: controller.drawingController,
                    size: Size(
                      900.w,
                      600.h,
                    ),
                  ),
                );
              },
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

  late final ToolbarController toolbarController = ToolbarController(
    note: widget.note,
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
