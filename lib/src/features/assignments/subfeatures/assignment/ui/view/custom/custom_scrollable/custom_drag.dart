import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

typedef OnUpdate = Function(DragUpdateDetails details);

class TwoPointerVerticalDrag extends CustomMultiDrag {
  TwoPointerVerticalDrag({
    required List<PointerDownEvent> events,
    required OnUpdate onUpdate,
  }) : super(
          events: events,
          onUpdate: onUpdate,
          axis: Axis.vertical,
          pointerCount: 2,
        );
}

class TwoPointerHorizontalDrag extends CustomMultiDrag {
  TwoPointerHorizontalDrag({
    required List<PointerDownEvent> events,
    required OnUpdate onUpdate,
  }) : super(
          events: events,
          onUpdate: onUpdate,
          axis: Axis.horizontal,
          pointerCount: 2,
        );
}

class CustomMultiDrag extends Drag {
  final List<PointerDownEvent> events;
  final Axis axis;
  final int pointerCount;

  final OnUpdate onUpdate;

  CustomMultiDrag({
    required this.events,
    required this.onUpdate,
    required this.axis,
    required this.pointerCount,
  });

  @override
  void update(DragUpdateDetails details) {
    super.update(details);
    final delta = details.delta;
    switch (axis) {
      case Axis.horizontal:
        {
          if (delta.dx.abs() > 0 && events.length == pointerCount) {
            onUpdate(
              DragUpdateDetails(
                sourceTimeStamp: details.sourceTimeStamp,
                delta: Offset(delta.dx, 0),
                primaryDelta: details.primaryDelta,
                globalPosition: details.globalPosition,
                localPosition: details.localPosition,
              ),
            );
          }
          break;
        }
      case Axis.vertical:
        {
          if (delta.dy.abs() > 0 && events.length == pointerCount) {
            onUpdate(
              DragUpdateDetails(
                sourceTimeStamp: details.sourceTimeStamp,
                delta: Offset(0, delta.dy),
                primaryDelta: details.primaryDelta,
                globalPosition: details.globalPosition,
                localPosition: details.localPosition,
              ),
            );
          }
          break;
        }
    }
  }
}
// class TwoPointerVerticalDrag extends Drag {
//   final List<PointerDownEvent> events;
//
//   final OnUpdate onUpdate;
//
//   TwoPointerVerticalDrag({
//     required this.events,
//     required this.onUpdate,
//   });
//
//   @override
//   void update(DragUpdateDetails details) {
//     super.update(details);
//     final delta = details.delta;
//     if (delta.dy.abs() > 0 && events.length == 2) {
//       onUpdate(
//         DragUpdateDetails(
//           sourceTimeStamp: details.sourceTimeStamp,
//           delta: Offset(0, delta.dy),
//           primaryDelta: details.primaryDelta,
//           globalPosition: details.globalPosition,
//           localPosition: details.localPosition,
//         ),
//       );
//     }
//   }
// }

// class TwoPointerHorizontalDrag extends Drag {
//   final List<PointerDownEvent> events;
//
//   final OnUpdate onUpdate;
//
//   TwoPointerHorizontalDrag({
//     required this.events,
//     required this.onUpdate,
//   });
//
//   @override
//   void update(DragUpdateDetails details) {
//     super.update(details);
//     final delta = details.delta;
//     if (delta.dx.abs() > 0 && events.length == 2) {
//       onUpdate(
//         DragUpdateDetails(
//           sourceTimeStamp: details.sourceTimeStamp,
//           delta: Offset(delta.dx, 0),
//           primaryDelta: details.primaryDelta,
//           globalPosition: details.globalPosition,
//           localPosition: details.localPosition,
//         ),
//       );
//     }
//   }
// }
