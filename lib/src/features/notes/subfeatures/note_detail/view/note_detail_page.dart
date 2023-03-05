import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nobook/src/features/features_barrel.dart' show Note;
import 'package:nobook/src/features/notes/subfeatures/document_editing/model/document_editor_model.dart';
import 'package:nobook/src/features/notes/subfeatures/document_editing/model/drawing_editing_delta.dart';
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
  @override
  Widget build(BuildContext context) {
    const double regionRadius = 5;

    return Material(
      child: Center(
        child:
            // PainterWidgetView(),
            Column(
          children: [
            FilledButton.tonal(
              onPressed: () {
                drawingsNotifier.value = List<Drawing>.empty(growable: true);
              },
              child: const Text('clear'),
            ),
            ValueListenableBuilder<List<Drawing>>(
              valueListenable: drawingsNotifier,
              builder: (_, deltas, __) {
                return ValueListenableBuilder<bool>(
                  valueListenable: erasingNotifier,
                  builder: (_, erasing, __) {
                    return FilledButton.tonal(
                      onPressed: (deltas.isEmpty && !erasing)
                          ? null
                          : () {
                              erasingNotifier.value = !erasingNotifier.value;
                            },
                      child: Text(
                        erasing ? 'stop erasing' : 'start erase',
                      ),
                    );
                  },
                );
              },
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
                    child: ValueListenableBuilder<List<Drawing>>(
                      valueListenable: drawingsNotifier,
                      builder: (_, deltas, __) {
                        return CustomPaint(
                          painter: DrawingPainter(
                            drawings: deltas,
                          ),
                        );
                      },
                    ),
                  ),
                  GestureDetector(
                    onPanStart: (details) {
                      final Region region = Region(
                        centre: pointDoubleFromOffset(details.localPosition),
                        radius: regionRadius,
                      );
                      erasingNotifier.value
                          ?
                          // eraseDelta(
                          // pointDoubleFromOffset(details.localPosition),
                          // )
                          // eraseDrawingInRegion(region)
                          erase(region)
                          : panStart(details);
                    },
                    onPanEnd: (details) {
                      if (erasingNotifier.value) return;
                      panEnd(details);
                    },
                    onForcePressStart: (details) {},
                    onForcePressUpdate: (details) {
                      details.pressure;
                      print('force pressure: ${details.pressure}');
                    },
                    onPanUpdate: (details) {
                      final Region region = Region(
                        centre: pointDoubleFromOffset(details.localPosition),
                        radius: regionRadius,
                      );

                      erasingNotifier.value
                          ? erase(region)
                          // eraseDrawingInRegion(region)

                          // eraseDelta(
                          //   pointDoubleFromOffset(details.localPosition),
                          // )
                          : panUpdate(details);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  final ValueNotifier<bool> erasingNotifier = ValueNotifier<bool>(false);

  void eraseDrawingAt(PointDouble pointDelta) {
    final List<Drawing> drawings = List.from(drawingsNotifier.value);

    drawings.removeWhere(
      (element) => element.deltas.containsWhere(
        (value) => value.point == pointDelta,
      ),
    );
  }

  void eraseDrawingInRegion(Region region) {
    final List<Drawing> drawings = List.from(
      drawingsNotifier.value,
    );

    drawings.removeWhere(
      (element) => element.deltas.containsWhere(
        (value) => region.containsPoint(value.point),
      ),
    );

    ///
    drawingsNotifier.value = List.from(drawings);
  }

  bool containsDrawingAt(PointDouble pointDelta) {
    final List<Drawing> drawings = List.from(drawingsNotifier.value);

    for (final Drawing drawing in drawings) {
      if (drawing.deltas.containsWhere((value) => value.point == pointDelta)) {
        return true;
      }
    }
    return false;
  }

  void erase(Region eraser) {
    final Drawings drawings = List.from(drawingsNotifier.value);

    Drawing? drawingToBeErased;

    for (final Drawing drawing in drawings) {
      if (drawing.deltas.containsWhere(
        (value) => eraser.containsPoint(value.point),
      )) {
        drawingToBeErased = drawing;
        break;
      }
    }
    if (drawingToBeErased == null) return;

    final Drawing drawingTobeErasedCopy = drawingToBeErased;

    final DrawingDelta erasedDelta = drawingToBeErased.deltas
        .firstWhere((element) => eraser.containsPoint(element.point));

    final int erasedDeltaIndex = drawingToBeErased.deltas.indexOf(erasedDelta);

    if (drawingToBeErased.deltas.isFirst(erasedDelta)) {
      drawingToBeErased.deltas[1] = drawingToBeErased.deltas[1].copyWith(
        operation: DrawingOperation.start,
      );
      drawingToBeErased.deltas.removeAt(0);
      drawings.replace(drawingTobeErasedCopy, [drawingToBeErased]);
    } else if (drawingToBeErased.deltas.isLast(erasedDelta)) {
      final int length = drawingToBeErased.deltas.length;
      drawingToBeErased.deltas[length - 2] = drawingToBeErased
          .deltas[length - 2]
          .copyWith(operation: DrawingOperation.end);
      drawingToBeErased.deltas.removeLast();
      drawings.replace(drawingTobeErasedCopy, [drawingToBeErased]);
    } else {
      drawingToBeErased.deltas[erasedDeltaIndex - 1] = drawingToBeErased
          .deltas[erasedDeltaIndex - 1]
          .copyWith(operation: DrawingOperation.end);

      drawingToBeErased.deltas[erasedDeltaIndex + 1] = drawingToBeErased
          .deltas[erasedDeltaIndex + 1]
          .copyWith(operation: DrawingOperation.start);

      drawingToBeErased.deltas.removeAt(erasedDeltaIndex);

      final List<Drawing> modifiedDrawings = splitDrawingDeltaToDrawings(
        drawingToBeErased.deltas,
        drawingToBeErased.metadata,
      );
      drawings.replace(drawingTobeErasedCopy, [...modifiedDrawings]);
    }

    drawingsNotifier.value = List.from(drawings);
  }

  void removeLastDrawing() {
    final List<Drawing> drawings = List.from(drawingsNotifier.value);
    drawings.removeLast();

    drawingsNotifier.value = List.from(drawings);
  }

  final ValueNotifier<List<Drawing>> drawingsNotifier =
      ValueNotifier<List<Drawing>>([]);

  @override
  void dispose() {
    erasingNotifier.dispose();
    drawingsNotifier.dispose();
    super.dispose();
  }

  PointDouble pointDoubleFromOffset(Offset offset) {
    return PointDouble(offset.dx, offset.dy);
  }

  void addDeltaToDrawings(DrawingDelta delta) {
    final List<Drawing> drawings = drawingsNotifier.value;

    switch (delta.operation) {
      case DrawingOperation.start:
        drawings.add(
          Drawing(
            deltas: [delta],
            metadata: delta.metadata,
          ),
        );
        break;
      case DrawingOperation.end:
        if (drawings.isEmpty) return;
        drawings.last.deltas.add(delta);
        break;
      case DrawingOperation.neutral:
        if (drawings.isEmpty) return;
        drawings.last.deltas.add(delta);
        break;
    }
    drawingsNotifier.value = List.from(drawings);
  }

  void panStart(details) {
    final DrawingDelta delta = DrawingDelta(
      metadata: const DrawingDeltaMetadata(
        color: AppColors.red300,
      ),
      point: PointDouble(
        details.localPosition.dx,
        details.localPosition.dy,
      ),
      operation: DrawingOperation.start,
    );

    addDeltaToDrawings(delta);
  }

  void panEnd(DragEndDetails details) {
    final DrawingDelta delta = DrawingDelta(
      point: drawingsNotifier.value.isEmpty
          ? const PointDouble(0, 0)
          : drawingsNotifier.value.last.deltas.last.point,
      operation: DrawingOperation.end,
    );

    addDeltaToDrawings(delta);
  }

  void panUpdate(DragUpdateDetails details) {
    final DrawingDelta delta = DrawingDelta(
      point: pointDoubleFromOffset(details.localPosition),
      metadata: const DrawingDeltaMetadata(strokeWidth: 4),
      operation: DrawingOperation.neutral,
    );

    addDeltaToDrawings(delta);
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

  @override
  void initState() {
    super.initState();
    drawingsNotifier.value = [initialDrawing];
    drawingsNotifier.addListener(() {
      if (drawingsNotifier.value.isEmpty) {
        erasingNotifier.value = false;
      }
      print('erasing value: ${erasingNotifier.value}');
    });
  }

  List<Drawing> splitDrawingDeltaToDrawings(
    List<DrawingDelta> deltas, [
    DrawingDeltaMetadata? defaultMetadata,
  ]) {
    deltas = List.from(deltas);
    final List<Drawing> drawings = [];

    bool currentlyAddingDrawing = false;
    for (final DrawingDelta delta in deltas) {
      if (delta.operation == DrawingOperation.start) {
        currentlyAddingDrawing = true;
        drawings.add(
          Drawing(
            deltas: [delta],
            metadata: defaultMetadata ?? delta.metadata,
          ),
        );
        continue;
      }
      if (currentlyAddingDrawing) {
        drawings.last.deltas.add(delta);
      }
      if (delta.operation == DrawingOperation.end) {
        currentlyAddingDrawing = false;
      }
    }
    return drawings;
  }
}

typedef Drawings = List<Drawing>;

class Drawing {
  final List<DrawingDelta> deltas;
  final DrawingDeltaMetadata? metadata;

  const Drawing({
    required this.deltas,
    this.metadata,
  });

  Drawing copyWith({
    List<DrawingDelta>? deltas,
    DrawingDeltaMetadata? metadata,
  }) {
    return Drawing(
      deltas: deltas ?? this.deltas,
      metadata: metadata ?? this.metadata,
    );
  }
}

class Region {
  final PointDouble centre;
  final double radius;

  const Region({
    required this.centre,
    required this.radius,
  });

  double get minX => centre.x - radius;

  double get maxX => centre.x + radius;

  double get minY => centre.y - radius;

  double get maxY => centre.y + radius;

  bool containsPoint(PointDouble point) {
    final double x = point.x;
    final double y = point.y;

    final bool isPointInHorizontalRegion = x >= minX && x <= maxX;
    final bool isPointInVerticalRegion = y >= minY && y <= maxY;

    return isPointInHorizontalRegion && isPointInVerticalRegion;
  }
}

class DrawingNotifier extends ValueNotifier<List<Drawing>> {
  DrawingNotifier(super.value);

  ada() {
    notifyListeners();
  }
}
