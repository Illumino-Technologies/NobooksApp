import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nobook/src/features/features_barrel.dart' show Note;
import 'package:nobook/src/features/notes/subfeatures/document_editing/drawing/drawing_barrel.dart';
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
  final double drawingBoundsVertical = 500;
  final double drawingBoundsHorizontal = 600;

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
            ChangeNotifierBuilder(
              listenable: controller,
              buildWhen: (previous, next) =>
                  previous?.metadataFor() == next.metadataFor(),
              builder: (_, notifier) {
                final DrawingMetadata metadata = notifier.metadataFor();
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ...ChangeColor.values.map(
                      (e) => Container(
                        decoration: BoxDecoration(
                          border: metadata.color == e.color
                              ? Border.all(
                                  color: e.color,
                                  width: 2,
                                )
                              : null,
                        ),
                        margin: EdgeInsets.only(left: 30.w),
                        padding: const EdgeInsets.all(5),
                        child: InkWell(
                          onTap: () => changeColor(e.color),
                          child: Container(
                            width: 50,
                            height: 50,
                            color: e.color,
                          ),
                        ),
                      ),
                    )
                  ],
                );
              },
            ),
            20.boxHeight,
            ChangeNotifierBuilder(
              listenable: controller,
              buildWhen: (previous, next) =>
                  previous?.drawingMode == next.drawingMode,
              builder: (_, value) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        borderRadius: Ui.allBorderRadius(50),
                        border: value.drawingMode == DrawingMode.sketch
                            ? Border.all(
                                color: AppColors.blue500,
                                width: 2,
                              )
                            : null,
                      ),
                      child: FilledButton.tonal(
                        onPressed: () {
                          controller.changeDrawingMode(DrawingMode.sketch);
                        },
                        child: const Text('Sketch mode'),
                      ),
                    ),
                    30.boxWidth,
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        borderRadius: Ui.allBorderRadius(50),
                        border: value.drawingMode == DrawingMode.shape
                            ? Border.all(
                                color: AppColors.blue500,
                                width: 2,
                              )
                            : null,
                      ),
                      child: FilledButton.tonal(
                        onPressed: () {
                          controller.changeDrawingMode(DrawingMode.shape);
                        },
                        child: const Text('Shape mode'),
                      ),
                    ),
                  ],
                );
              },
            ),
            20.boxHeight,
            ChangeNotifierBuilder(
              listenable: controller,
              buildWhen: (previous, next) => previous?.shape == next.shape,
              builder: (_, value) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ...Shape.values.map(
                      (e) => IconButton(
                        onPressed: () => controller.changeShape(e),
                        icon: Icon(
                          e.iconData,
                          color: value.shape == e ? AppColors.blue500 : null,
                        ),
                      ),
                    )
                  ],
                );
              },
            ),
            20.boxHeight,
            Container(
              color: AppColors.subjectOrange.withOpacity(0.4),
              width: drawingBoundsHorizontal,
              height: drawingBoundsVertical,
              child: Stack(
                children: [
                  SizedBox(
                    height: drawingBoundsVertical,
                    width: drawingBoundsHorizontal,
                    child: ChangeNotifierBuilder<DrawingController>(
                      listenable: controller,
                      builder: (_, controller) {
                        print('drawings: ${controller.drawings}');

                        return CustomPaint(
                          painter: DrawingsPainter(
                            shapeDrawingPainter: const ShapePainter(),
                            sketchDrawingPainter: const SketchPainter(),
                            drawings: controller.drawings,
                          ),
                        );
                      },
                    ),
                  ),
                  GestureDetector(
                    onPanStart: panStart,
                    onPanEnd: (details) {
                      details.velocity.pixelsPerSecond;
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

  void changeColor(Color color) {
    controller.changeColor(color);
  }

  final ValueNotifier<int?> dragChangeNotifier = ValueNotifier<int?>(null);

  int computeDurationDifference(Duration duration) {
    final int durationDifference = dragChangeNotifier.value == null
        ? 0
        : duration.inMilliseconds - dragChangeNotifier.value!;
    dragChangeNotifier.value = duration.inMilliseconds;
    return durationDifference;
  }

  double computeDragSpeed(double distance, Duration duration) {
    final int time = computeDurationDifference(duration);
    return time == 0 ? 0 : distance / time;
  }

  PointDouble pointDoubleFromOffset(Offset offset) {
    return PointDouble(offset.dx, offset.dy);
  }

  void panStart(DragStartDetails details) {
    final DrawingDelta delta = DrawingDelta(
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

  bool isOutOfBounds(Offset offset) {
    return (offset.dx < 0 || offset.dx > drawingBoundsHorizontal) ||
        (offset.dy < 0 || offset.dy > drawingBoundsVertical);
  }

  void panUpdate(DragUpdateDetails details) {
    if (isOutOfBounds(details.localPosition)) return;

    final double speed = details.sourceTimeStamp != null
        ? computeDragSpeed(details.delta.distance, details.sourceTimeStamp!)
        : 0;

    final DrawingDelta delta = DrawingDelta(
      point: pointDoubleFromOffset(details.localPosition),
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

extension DragUpdateDetailsExtension on DragUpdateDetails {}
