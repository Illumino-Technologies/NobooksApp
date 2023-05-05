import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

class CustomPointListener extends StatefulWidget {
  final Widget child;
  final int pointCount;

  final PointerDownEventListener? onPointerDown;

  final PointerMoveEventListener? onPointerMove;

  final PointerUpEventListener? onPointerUp;

  final PointerHoverEventListener? onPointerHover;

  final PointerCancelEventListener? onPointerCancel;

  final PointerPanZoomStartEventListener? onPointerPanZoomStart;

  final PointerPanZoomUpdateEventListener? onPointerPanZoomUpdate;

  final PointerPanZoomEndEventListener? onPointerPanZoomEnd;

  final PointerSignalEventListener? onPointerSignal;

  final HitTestBehavior behavior;

  const CustomPointListener({
    Key? key,
    required this.child,
    required this.pointCount,
    this.onPointerDown,
    this.onPointerMove,
    this.onPointerUp,
    this.onPointerHover,
    this.onPointerCancel,
    this.onPointerPanZoomStart,
    this.onPointerPanZoomUpdate,
    this.onPointerPanZoomEnd,
    this.onPointerSignal,
    this.behavior = HitTestBehavior.deferToChild,
  }) : super(key: key);

  @override
  State<CustomPointListener> createState() => _CustomPointListenerState();
}

class _CustomPointListenerState extends State<CustomPointListener> {
  Set<int> touchPositions = {};

  void savePointerPosition(int index) {
    setState(() {
      touchPositions.add(index);
    });
  }

  void clearPointerPosition(int index) {
    setState(() {
      touchPositions.remove(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (event) {
        savePointerPosition(event.pointer);
        if (touchPositions.length == widget.pointCount) {
          widget.onPointerDown?.call(event);
        }
      },
      onPointerMove: (event) {
        savePointerPosition(event.pointer);
        if (touchPositions.length == widget.pointCount) {
          widget.onPointerMove?.call(event);
        }
      },
      onPointerUp: (event) {
        clearPointerPosition(event.pointer);
        if (touchPositions.length == widget.pointCount) {
          widget.onPointerUp?.call(event);
        }
      },
      onPointerCancel: (event) {
        clearPointerPosition(event.pointer);
        if (touchPositions.length == widget.pointCount) {
          widget.onPointerCancel?.call(event);
        }
      },
      onPointerHover: widget.onPointerHover,
      onPointerPanZoomStart: widget.onPointerPanZoomStart,
      onPointerPanZoomUpdate: widget.onPointerPanZoomUpdate,
      onPointerPanZoomEnd: widget.onPointerPanZoomEnd,
      onPointerSignal: widget.onPointerSignal,
      behavior: widget.behavior,
      child: widget.child,
    );
  }
}
