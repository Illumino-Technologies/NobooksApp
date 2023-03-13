import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nobook/src/features/features_barrel.dart' show Note;
import 'package:nobook/src/features/notes/subfeatures/document_editing/drawing/drawing_barrel.dart';
import 'package:nobook/src/features/notes/subfeatures/note_detail/view/drawing_canvas.dart';
import 'package:nobook/src/features/notes/subfeatures/note_detail/view/drawing_controller.dart';
import 'package:nobook/src/features/notes/subfeatures/note_detail/view/toolbar/toolbar_barrel.dart';
import 'package:nobook/src/global/global_barrel.dart';
import 'package:nobook/src/utils/function/extensions/extensions.dart';

class NoteDetailPage extends ConsumerStatefulWidget {
  final Note note;

  const NoteDetailPage({
    super.key,
    required this.note,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NotePageState();
}

class _NotePageState extends ConsumerState<NoteDetailPage> {
  final double drawingBoundsVertical = 500;
  final double drawingBoundsHorizontal = 600;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Column(
          children: [
            // FilledButton.tonal(
            //   onPressed: () {
            //     controller.clearDrawings();
            //   },
            //   child: const Text('clear'),
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     ChangeNotifierBuilder<DrawingController>(
            //       listenable: controller,
            //       buildWhen: (previous, next) =>
            //           previous?.drawings != next.drawings,
            //       builder: (_, controller) {
            //         return ValueListenableBuilder<bool>(
            //           valueListenable: erasingNotifier,
            //           builder: (_, erasing, __) {
            //             return FilledButton.tonal(
            //               onPressed: (controller.drawings.isEmpty && !erasing)
            //                   ? null
            //                   : () {
            //                       controller.changeEraseMode(EraseMode.drawing);
            //                       controller.toggleErase();
            //                     },
            //               child: Text(
            //                 erasing
            //                     ? 'stop erasing drawing'
            //                     : 'start erase drawing',
            //               ),
            //             );
            //           },
            //         );
            //       },
            //     ),
            //     20.boxWidth,
            //     ChangeNotifierBuilder<DrawingController>(
            //       listenable: controller,
            //       buildWhen: (previous, next) =>
            //           previous?.drawings != next.drawings,
            //       builder: (_, controller) {
            //         return ValueListenableBuilder<bool>(
            //           valueListenable: erasingNotifier,
            //           builder: (_, erasing, __) {
            //             return FilledButton.tonal(
            //               onPressed: (controller.drawings.isEmpty && !erasing)
            //                   ? null
            //                   : () {
            //                       controller.changeEraseMode(EraseMode.area);
            //                       controller.toggleErase();
            //                     },
            //               child: Text(
            //                 erasing ? 'stop erasing area' : 'start erase area',
            //               ),
            //             );
            //           },
            //         );
            //       },
            //     ),
            //   ],
            // ),
            // 20.boxHeight,
            // ChangeNotifierBuilder(
            //   listenable: controller,
            //   buildWhen: (previous, next) =>
            //       previous?.metadataFor() == next.metadataFor(),
            //   builder: (_, notifier) {
            //     final DrawingMetadata metadata = notifier.metadataFor();
            //     return Row(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: [
            //         ...ChangeColor.values.map(
            //           (e) => Container(
            //             decoration: BoxDecoration(
            //               border: metadata.color == e.color
            //                   ? Border.all(
            //                       color: e.color,
            //                       width: 2,
            //                     )
            //                   : null,
            //             ),
            //             margin: EdgeInsets.only(left: 30.w),
            //             padding: const EdgeInsets.all(5),
            //             child: InkWell(
            //               onTap: () => changeColor(e.color),
            //               child: Container(
            //                 width: 50,
            //                 height: 50,
            //                 color: e.color,
            //               ),
            //             ),
            //           ),
            //         )
            //       ],
            //     );
            //   },
            // ),
            // 20.boxHeight,
            // ChangeNotifierBuilder(
            //   listenable: controller,
            //   buildWhen: (previous, next) =>
            //       previous?.drawingMode == next.drawingMode,
            //   builder: (_, value) {
            //     return Row(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: [
            //         Container(
            //           padding: const EdgeInsets.symmetric(horizontal: 4),
            //           decoration: BoxDecoration(
            //             borderRadius: Ui.allBorderRadius(50),
            //             border: value.drawingMode == DrawingMode.sketch
            //                 ? Border.all(
            //                     color: AppColors.blue500,
            //                     width: 2,
            //                   )
            //                 : null,
            //           ),
            //           child: FilledButton.tonal(
            //             onPressed: () {
            //               controller.changeDrawingMode(DrawingMode.sketch);
            //             },
            //             child: const Text('Sketch mode'),
            //           ),
            //         ),
            //         30.boxWidth,
            //         Container(
            //           padding: const EdgeInsets.symmetric(horizontal: 4),
            //           decoration: BoxDecoration(
            //             borderRadius: Ui.allBorderRadius(50),
            //             border: value.drawingMode == DrawingMode.shape
            //                 ? Border.all(
            //                     color: AppColors.blue500,
            //                     width: 2,
            //                   )
            //                 : null,
            //           ),
            //           child: FilledButton.tonal(
            //             onPressed: () {
            //               controller.changeDrawingMode(DrawingMode.shape);
            //             },
            //             child: const Text('Shape mode'),
            //           ),
            //         ),
            //       ],
            //     );
            //   },
            // ),
            // 20.boxHeight,
            // ChangeNotifierBuilder(
            //   listenable: controller,
            //   buildWhen: (previous, next) => previous?.shape == next.shape,
            //   builder: (_, value) {
            //     return Row(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: [
            //         ...Shape.values.map(
            //           (e) => IconButton(
            //             onPressed: () => controller.changeShape(e),
            //             icon: Icon(
            //               e.iconData,
            //               color: value.shape == e ? AppColors.blue500 : null,
            //             ),
            //           ),
            //         )
            //       ],
            //     );
            //   },
            // ),
            20.boxHeight,
            ToolBarWidget(controller: toolbarController),
            20.boxHeight,
            ChangeNotifierBuilder<ToolbarController>(
              listenable: toolbarController,
              builder: (_, drawingController) {
                return Container(
                  color: AppColors.subjectOrange,
                  child: DrawingCanvas(
                    controller: drawingController.drawingController,
                    size: Size(
                      700.w,
                      400.h,
                    ),
                  ),
                );
              },
            ),

            // Container(
            //   color: AppColors.subjectOrange.withOpacity(0.4),
            //   width: drawingBoundsHorizontal,
            //   height: drawingBoundsVertical,
            //   child: DrawingCanvas(
            //     controller: controller,
            //     size: Size(drawingBoundsHorizontal, drawingBoundsVertical),
            //   ),
            // ),
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

  final ToolbarController toolbarController = ToolbarController();

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
