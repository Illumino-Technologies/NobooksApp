import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nobook/src/features/features_barrel.dart' show Note;
import 'package:nobook/src/features/notes/subfeatures/document_editing/model/all_models.dart';
import 'package:nobook/src/features/notes/subfeatures/document_editing/model/document_editor_model.dart';
import 'package:nobook/src/features/notes/subfeatures/note_detail/view/drawing_controller.dart';
import 'package:nobook/src/global/global_barrel.dart';
import 'package:nobook/src/global/ui/widgets/custom/value_listenables/change_notifier_builder.dart';
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
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Column(
          children: [
            FilledButton.tonal(
              onPressed: () {
                controller.clearDrawings();
              },
              child: const Text('clear'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ChangeNotifierBuilder<DrawingController>(
                  listenable: controller,
                  buildWhen: (previous, next) =>
                      previous?.drawings != next.drawings,
                  builder: (_, controller) {
                    return ValueListenableBuilder<bool>(
                      valueListenable: erasingNotifier,
                      builder: (_, erasing, __) {
                        return FilledButton.tonal(
                          onPressed: (controller.drawings.isEmpty && !erasing)
                              ? null
                              : () {
                                  controller.changeEraseMode(EraseMode.drawing);
                                  controller.toggleErase();
                                },
                          child: Text(
                            erasing
                                ? 'stop erasing drawing'
                                : 'start erase drawing',
                          ),
                        );
                      },
                    );
                  },
                ),
                20.boxWidth,
                ChangeNotifierBuilder<DrawingController>(
                  listenable: controller,
                  buildWhen: (previous, next) =>
                      previous?.drawings != next.drawings,
                  builder: (_, controller) {
                    return ValueListenableBuilder<bool>(
                      valueListenable: erasingNotifier,
                      builder: (_, erasing, __) {
                        return FilledButton.tonal(
                          onPressed: (controller.drawings.isEmpty && !erasing)
                              ? null
                              : () {
                                  controller.changeEraseMode(EraseMode.area);
                                  controller.toggleErase();
                                },
                          child: Text(
                            erasing ? 'stop erasing area' : 'start erase area',
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
            20.boxHeight,
            Container(
              color: AppColors.subjectOrange.withOpacity(0.4),
              width: 600,
              height: 600,
              child: Stack(
                children: [
                  SizedBox.square(
                    dimension: 600,
                    child: ChangeNotifierBuilder<DrawingController>(
                      listenable: controller,
                      builder: (_, controller) {
                        return CustomPaint(
                          painter: DrawingPainter(
                            drawings: controller.drawings,
                          ),
                        );
                      },
                    ),
                  ),
                  GestureDetector(
                    onPanStart: panStart,
                    onPanEnd: (details) {
                      // if (erasingNotifier.value) return;
                      if (controller.drawingMode == DrawingMode.erase) return;
                      panEnd(details);
                    },
                    onForcePressStart: (details) {},
                    onForcePressUpdate: (details) {
                      details.pressure;
                      print('force pressure: ${details.pressure}');
                    },
                    onPanUpdate: panUpdate,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  PointDouble pointDoubleFromOffset(Offset offset) {
    return PointDouble(offset.dx, offset.dy);
  }

  void panStart(details) {
    final DrawingDelta delta = DrawingDelta(
      metadata: const DrawingMetadata(
        color: AppColors.red300,
      ),
      point: PointDouble(
        details.localPosition.dx,
        details.localPosition.dy,
      ),
      operation: DrawingOperation.start,
    );

    controller.draw(delta);
  }

  void panEnd(DragEndDetails details) {
    final DrawingDelta delta = DrawingDelta(
      point: controller.drawings.isEmpty
          ? const PointDouble(0, 0)
          : controller.drawings.last.deltas.last.point,
      operation: DrawingOperation.end,
    );

    controller.draw(delta);
  }

  void panUpdate(DragUpdateDetails details) {
    final DrawingDelta delta = DrawingDelta(
      point: pointDoubleFromOffset(details.localPosition),
      metadata: const DrawingMetadata(strokeWidth: 4),
      operation: DrawingOperation.neutral,
    );

    controller.draw(delta);
  }

  late final Drawing initialDrawing = Drawing(
    deltas: initialDelta,
  );

  final List<DrawingDelta> initialDelta = [
    const DrawingDelta(
      point: PointDouble(0, 0),
      operation: DrawingOperation.start,
    ),
    ...List<DrawingDelta>.generate(
      80,
      (index) => DrawingDelta(
        point: PointDouble(
          3 * (index + 2),
          4 * (index + 2),
        ),
      ),
    ),
    const DrawingDelta(
      point: PointDouble(7, 29),
      operation: DrawingOperation.end,
    ),
  ];

  final DrawingController controller = DrawingController();
  final ValueNotifier<bool> erasingNotifier = ValueNotifier<bool>(false);

  void erasingCheckingCallback() {
    final bool isCurrentlyErasing = controller.drawingMode == DrawingMode.erase;

    if (isCurrentlyErasing ^ erasingNotifier.value) {
      erasingNotifier.value = isCurrentlyErasing;
    }
  }

  @override
  void initState() {
    controller.initialize();

    controller.addListener(erasingCheckingCallback);

    super.initState();
  }

  @override
  void dispose() {
    controller.removeListener(erasingCheckingCallback);
    controller.dispose();
    erasingNotifier.dispose();

    super.dispose();
  }
}
