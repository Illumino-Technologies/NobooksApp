import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ChangingPointerScrollPhysics extends ScrollPhysics {
  final ScrollPhysics? scrollPhysicsDelegate;

  ChangingPointerScrollPhysics({
    this.scrollPhysicsDelegate,
  }) : super(parent: scrollPhysicsDelegate);

  bool _shouldScroll = false;

  bool get shouldScroll => _shouldScroll;

  set shouldScroll(bool value) {
    if (_shouldScroll ^ value) {
      _shouldScroll = value;
    }
  }

  @override
  ScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return _shouldScroll
        ? super.applyTo(ancestor)
        : ChangingPointerScrollPhysics(
            scrollPhysicsDelegate: buildParent(ancestor),
          );
  }

  @override
  bool shouldAcceptUserOffset(ScrollMetrics position) => _shouldScroll
      ? scrollPhysicsDelegate?.shouldAcceptUserOffset(position) ??
          super.shouldAcceptUserOffset(position)
      : false;

  @override
  bool get allowImplicitScrolling => _shouldScroll
      ? scrollPhysicsDelegate?.allowImplicitScrolling ??
          super.allowImplicitScrolling
      : false;
}
