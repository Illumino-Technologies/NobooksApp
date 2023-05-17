import 'package:flutter/material.dart' hide ListenableBuilder;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nobook/src/global/ui/ui_barrel.dart';
import 'package:nobook/src/utils/utils_barrel.dart';
import 'package:nobook/src/global/ui/widgets/custom/value_listenables/listenable_builder.dart'
    as ListenableBuilder;

part 'custom/thumb.dart';

part 'custom/track.dart';

class CustomScrollbar extends StatefulWidget {
  final ScrollController controller;
  final double? height;

  const CustomScrollbar({
    Key? key,
    required this.controller,
    this.height,
  }) : super(key: key);

  @override
  State<CustomScrollbar> createState() => _CustomScrollbarState();
}

class _CustomScrollbarState extends State<CustomScrollbar> {
  late double height =
      widget.height ?? context.findRenderObject()?.paintBounds.height ?? 928.h;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      height = widget.height ??
          context.findRenderObject()?.paintBounds.height ??
          928.h;
    });
    resetActive();
  }

  ScrollController get controller => widget.controller;

  Future<void> resetActive() async {
    active = true;
    await Future.delayed(const Duration(milliseconds: 2000));
    active = false;
  }

  bool _active = false;

  bool get active => _active;

  set active(bool value) {
    if (value ^ _active) {
      setState(() {
        _active = value;
      });
    }
  }

  void onTap(TapUpDetails details) {
    controller.animateTo(
      computeNextJumpOffset(details.localPosition.dy),
      curve: Curves.linear,
      duration: const Duration(milliseconds: 300),
    );
    resetActive();
  }

  double computeNextJumpOffset(double value) {
    return value /
        height *
        (controller.position.maxScrollExtent -
            controller.position.minScrollExtent);
  }

  double computeGlobalValueRelativeToHeight(double value) {
    return height * (value / context.mediaQuery.size.height);
  }

  double clipOffsetToSpecifiedHeight(double offset, double thumbHeight) {
    if (offset < 0) return 0;
    if (offset > thumbHeight) return thumbHeight;
    return offset;
  }

  void onVerticalDragUpdate(DragUpdateDetails details) {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    double pos = renderBox.globalToLocal(details.globalPosition).dy;

    pos = (pos - thumbHeight / 2);

    final double myGlobalPosition = details.delta.dy.isNegative
        ? details.globalPosition.dy - thumbInitialDragOffset
        : details.globalPosition.dy + thumbInitialDragOffset;

    final double jumpPosition = computeGlobalValueRelativeToHeight(
      myGlobalPosition,
    );

    controller.jumpTo(
      clipOffsetToSpecifiedHeight(
        computeNextJumpOffset(pos),
        controller.position.maxScrollExtent,
      ),
    );
    active = true;
  }

  double thumbInitialDragOffset = 0;

  void onVerticalDragStart(DragStartDetails details) {
    active = true;
    thumbInitialDragOffset = clipOffsetToSpecifiedHeight(
      details.localPosition.dy,
      thumbHeight,
    );
  }

  void onVerticalDragEnd(DragEndDetails details) {
    thumbInitialDragOffset = 0;
    resetActive();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Stack(
        children: [
          _Track(
            active: active,
            onTap: onTap,
          ),
          ListenableBuilder.ListenableBuilder(
            listenable: controller,
            builder: (context) {
              return Positioned(
                top: thumbYOffset,
                child: _Thumb(
                  onTapDown: (details) => active = true,
                  height: maxScrollExtent == null || minScrollExtent == null
                      ? thumbHeight
                      : (height / (maxScrollExtent! - minScrollExtent!)),
                  onVerticalDragEnd: onVerticalDragEnd,
                  onVerticalDragStart: onVerticalDragStart,
                  onVerticalDrag: onVerticalDragUpdate,
                  active: active,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  double thumbHeight = 161.h;

  double get thumbYOffset =>
      (height - thumbHeight) * controller.offset / (maxScrollExtent ?? height);

  double? get maxScrollExtent {
    try {
      return controller.position.maxScrollExtent;
    } catch (e) {
      return null;
    }
  }

  double? get minScrollExtent {
    try {
      return controller.position.minScrollExtent;
    } catch (e) {
      return null;
    }
  }
}
