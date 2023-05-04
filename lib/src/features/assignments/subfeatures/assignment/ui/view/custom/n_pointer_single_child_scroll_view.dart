import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:nobook/src/features/assignments/subfeatures/assignment/ui/view/custom/pointer_changin_scroll_physics.dart';

///copied and modified from [stackoverflow](https://stackoverflow.com/questions/76155321/how-can-i-recognize-two-fingers-on-the-screen-in-flutter/76156071?noredirect=1#comment134304616_76156071)
class NPointerSingleChildScrollView extends StatefulWidget {
  final int numberOfPointers;

  final Axis scrollDirection;
  final bool reverse;
  final EdgeInsetsGeometry? padding;
  final ScrollController? controller;
  final bool? primary;
  final ScrollPhysics? physics;
  final Widget? child;
  final DragStartBehavior dragStartBehavior;
  final Clip clipBehavior;
  final String? restorationId;
  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;

  const NPointerSingleChildScrollView({
    this.scrollDirection = Axis.vertical,
    this.reverse = false,
    this.padding,
    this.primary,
    this.physics,
    this.controller,
    this.child,
    this.dragStartBehavior = DragStartBehavior.start,
    this.clipBehavior = Clip.hardEdge,
    this.restorationId,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
    super.key,
    required this.numberOfPointers,
  });

  @override
  State<NPointerSingleChildScrollView> createState() =>
      _NPointerSingleChildScrollViewState();
}

class _NPointerSingleChildScrollViewState
    extends State<NPointerSingleChildScrollView> {
  int _pointers = 0;

  void _handleScaleUpdate(ScaleUpdateDetails details) {
    setState(() {
      _pointers = details.pointerCount;
    });
  }

  void _handleScaleStart(ScaleStartDetails details) {
    setState(() {
      _pointers = details.pointerCount;
    });
  }

  void _handleScaleEnd(ScaleEndDetails details) {
    setState(() {
      _pointers = 0;
    });
  }

  // Need logic to make it true when two or more fingers on the screen
  Set<int> touchPositions = {};

  void savePointerPosition(int index) {
    print('saving pointer position: $index');
    setState(() {
      touchPositions.add(index);
      changePhysics();
    });
  }

  void clearPointerPosition(int index) {
    setState(() {
      touchPositions.remove(index);
      changePhysics();
    });
  }

  void changePhysics() {
    final bool shouldScroll = touchPositions.length == 2;
    if (shouldScroll ^ physics.shouldScroll) {
      print('should scroll: $shouldScroll');
      physics.shouldScroll = shouldScroll;
    }
  }

  final ChangingPointerScrollPhysics physics = ChangingPointerScrollPhysics();

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (opd) {
        savePointerPosition(opd.pointer);
      },
      onPointerMove: (opm) {},
      onPointerCancel: (opc) {},
      onPointerUp: (opc) {
        clearPointerPosition(opc.pointer);
      },
      child: Builder(
        builder: (context) {
          print('physics should scroll: ${physics.shouldScroll}');
          return IgnorePointer(
            ignoring: !physics.shouldScroll,
            child: SingleChildScrollView(
              physics: physics,
              key: const ValueKey('NPointerSingleChildScrollView key'),
              scrollDirection: widget.scrollDirection,
              reverse: widget.reverse,
              padding: widget.padding,
              primary: widget.primary,
              controller: widget.controller,
              dragStartBehavior: widget.dragStartBehavior,
              clipBehavior: widget.clipBehavior,
              restorationId: widget.restorationId,
              keyboardDismissBehavior: widget.keyboardDismissBehavior,
              child: widget.child,
            ),
          );
        },
      ),
    );
  }
}
