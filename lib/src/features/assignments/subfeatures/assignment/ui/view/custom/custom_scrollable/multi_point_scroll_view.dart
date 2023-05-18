// ignore_for_file: lines_longer_than_80_chars

import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart' hide ScrollableState;
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';

class MultiPointerSingleChildScrollView extends StatelessWidget {
  final int pointerCount;

  const MultiPointerSingleChildScrollView({
    super.key,
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
    required this.pointerCount,
  }) : assert(
          !(controller != null && (primary ?? false)),
          'Primary ScrollViews obtain their ScrollController via inheritance '
          'from a PrimaryScrollController widget. You cannot both set primary to '
          'true and pass an explicit controller.',
        );

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

  AxisDirection _getDirection(BuildContext context) {
    return getAxisDirectionFromAxisReverseAndDirectionality(
      context,
      scrollDirection,
      reverse,
    );
  }

  @override
  Widget build(BuildContext context) {
    final AxisDirection axisDirection = _getDirection(context);
    Widget? contents = child;
    if (padding != null) {
      contents = Padding(padding: padding!, child: contents);
    }
    final bool effectivePrimary = primary ??
        controller == null &&
            PrimaryScrollController.shouldInherit(context, scrollDirection);

    final ScrollController? scrollController = effectivePrimary
        ? PrimaryScrollController.maybeOf(context)
        : controller;

    Widget scrollable = MultiPointScrollable(
      pointerCount: pointerCount,
      dragStartBehavior: dragStartBehavior,
      axisDirection: axisDirection,
      controller: scrollController,
      physics: physics,
      restorationId: restorationId,
      viewportBuilder: (BuildContext context, ViewportOffset offset) {
        return _SingleChildViewport(
          axisDirection: axisDirection,
          offset: offset,
          clipBehavior: clipBehavior,
          child: contents,
        );
      },
    );

    if (keyboardDismissBehavior == ScrollViewKeyboardDismissBehavior.onDrag) {
      scrollable = NotificationListener<ScrollUpdateNotification>(
        child: scrollable,
        onNotification: (ScrollUpdateNotification notification) {
          final FocusScopeNode focusNode = FocusScope.of(context);
          if (notification.dragDetails != null && focusNode.hasFocus) {
            focusNode.unfocus();
          }
          return false;
        },
      );
    }

    return effectivePrimary && scrollController != null
        // Further descendant ScrollViews will not inherit the same
        // PrimaryScrollController
        ? PrimaryScrollController.none(child: scrollable)
        : scrollable;
  }
}

class _SingleChildViewport extends SingleChildRenderObjectWidget {
  const _SingleChildViewport({
    this.axisDirection = AxisDirection.down,
    required this.offset,
    super.child,
    required this.clipBehavior,
  });

  final AxisDirection axisDirection;
  final ViewportOffset offset;
  final Clip clipBehavior;

  @override
  _RenderSingleChildViewport createRenderObject(BuildContext context) {
    return _RenderSingleChildViewport(
      axisDirection: axisDirection,
      offset: offset,
      clipBehavior: clipBehavior,
    );
  }

  @override
  void updateRenderObject(
    BuildContext context,
    _RenderSingleChildViewport renderObject,
  ) {
    // Order dependency: The offset setter reads the axis direction.
    renderObject
      ..axisDirection = axisDirection
      ..offset = offset
      ..clipBehavior = clipBehavior;
  }

  @override
  SingleChildRenderObjectElement createElement() {
    return _SingleChildViewportElement(this);
  }
}

class _SingleChildViewportElement extends SingleChildRenderObjectElement
    with NotifiableElementMixin, ViewportElementMixin {
  _SingleChildViewportElement(_SingleChildViewport super.widget);
}

class _RenderSingleChildViewport extends RenderBox
    with RenderObjectWithChildMixin<RenderBox>
    implements RenderAbstractViewport {
  _RenderSingleChildViewport({
    AxisDirection axisDirection = AxisDirection.down,
    required ViewportOffset offset,
    RenderBox? child,
    required Clip clipBehavior,
  })  : _axisDirection = axisDirection,
        _offset = offset,
        _clipBehavior = clipBehavior {
    this.child = child;
  }

  AxisDirection get axisDirection => _axisDirection;
  AxisDirection _axisDirection;

  set axisDirection(AxisDirection value) {
    if (value == _axisDirection) {
      return;
    }
    _axisDirection = value;
    markNeedsLayout();
  }

  Axis get axis => axisDirectionToAxis(axisDirection);

  ViewportOffset get offset => _offset;
  ViewportOffset _offset;

  set offset(ViewportOffset value) {
    if (value == _offset) {
      return;
    }
    if (attached) {
      _offset.removeListener(_hasScrolled);
    }
    _offset = value;
    if (attached) {
      _offset.addListener(_hasScrolled);
    }
    markNeedsLayout();
  }

  Clip get clipBehavior => _clipBehavior;
  Clip _clipBehavior = Clip.none;

  set clipBehavior(Clip value) {
    if (value != _clipBehavior) {
      _clipBehavior = value;
      markNeedsPaint();
      markNeedsSemanticsUpdate();
    }
  }

  void _hasScrolled() {
    markNeedsPaint();
    markNeedsSemanticsUpdate();
  }

  @override
  void setupParentData(RenderObject child) {
    // We don't actually use the offset argument in BoxParentData, so let's
    // avoid allocating it at all.
    if (child.parentData is! ParentData) {
      child.parentData = ParentData();
    }
  }

  @override
  void attach(PipelineOwner owner) {
    super.attach(owner);
    _offset.addListener(_hasScrolled);
  }

  @override
  void detach() {
    _offset.removeListener(_hasScrolled);
    super.detach();
  }

  @override
  bool get isRepaintBoundary => true;

  double get _viewportExtent {
    assert(hasSize);
    switch (axis) {
      case Axis.horizontal:
        return size.width;
      case Axis.vertical:
        return size.height;
    }
  }

  double get _minScrollExtent {
    assert(hasSize);
    return 0.0;
  }

  double get _maxScrollExtent {
    assert(hasSize);
    if (child == null) {
      return 0.0;
    }
    switch (axis) {
      case Axis.horizontal:
        return math.max(0.0, child!.size.width - size.width);
      case Axis.vertical:
        return math.max(0.0, child!.size.height - size.height);
    }
  }

  BoxConstraints _getInnerConstraints(BoxConstraints constraints) {
    switch (axis) {
      case Axis.horizontal:
        return constraints.heightConstraints();
      case Axis.vertical:
        return constraints.widthConstraints();
    }
  }

  @override
  double computeMinIntrinsicWidth(double height) {
    if (child != null) {
      return child!.getMinIntrinsicWidth(height);
    }
    return 0.0;
  }

  @override
  double computeMaxIntrinsicWidth(double height) {
    if (child != null) {
      return child!.getMaxIntrinsicWidth(height);
    }
    return 0.0;
  }

  @override
  double computeMinIntrinsicHeight(double width) {
    if (child != null) {
      return child!.getMinIntrinsicHeight(width);
    }
    return 0.0;
  }

  @override
  double computeMaxIntrinsicHeight(double width) {
    if (child != null) {
      return child!.getMaxIntrinsicHeight(width);
    }
    return 0.0;
  }

  // We don't override computeDistanceToActualBaseline(), because we
  // want the default behavior (returning null). Otherwise, as you
  // scroll, it would shift in its parent if the parent was baseline-aligned,
  // which makes no sense.

  @override
  Size computeDryLayout(BoxConstraints constraints) {
    if (child == null) {
      return constraints.smallest;
    }
    final Size childSize =
        child!.getDryLayout(_getInnerConstraints(constraints));
    return constraints.constrain(childSize);
  }

  @override
  void performLayout() {
    final BoxConstraints constraints = this.constraints;
    if (child == null) {
      size = constraints.smallest;
    } else {
      child!.layout(_getInnerConstraints(constraints), parentUsesSize: true);
      size = constraints.constrain(child!.size);
    }

    offset.applyViewportDimension(_viewportExtent);
    offset.applyContentDimensions(_minScrollExtent, _maxScrollExtent);
  }

  Offset get _paintOffset => _paintOffsetForPosition(offset.pixels);

  Offset _paintOffsetForPosition(double position) {
    switch (axisDirection) {
      case AxisDirection.up:
        return Offset(0.0, position - child!.size.height + size.height);
      case AxisDirection.down:
        return Offset(0.0, -position);
      case AxisDirection.left:
        return Offset(position - child!.size.width + size.width, 0.0);
      case AxisDirection.right:
        return Offset(-position, 0.0);
    }
  }

  bool _shouldClipAtPaintOffset(Offset paintOffset) {
    assert(child != null);
    switch (clipBehavior) {
      case Clip.none:
        return false;
      case Clip.hardEdge:
      case Clip.antiAlias:
      case Clip.antiAliasWithSaveLayer:
        return paintOffset.dx < 0 ||
            paintOffset.dy < 0 ||
            paintOffset.dx + child!.size.width > size.width ||
            paintOffset.dy + child!.size.height > size.height;
    }
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    if (child != null) {
      final Offset paintOffset = _paintOffset;

      void paintContents(PaintingContext context, Offset offset) {
        context.paintChild(child!, offset + paintOffset);
      }

      if (_shouldClipAtPaintOffset(paintOffset)) {
        _clipRectLayer.layer = context.pushClipRect(
          needsCompositing,
          offset,
          Offset.zero & size,
          paintContents,
          clipBehavior: clipBehavior,
          oldLayer: _clipRectLayer.layer,
        );
      } else {
        _clipRectLayer.layer = null;
        paintContents(context, offset);
      }
    }
  }

  final LayerHandle<ClipRectLayer> _clipRectLayer =
      LayerHandle<ClipRectLayer>();

  @override
  void dispose() {
    _clipRectLayer.layer = null;
    super.dispose();
  }

  @override
  void applyPaintTransform(RenderBox child, Matrix4 transform) {
    final Offset paintOffset = _paintOffset;
    transform.translate(paintOffset.dx, paintOffset.dy);
  }

  @override
  Rect? describeApproximatePaintClip(RenderObject? child) {
    if (child != null && _shouldClipAtPaintOffset(_paintOffset)) {
      return Offset.zero & size;
    }
    return null;
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    if (child != null) {
      return result.addWithPaintOffset(
        offset: _paintOffset,
        position: position,
        hitTest: (BoxHitTestResult result, Offset transformed) {
          assert(transformed == position + -_paintOffset);
          return child!.hitTest(result, position: transformed);
        },
      );
    }
    return false;
  }

  @override
  RevealedOffset getOffsetToReveal(
    RenderObject target,
    double alignment, {
    Rect? rect,
  }) {
    rect ??= target.paintBounds;
    if (target is! RenderBox) {
      return RevealedOffset(offset: offset.pixels, rect: rect);
    }

    final RenderBox targetBox = target;
    final Matrix4 transform = targetBox.getTransformTo(child);
    final Rect bounds = MatrixUtils.transformRect(transform, rect);
    final Size contentSize = child!.size;

    final double leadingScrollOffset;
    final double targetMainAxisExtent;
    final double mainAxisExtent;

    switch (axisDirection) {
      case AxisDirection.up:
        mainAxisExtent = size.height;
        leadingScrollOffset = contentSize.height - bounds.bottom;
        targetMainAxisExtent = bounds.height;
        break;
      case AxisDirection.right:
        mainAxisExtent = size.width;
        leadingScrollOffset = bounds.left;
        targetMainAxisExtent = bounds.width;
        break;
      case AxisDirection.down:
        mainAxisExtent = size.height;
        leadingScrollOffset = bounds.top;
        targetMainAxisExtent = bounds.height;
        break;
      case AxisDirection.left:
        mainAxisExtent = size.width;
        leadingScrollOffset = contentSize.width - bounds.right;
        targetMainAxisExtent = bounds.width;
        break;
    }

    final double targetOffset = leadingScrollOffset -
        (mainAxisExtent - targetMainAxisExtent) * alignment;
    final Rect targetRect = bounds.shift(_paintOffsetForPosition(targetOffset));
    return RevealedOffset(offset: targetOffset, rect: targetRect);
  }

  @override
  void showOnScreen({
    RenderObject? descendant,
    Rect? rect,
    Duration duration = Duration.zero,
    Curve curve = Curves.ease,
  }) {
    if (!offset.allowImplicitScrolling) {
      return super.showOnScreen(
        descendant: descendant,
        rect: rect,
        duration: duration,
        curve: curve,
      );
    }

    final Rect? newRect = RenderViewportBase.showInViewport(
      descendant: descendant,
      viewport: this,
      offset: offset,
      rect: rect,
      duration: duration,
      curve: curve,
    );
    super.showOnScreen(
      rect: newRect,
      duration: duration,
      curve: curve,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Offset>('offset', _paintOffset));
  }

  @override
  Rect describeSemanticsClip(RenderObject child) {
    final double remainingOffset = _maxScrollExtent - offset.pixels;
    switch (axisDirection) {
      case AxisDirection.up:
        return Rect.fromLTRB(
          semanticBounds.left,
          semanticBounds.top - remainingOffset,
          semanticBounds.right,
          semanticBounds.bottom + offset.pixels,
        );
      case AxisDirection.right:
        return Rect.fromLTRB(
          semanticBounds.left - offset.pixels,
          semanticBounds.top,
          semanticBounds.right + remainingOffset,
          semanticBounds.bottom,
        );
      case AxisDirection.down:
        return Rect.fromLTRB(
          semanticBounds.left,
          semanticBounds.top - offset.pixels,
          semanticBounds.right,
          semanticBounds.bottom + remainingOffset,
        );
      case AxisDirection.left:
        return Rect.fromLTRB(
          semanticBounds.left - remainingOffset,
          semanticBounds.top,
          semanticBounds.right + offset.pixels,
          semanticBounds.bottom,
        );
    }
  }
}

class MultiPointScrollable extends StatefulWidget {
  final int pointerCount;

  const MultiPointScrollable({
    super.key,
    this.axisDirection = AxisDirection.down,
    this.controller,
    this.physics,
    required this.viewportBuilder,
    this.incrementCalculator,
    this.excludeFromSemantics = false,
    this.semanticChildCount,
    this.dragStartBehavior = DragStartBehavior.start,
    this.restorationId,
    this.scrollBehavior,
    this.clipBehavior = Clip.hardEdge,
    required this.pointerCount,
  }) : assert(semanticChildCount == null || semanticChildCount >= 0);

  final AxisDirection axisDirection;

  final ScrollController? controller;

  final ScrollPhysics? physics;

  final ViewportBuilder viewportBuilder;

  final ScrollIncrementCalculator? incrementCalculator;

  final bool excludeFromSemantics;

  final int? semanticChildCount;

  final DragStartBehavior dragStartBehavior;

  final String? restorationId;

  final ScrollBehavior? scrollBehavior;

  final Clip clipBehavior;

  Axis get axis => axisDirectionToAxis(axisDirection);

  @override
  MultiPointScrollableState createState() => MultiPointScrollableState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(EnumProperty<AxisDirection>('axisDirection', axisDirection));
    properties.add(DiagnosticsProperty<ScrollPhysics>('physics', physics));
    properties.add(StringProperty('restorationId', restorationId));
  }

  static MultiPointScrollableState? maybeOf(BuildContext context) {
    final _CustomScrollableScope? widget =
        context.dependOnInheritedWidgetOfExactType<_CustomScrollableScope>();
    return widget?.scrollable;
  }

  static MultiPointScrollableState of(BuildContext context) {
    final MultiPointScrollableState? scrollableState = maybeOf(context);
    assert(() {
      if (scrollableState == null) {
        throw FlutterError(
          'Scrollable.of() was called with a context that does not contain a '
          'Scrollable widget.\n'
          'No Scrollable widget ancestor could be found starting from the '
          'context that was passed to Scrollable.of(). This can happen '
          'because you are using a widget that looks for a Scrollable '
          'ancestor, but no such ancestor exists.\n'
          'The context used was:\n'
          '  $context',
        );
      }
      return true;
    }());
    return scrollableState!;
  }

  static bool recommendDeferredLoadingForContext(BuildContext context) {
    final _CustomScrollableScope? widget = context
        .getElementForInheritedWidgetOfExactType<_CustomScrollableScope>()
        ?.widget as _CustomScrollableScope?;
    if (widget == null) {
      return false;
    }
    return widget.position.recommendDeferredLoading(context);
  }

  static Future<void> ensureVisible(
    BuildContext context, {
    double alignment = 0.0,
    Duration duration = Duration.zero,
    Curve curve = Curves.ease,
    ScrollPositionAlignmentPolicy alignmentPolicy =
        ScrollPositionAlignmentPolicy.explicit,
  }) {
    final List<Future<void>> futures = <Future<void>>[];

    RenderObject? targetRenderObject;
    MultiPointScrollableState? scrollable =
        MultiPointScrollable.maybeOf(context);
    while (scrollable != null) {
      futures.add(
        scrollable.position.ensureVisible(
          context.findRenderObject()!,
          alignment: alignment,
          duration: duration,
          curve: curve,
          alignmentPolicy: alignmentPolicy,
          targetRenderObject: targetRenderObject,
        ),
      );

      targetRenderObject = targetRenderObject ?? context.findRenderObject();
      context = scrollable.context;
      scrollable = MultiPointScrollable.maybeOf(context);
    }

    if (futures.isEmpty || duration == Duration.zero) {
      return Future<void>.value();
    }
    if (futures.length == 1) {
      return futures.single;
    }
    return Future.wait<void>(futures).then<void>((List<void> _) => null);
  }
}

class _CustomScrollableScope extends InheritedWidget {
  const _CustomScrollableScope({
    required this.scrollable,
    required this.position,
    required super.child,
  });

  final MultiPointScrollableState scrollable;
  final ScrollPosition position;

  @override
  bool updateShouldNotify(_CustomScrollableScope old) {
    return position != old.position;
  }
}

class MultiPointScrollableState extends State<MultiPointScrollable>
    with TickerProviderStateMixin, RestorationMixin
    implements ScrollContext {
  ScrollPosition get position => _position!;
  ScrollPosition? _position;

  final _RestorableScrollOffset _persistedScrollOffset =
      _RestorableScrollOffset();

  @override
  AxisDirection get axisDirection => widget.axisDirection;

  late ScrollBehavior _configuration;
  ScrollPhysics? _physics;
  ScrollController? _fallbackScrollController;
  MediaQueryData? _mediaQueryData;

  ScrollController get _effectiveScrollController =>
      widget.controller ?? _fallbackScrollController!;

  void _updatePosition() {
    _configuration = widget.scrollBehavior ?? ScrollConfiguration.of(context);
    _physics = _configuration.getScrollPhysics(context);
    if (widget.physics != null) {
      _physics = widget.physics!.applyTo(_physics);
    } else if (widget.scrollBehavior != null) {
      _physics =
          widget.scrollBehavior!.getScrollPhysics(context).applyTo(_physics);
    }
    final ScrollPosition? oldPosition = _position;
    if (oldPosition != null) {
      _effectiveScrollController.detach(oldPosition);

      scheduleMicrotask(oldPosition.dispose);
    }

    _position = _effectiveScrollController.createScrollPosition(
      _physics!,
      this,
      oldPosition,
    );
    assert(_position != null);
    _effectiveScrollController.attach(position);
  }

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_persistedScrollOffset, 'offset');
    assert(_position != null);
    if (_persistedScrollOffset.value != null) {
      position.restoreOffset(
        _persistedScrollOffset.value!,
        initialRestore: initialRestore,
      );
    }
  }

  @override
  void saveOffset(double offset) {
    assert(debugIsSerializableForRestoration(offset));
    _persistedScrollOffset.value = offset;

    ServicesBinding.instance.restorationManager.flushData();
  }

  @override
  void initState() {
    if (widget.controller == null) {
      _fallbackScrollController = ScrollController();
    }
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _mediaQueryData = MediaQuery.maybeOf(context);
    _updatePosition();
    super.didChangeDependencies();
  }

  bool _shouldUpdatePosition(MultiPointScrollable oldWidget) {
    ScrollPhysics? newPhysics =
        widget.physics ?? widget.scrollBehavior?.getScrollPhysics(context);
    ScrollPhysics? oldPhysics = oldWidget.physics ??
        oldWidget.scrollBehavior?.getScrollPhysics(context);
    do {
      if (newPhysics?.runtimeType != oldPhysics?.runtimeType) {
        return true;
      }
      newPhysics = newPhysics?.parent;
      oldPhysics = oldPhysics?.parent;
    } while (newPhysics != null || oldPhysics != null);

    return widget.controller?.runtimeType != oldWidget.controller?.runtimeType;
  }

  @override
  void didUpdateWidget(MultiPointScrollable oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.controller != oldWidget.controller) {
      if (oldWidget.controller == null) {
        assert(_fallbackScrollController != null);
        assert(widget.controller != null);
        _fallbackScrollController!.detach(position);
        _fallbackScrollController!.dispose();
        _fallbackScrollController = null;
      } else {
        oldWidget.controller?.detach(position);
        if (widget.controller == null) {
          _fallbackScrollController = ScrollController();
        }
      }

      _effectiveScrollController.attach(position);
    }

    if (_shouldUpdatePosition(oldWidget)) {
      _updatePosition();
    }
  }

  @override
  void dispose() {
    ignorePointerNotifier.dispose();
    if (widget.controller != null) {
      widget.controller!.detach(position);
    } else {
      _fallbackScrollController?.detach(position);
      _fallbackScrollController?.dispose();
    }

    position.dispose();
    _persistedScrollOffset.dispose();
    super.dispose();
  }

  final GlobalKey _scrollSemanticsKey = GlobalKey();

  @override
  @protected
  void setSemanticsActions(Set<SemanticsAction> actions) {
    if (_gestureDetectorKey.currentState != null) {
      _gestureDetectorKey.currentState!.replaceSemanticsActions(actions);
    }
  }

  final GlobalKey<RawGestureDetectorState> _gestureDetectorKey =
      GlobalKey<RawGestureDetectorState>();

  final GlobalKey _listenerKey = GlobalKey();

  final GlobalKey _ignorePointerKey = GlobalKey();

  Map<Type, GestureRecognizerFactory> _gestureRecognizers =
      const <Type, GestureRecognizerFactory>{};
  late final ValueNotifier<bool> ignorePointerNotifier =
      ValueNotifier<bool>(false);

  bool? _lastCanDrag;
  Axis? _lastAxisDirection;

  @override
  @protected
  void setCanDrag(bool value) {
    if (value == _lastCanDrag &&
        (!value || widget.axis == _lastAxisDirection)) {
      return;
    }

    if (!value) {
      _gestureRecognizers = const <Type, GestureRecognizerFactory>{};

      _handleDragCancel();
    } else {
      setGestureRecognizerRelativeTo(widget.axis);
    }
    _lastCanDrag = value;
    _lastAxisDirection = widget.axis;
    if (_gestureDetectorKey.currentState != null) {
      _gestureDetectorKey.currentState!.replaceGestureRecognizers(
        _gestureRecognizers,
      );
    }
  }

  void setGestureRecognizerRelativeTo(Axis axis) {
    if (widget.axis == Axis.vertical) {
      final VerticalMultiDragGestureRecognizer recognizer =
          VerticalMultiDragGestureRecognizer(
        supportedDevices: _configuration.dragDevices,
      );

      void verticalGestureRecInitializer(
        VerticalMultiDragGestureRecognizer instance,
      ) {
        instance.gestureSettings = _mediaQueryData?.gestureSettings;
      }

      final factory = GestureRecognizerFactoryWithHandlers<
          VerticalMultiDragGestureRecognizer>(
        () => recognizer,
        verticalGestureRecInitializer,
      );

      setGestureRecognizerValue({
        VerticalMultiDragGestureRecognizer: factory,
      });
    } else {
      final HorizontalMultiDragGestureRecognizer recognizer =
          HorizontalMultiDragGestureRecognizer(
        supportedDevices: _configuration.dragDevices,
      );

      void horizontalGestureRecInitializer(
        HorizontalMultiDragGestureRecognizer instance,
      ) {
        instance.gestureSettings = _mediaQueryData?.gestureSettings;
      }

      setGestureRecognizerValue({
        HorizontalMultiDragGestureRecognizer:
            GestureRecognizerFactoryWithHandlers<
                HorizontalMultiDragGestureRecognizer>(
          () => recognizer,
          horizontalGestureRecInitializer,
        ),
      });
    }
  }

  void setGestureRecognizerValue(
    Map<Type, GestureRecognizerFactory> recognizer,
  ) {
    // if (_touchPositions.length != pointCount || recognizer.isEmpty) return;

    _gestureRecognizers = recognizer;
  }

  @override
  TickerProvider get vsync => this;

  @override
  @protected
  void setIgnorePointer(bool value) {
    if (ignorePointerNotifier.value == value) {
      return;
    }
    ignorePointerNotifier.value = value;
    if (_ignorePointerKey.currentContext != null) {
      final RenderIgnorePointer renderBox = _ignorePointerKey.currentContext!
          .findRenderObject()! as RenderIgnorePointer;
      renderBox.ignoring = ignorePointerNotifier.value;
    }
  }

  @override
  BuildContext? get notificationContext => _listenerKey.currentContext;

  @override
  BuildContext get storageContext => context;

  Drag? _drag;
  ScrollHoldController? _hold;

  void _handleDragDown(DragDownDetails details) {
    assert(_drag == null);
    assert(_hold == null);
    _hold = position.hold(_disposeHold);
  }

  void _handleDragStart(DragStartDetails details) {
    assert(_drag == null);
    _drag = position.drag(
      details,
      _disposeDrag,
    );
    assert(_drag != null);
    assert(_hold == null);
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    assert(_hold == null || _drag == null);
    _drag?.update(details);
  }

  void _handleDragEnd(DragEndDetails details) {
    assert(_hold == null || _drag == null);
    _drag?.end(details);
    assert(_drag == null);
  }

  void _handleDragCancel() {
    assert(_hold == null || _drag == null);
    _hold?.cancel();
    _drag?.cancel();
    assert(_hold == null);
    assert(_drag == null);
  }

  void _disposeHold() {
    _hold = null;
  }

  void _disposeDrag() {
    _drag = null;
  }

  double _targetScrollOffsetForPointerScroll(double delta) {
    return math.min(
      math.max(position.pixels + delta, position.minScrollExtent),
      position.maxScrollExtent,
    );
  }

  double _pointerSignalEventDelta(PointerScrollEvent event) {
    double delta = widget.axis == Axis.horizontal
        ? event.scrollDelta.dx
        : event.scrollDelta.dy;

    if (axisDirectionIsReversed(widget.axisDirection)) {
      delta *= -1;
    }
    return delta;
  }

  void _receivedPointerSignal(PointerSignalEvent event) {
    if (event is PointerScrollEvent && _position != null) {
      if (_physics != null && !_physics!.shouldAcceptUserOffset(position)) {
        return;
      }
      final double delta = _pointerSignalEventDelta(event);
      final double targetScrollOffset =
          _targetScrollOffsetForPointerScroll(delta);

      if (delta != 0.0 && targetScrollOffset != position.pixels) {
        GestureBinding.instance.pointerSignalResolver
            .register(event, _handlePointerScroll);
      }
    } else if (event is PointerScrollInertiaCancelEvent) {
      position.pointerScroll(0);
    }
  }

  void _handlePointerScroll(PointerEvent event) {
    assert(event is PointerScrollEvent);
    final double delta = _pointerSignalEventDelta(event as PointerScrollEvent);
    final double targetScrollOffset =
        _targetScrollOffsetForPointerScroll(delta);
    if (delta != 0.0 && targetScrollOffset != position.pixels) {
      position.pointerScroll(delta);
    }
  }

  bool _handleScrollMetricsNotification(
    ScrollMetricsNotification notification,
  ) {
    if (notification.depth == 0) {
      final RenderObject? scrollSemanticsRenderObject =
          _scrollSemanticsKey.currentContext?.findRenderObject();
      if (scrollSemanticsRenderObject != null) {
        scrollSemanticsRenderObject.markNeedsSemanticsUpdate();
      }
    }
    return false;
  }

  final Set<int> _touchPositions = {};

  void _savePointerPosition(int index) {
    _touchPositions.add(index);
    _ignorePointerTouchListener();
    setGestureRecognizerRelativeTo(widget.axis);
  }

  void _clearPointerPosition(int index) {
    _touchPositions.remove(index);
    _ignorePointerTouchListener();
    setGestureRecognizerRelativeTo(widget.axis);
  }

  void _ignorePointerTouchListener() {
    final bool ignoringPointer = ignorePointerNotifier.value;
    final bool isCorrectPointerCount = _touchPositions.length == pointCount;

    if (ignoringPointer && !isCorrectPointerCount) {
      setIgnorePointer(false);
    }

    if (!ignoringPointer && isCorrectPointerCount) {
      setIgnorePointer(true);
    }
  }

  void _handleDragStartDelegate(event) {
    _savePointerPosition(event.pointer);
    if (_touchPositions.length != pointCount) return;

    _handleDragDown(
      DragDownDetails(
        globalPosition: event.position,
        localPosition: event.localPosition,
      ),
    );
    _handleDragStart(
      DragStartDetails(
        globalPosition: event.position,
        localPosition: event.localPosition,
        sourceTimeStamp: event.timeStamp,
        kind: event.kind,
      ),
    );
  }

  void _handleDragUpDelegate(event) {
    _clearPointerPosition(event.pointer);
    final Velocity velocity = Velocity(
      pixelsPerSecond: Offset(
        widget.axis == Axis.horizontal
            ? event.position.dx / event.timeStamp.inSeconds
            : 0,
        widget.axis == Axis.vertical
            ? event.position.dy / event.timeStamp.inSeconds
            : 0,
      ),
    );

    _handleDragEnd(
      DragEndDetails(
        velocity: velocity,
        primaryVelocity: widget.axis == Axis.horizontal
            ? velocity.pixelsPerSecond.dx
            : velocity.pixelsPerSecond.dy,
      ),
    );
  }

  void _handleDragCancelDelegate(event) {
    _clearPointerPosition(event.pointer);
    _handleDragCancel();
  }

  void _handleDragUpdateDelegate(PointerMoveEvent event) {
    _savePointerPosition(event.pointer);
    if (_touchPositions.length != pointCount) return;
    _handleDragUpdate(
      DragUpdateDetails(
        globalPosition: event.position,
        sourceTimeStamp: event.timeStamp,
        localPosition: event.localPosition,
        delta: widget.axis == Axis.horizontal
            ? Offset(event.delta.dx, 0)
            : Offset(0, event.delta.dy),
        primaryDelta:
            widget.axis == Axis.horizontal ? event.delta.dx : event.delta.dy,
      ),
    );
  }

  /// The number of points that can be tracked simultaneously.
  int get pointCount => widget.pointerCount;

  @override
  Widget build(BuildContext context) {
    assert(_position != null);

    Widget result = _CustomScrollableScope(
      scrollable: this,
      position: position,
      child: Listener(
        key: _listenerKey,
        behavior: HitTestBehavior.opaque,
        onPointerSignal: _receivedPointerSignal,
        onPointerDown: _handleDragStartDelegate,
        onPointerMove: _handleDragUpdateDelegate,
        onPointerCancel: _handleDragCancelDelegate,
        onPointerUp: _handleDragUpDelegate,
        child: Semantics(
          explicitChildNodes: !widget.excludeFromSemantics,
          child: ValueListenableBuilder<bool>(
            valueListenable: ignorePointerNotifier,
            builder: (context, shouldIgnorePointer, _) {
              return IgnorePointer(
                key: ValueKey('scrollview ignore pointer $shouldIgnorePointer'),
                ignoring: shouldIgnorePointer,
                ignoringSemantics: false,
                child: widget.viewportBuilder(context, position),
              );
            },
          ),
        ),
      ),
    );

    if (!widget.excludeFromSemantics) {
      result = NotificationListener<ScrollMetricsNotification>(
        onNotification: _handleScrollMetricsNotification,
        child: _ScrollSemantics(
          key: _scrollSemanticsKey,
          position: position,
          allowImplicitScrolling: _physics!.allowImplicitScrolling,
          semanticChildCount: widget.semanticChildCount,
          child: result,
        ),
      );
    }

    final ScrollableDetails details = ScrollableDetails(
      direction: widget.axisDirection,
      controller: _effectiveScrollController,
      clipBehavior: widget.clipBehavior,
    );

    result = _configuration.buildScrollbar(
      context,
      _configuration.buildOverscrollIndicator(context, result, details),
      details,
    );

    final SelectionRegistrar? registrar = SelectionContainer.maybeOf(context);
    if (registrar != null) {
      result = _ScrollableSelectionHandler(
        state: this,
        position: position,
        registrar: registrar,
        child: result,
      );
    }

    return result;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<ScrollPosition>('position', position));
    properties
        .add(DiagnosticsProperty<ScrollPhysics>('effective physics', _physics));
  }

  @override
  String? get restorationId => widget.restorationId;
}

class _ScrollableSelectionHandler extends StatefulWidget {
  const _ScrollableSelectionHandler({
    required this.state,
    required this.position,
    required this.registrar,
    required this.child,
  });

  final MultiPointScrollableState state;
  final ScrollPosition position;
  final Widget child;
  final SelectionRegistrar registrar;

  @override
  _ScrollableSelectionHandlerState createState() =>
      _ScrollableSelectionHandlerState();
}

class _ScrollableSelectionHandlerState
    extends State<_ScrollableSelectionHandler> {
  late _ScrollableSelectionContainerDelegate _selectionDelegate;

  @override
  void initState() {
    super.initState();
    _selectionDelegate = _ScrollableSelectionContainerDelegate(
      state: widget.state,
      position: widget.position,
    );
  }

  @override
  void didUpdateWidget(_ScrollableSelectionHandler oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.position != widget.position) {
      _selectionDelegate.position = widget.position;
    }
  }

  @override
  void dispose() {
    _selectionDelegate.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SelectionContainer(
      registrar: widget.registrar,
      delegate: _selectionDelegate,
      child: widget.child,
    );
  }
}

class EdgeDraggingAutoScroller {
  EdgeDraggingAutoScroller(
    this.scrollable, {
    this.onScrollViewScrolled,
    this.velocityScalar = _kDefaultAutoScrollVelocityScalar,
  });

  static const double _kDefaultAutoScrollVelocityScalar = 7;

  final MultiPointScrollableState scrollable;

  final VoidCallback? onScrollViewScrolled;

  final double velocityScalar;

  late Rect _dragTargetRelatedToScrollOrigin;

  bool get scrolling => _scrolling;
  bool _scrolling = false;

  double _offsetExtent(Offset offset, Axis scrollDirection) {
    switch (scrollDirection) {
      case Axis.horizontal:
        return offset.dx;
      case Axis.vertical:
        return offset.dy;
    }
  }

  double _sizeExtent(Size size, Axis scrollDirection) {
    switch (scrollDirection) {
      case Axis.horizontal:
        return size.width;
      case Axis.vertical:
        return size.height;
    }
  }

  AxisDirection get _axisDirection => scrollable.axisDirection;

  Axis get _scrollDirection => axisDirectionToAxis(_axisDirection);

  void startAutoScrollIfNecessary(Rect dragTarget) {
    final Offset deltaToOrigin = _getDeltaToScrollOrigin(scrollable);
    _dragTargetRelatedToScrollOrigin =
        dragTarget.translate(deltaToOrigin.dx, deltaToOrigin.dy);
    if (_scrolling) {
      return;
    }
    if (!_scrolling) {
      _scroll();
    }
  }

  void stopAutoScroll() {
    _scrolling = false;
  }

  Future<void> _scroll() async {
    final RenderBox scrollRenderBox =
        scrollable.context.findRenderObject()! as RenderBox;
    final Rect globalRect = MatrixUtils.transformRect(
      scrollRenderBox.getTransformTo(null),
      Rect.fromLTWH(
        0,
        0,
        scrollRenderBox.size.width,
        scrollRenderBox.size.height,
      ),
    );
    assert(
      globalRect.size.width >= _dragTargetRelatedToScrollOrigin.size.width &&
          globalRect.size.height >=
              _dragTargetRelatedToScrollOrigin.size.height,
      'Drag target size is larger than scrollable size, which may cause '
      'bouncing',
    );
    _scrolling = true;
    double? newOffset;
    const double overDragMax = 20.0;

    final Offset deltaToOrigin = _getDeltaToScrollOrigin(scrollable);
    final Offset viewportOrigin =
        globalRect.topLeft.translate(deltaToOrigin.dx, deltaToOrigin.dy);
    final double viewportStart =
        _offsetExtent(viewportOrigin, _scrollDirection);
    final double viewportEnd =
        viewportStart + _sizeExtent(globalRect.size, _scrollDirection);

    final double proxyStart = _offsetExtent(
      _dragTargetRelatedToScrollOrigin.topLeft,
      _scrollDirection,
    );
    final double proxyEnd = _offsetExtent(
      _dragTargetRelatedToScrollOrigin.bottomRight,
      _scrollDirection,
    );
    switch (_axisDirection) {
      case AxisDirection.up:
      case AxisDirection.left:
        if (proxyEnd > viewportEnd &&
            scrollable.position.pixels > scrollable.position.minScrollExtent) {
          final double overDrag = math.min(proxyEnd - viewportEnd, overDragMax);
          newOffset = math.max(
            scrollable.position.minScrollExtent,
            scrollable.position.pixels - overDrag,
          );
        } else if (proxyStart < viewportStart &&
            scrollable.position.pixels < scrollable.position.maxScrollExtent) {
          final double overDrag =
              math.min(viewportStart - proxyStart, overDragMax);
          newOffset = math.min(
            scrollable.position.maxScrollExtent,
            scrollable.position.pixels + overDrag,
          );
        }
        break;
      case AxisDirection.right:
      case AxisDirection.down:
        if (proxyStart < viewportStart &&
            scrollable.position.pixels > scrollable.position.minScrollExtent) {
          final double overDrag =
              math.min(viewportStart - proxyStart, overDragMax);
          newOffset = math.max(
            scrollable.position.minScrollExtent,
            scrollable.position.pixels - overDrag,
          );
        } else if (proxyEnd > viewportEnd &&
            scrollable.position.pixels < scrollable.position.maxScrollExtent) {
          final double overDrag = math.min(proxyEnd - viewportEnd, overDragMax);
          newOffset = math.min(
            scrollable.position.maxScrollExtent,
            scrollable.position.pixels + overDrag,
          );
        }
        break;
    }

    if (newOffset == null ||
        (newOffset - scrollable.position.pixels).abs() < 1.0) {
      _scrolling = false;
      return;
    }
    final Duration duration =
        Duration(milliseconds: (1000 / velocityScalar).round());
    await scrollable.position.animateTo(
      newOffset,
      duration: duration,
      curve: Curves.linear,
    );
    if (onScrollViewScrolled != null) {
      onScrollViewScrolled!();
    }
    if (_scrolling) {
      await _scroll();
    }
  }
}

class _ScrollableSelectionContainerDelegate
    extends MultiSelectableSelectionContainerDelegate {
  _ScrollableSelectionContainerDelegate({
    required this.state,
    required ScrollPosition position,
  })  : _position = position,
        _autoScroller = EdgeDraggingAutoScroller(
          state,
          velocityScalar: _kDefaultSelectToScrollVelocityScalar,
        ) {
    _position.addListener(_scheduleLayoutChange);
  }

  static const double _kDefaultDragTargetSize = 0;

  static const double _kDefaultSelectToScrollVelocityScalar = 30;

  final MultiPointScrollableState state;
  final EdgeDraggingAutoScroller _autoScroller;
  bool _scheduledLayoutChange = false;
  Offset? _currentDragStartRelatedToOrigin;
  Offset? _currentDragEndRelatedToOrigin;

  bool _selectionStartsInScrollable = false;

  ScrollPosition get position => _position;
  ScrollPosition _position;

  set position(ScrollPosition other) {
    if (other == _position) {
      return;
    }
    _position.removeListener(_scheduleLayoutChange);
    _position = other;
    _position.addListener(_scheduleLayoutChange);
  }

  void _scheduleLayoutChange() {
    if (_scheduledLayoutChange) {
      return;
    }
    _scheduledLayoutChange = true;
    SchedulerBinding.instance.addPostFrameCallback((Duration timeStamp) {
      if (!_scheduledLayoutChange) {
        return;
      }
      _scheduledLayoutChange = false;
      layoutDidChange();
    });
  }

  final Map<Selectable, double> _selectableStartEdgeUpdateRecords =
      <Selectable, double>{};
  final Map<Selectable, double> _selectableEndEdgeUpdateRecords =
      <Selectable, double>{};

  @override
  void didChangeSelectables() {
    final Set<Selectable> selectableSet = selectables.toSet();
    _selectableStartEdgeUpdateRecords.removeWhere(
      (Selectable key, double value) => !selectableSet.contains(key),
    );
    _selectableEndEdgeUpdateRecords.removeWhere(
      (Selectable key, double value) => !selectableSet.contains(key),
    );
    super.didChangeSelectables();
  }

  @override
  SelectionResult handleClearSelection(ClearSelectionEvent event) {
    _selectableStartEdgeUpdateRecords.clear();
    _selectableEndEdgeUpdateRecords.clear();
    _currentDragStartRelatedToOrigin = null;
    _currentDragEndRelatedToOrigin = null;
    _selectionStartsInScrollable = false;
    return super.handleClearSelection(event);
  }

  @override
  SelectionResult handleSelectionEdgeUpdate(SelectionEdgeUpdateEvent event) {
    if (_currentDragEndRelatedToOrigin == null &&
        _currentDragStartRelatedToOrigin == null) {
      assert(!_selectionStartsInScrollable);
      _selectionStartsInScrollable =
          _globalPositionInScrollable(event.globalPosition);
    }
    final Offset deltaToOrigin = _getDeltaToScrollOrigin(state);
    if (event.type == SelectionEventType.endEdgeUpdate) {
      _currentDragEndRelatedToOrigin =
          _inferPositionRelatedToOrigin(event.globalPosition);
      final Offset endOffset = _currentDragEndRelatedToOrigin!
          .translate(-deltaToOrigin.dx, -deltaToOrigin.dy);
      event = SelectionEdgeUpdateEvent.forEnd(globalPosition: endOffset);
    } else {
      _currentDragStartRelatedToOrigin =
          _inferPositionRelatedToOrigin(event.globalPosition);
      final Offset startOffset = _currentDragStartRelatedToOrigin!
          .translate(-deltaToOrigin.dx, -deltaToOrigin.dy);
      event = SelectionEdgeUpdateEvent.forStart(globalPosition: startOffset);
    }
    final SelectionResult result = super.handleSelectionEdgeUpdate(event);

    if (result == SelectionResult.pending) {
      _autoScroller.stopAutoScroll();
      return result;
    }
    if (_selectionStartsInScrollable) {
      _autoScroller.startAutoScrollIfNecessary(_dragTargetFromEvent(event));
      if (_autoScroller.scrolling) {
        return SelectionResult.pending;
      }
    }
    return result;
  }

  Offset _inferPositionRelatedToOrigin(Offset globalPosition) {
    final RenderBox box = state.context.findRenderObject()! as RenderBox;
    final Offset localPosition = box.globalToLocal(globalPosition);
    if (!_selectionStartsInScrollable) {
      if (localPosition.dy < 0 || localPosition.dx < 0) {
        return box.localToGlobal(Offset.zero);
      }
      if (localPosition.dy > box.size.height ||
          localPosition.dx > box.size.width) {
        return Offset.infinite;
      }
    }
    final Offset deltaToOrigin = _getDeltaToScrollOrigin(state);
    return box.localToGlobal(
      localPosition.translate(deltaToOrigin.dx, deltaToOrigin.dy),
    );
  }

  void _updateDragLocationsFromGeometries({
    bool forceUpdateStart = true,
    bool forceUpdateEnd = true,
  }) {
    final Offset deltaToOrigin = _getDeltaToScrollOrigin(state);
    final RenderBox box = state.context.findRenderObject()! as RenderBox;
    final Matrix4 transform = box.getTransformTo(null);
    if (currentSelectionStartIndex != -1 &&
        (_currentDragStartRelatedToOrigin == null || forceUpdateStart)) {
      final SelectionGeometry geometry =
          selectables[currentSelectionStartIndex].value;
      assert(geometry.hasSelection);
      final SelectionPoint start = geometry.startSelectionPoint!;
      final Matrix4 childTransform =
          selectables[currentSelectionStartIndex].getTransformTo(box);
      final Offset localDragStart = MatrixUtils.transformPoint(
        childTransform,
        start.localPosition + Offset(0, -start.lineHeight / 2),
      );
      _currentDragStartRelatedToOrigin =
          MatrixUtils.transformPoint(transform, localDragStart + deltaToOrigin);
    }
    if (currentSelectionEndIndex != -1 &&
        (_currentDragEndRelatedToOrigin == null || forceUpdateEnd)) {
      final SelectionGeometry geometry =
          selectables[currentSelectionEndIndex].value;
      assert(geometry.hasSelection);
      final SelectionPoint end = geometry.endSelectionPoint!;
      final Matrix4 childTransform =
          selectables[currentSelectionEndIndex].getTransformTo(box);
      final Offset localDragEnd = MatrixUtils.transformPoint(
        childTransform,
        end.localPosition + Offset(0, -end.lineHeight / 2),
      );
      _currentDragEndRelatedToOrigin =
          MatrixUtils.transformPoint(transform, localDragEnd + deltaToOrigin);
    }
  }

  @override
  SelectionResult handleSelectAll(SelectAllSelectionEvent event) {
    assert(!_selectionStartsInScrollable);
    final SelectionResult result = super.handleSelectAll(event);
    assert(
      (currentSelectionStartIndex == -1) == (currentSelectionEndIndex == -1),
    );
    if (currentSelectionStartIndex != -1) {
      _updateDragLocationsFromGeometries();
    }
    return result;
  }

  @override
  SelectionResult handleSelectWord(SelectWordSelectionEvent event) {
    _selectionStartsInScrollable =
        _globalPositionInScrollable(event.globalPosition);
    final SelectionResult result = super.handleSelectWord(event);
    _updateDragLocationsFromGeometries();
    return result;
  }

  @override
  SelectionResult handleGranularlyExtendSelection(
    GranularlyExtendSelectionEvent event,
  ) {
    final SelectionResult result = super.handleGranularlyExtendSelection(event);

    _updateDragLocationsFromGeometries(
      forceUpdateStart: !event.isEnd,
      forceUpdateEnd: event.isEnd,
    );
    if (_selectionStartsInScrollable) {
      _jumpToEdge(event.isEnd);
    }
    return result;
  }

  @override
  SelectionResult handleDirectionallyExtendSelection(
    DirectionallyExtendSelectionEvent event,
  ) {
    final SelectionResult result =
        super.handleDirectionallyExtendSelection(event);

    _updateDragLocationsFromGeometries(
      forceUpdateStart: !event.isEnd,
      forceUpdateEnd: event.isEnd,
    );
    if (_selectionStartsInScrollable) {
      _jumpToEdge(event.isEnd);
    }
    return result;
  }

  void _jumpToEdge(bool isExtent) {
    final Selectable selectable;
    final double? lineHeight;
    final SelectionPoint? edge;
    if (isExtent) {
      selectable = selectables[currentSelectionEndIndex];
      edge = selectable.value.endSelectionPoint;
      lineHeight = selectable.value.endSelectionPoint!.lineHeight;
    } else {
      selectable = selectables[currentSelectionStartIndex];
      edge = selectable.value.startSelectionPoint;
      lineHeight = selectable.value.startSelectionPoint?.lineHeight;
    }
    if (lineHeight == null || edge == null) {
      return;
    }
    final RenderBox scrollableBox =
        state.context.findRenderObject()! as RenderBox;
    final Matrix4 transform = selectable.getTransformTo(scrollableBox);
    final Offset edgeOffsetInScrollableCoordinates =
        MatrixUtils.transformPoint(transform, edge.localPosition);
    final Rect scrollableRect = Rect.fromLTRB(
      0,
      0,
      scrollableBox.size.width,
      scrollableBox.size.height,
    );
    switch (state.axisDirection) {
      case AxisDirection.up:
        {
          final double edgeBottom = edgeOffsetInScrollableCoordinates.dy;
          final double edgeTop =
              edgeOffsetInScrollableCoordinates.dy - lineHeight;
          if (edgeBottom >= scrollableRect.bottom &&
              edgeTop <= scrollableRect.top) {
            return;
          }
          if (edgeBottom > scrollableRect.bottom) {
            position
                .jumpTo(position.pixels + scrollableRect.bottom - edgeBottom);
            return;
          }
          if (edgeTop < scrollableRect.top) {
            position.jumpTo(position.pixels + scrollableRect.top - edgeTop);
          }
          return;
        }
      case AxisDirection.right:
        {
          final double edge = edgeOffsetInScrollableCoordinates.dx;
          if (edge >= scrollableRect.right && edge <= scrollableRect.left) {
            return;
          }
          if (edge > scrollableRect.right) {
            position.jumpTo(position.pixels + edge - scrollableRect.right);
            return;
          }
          if (edge < scrollableRect.left) {
            position.jumpTo(position.pixels + edge - scrollableRect.left);
          }
          return;
        }
      case AxisDirection.down:
        {
          final double edgeBottom = edgeOffsetInScrollableCoordinates.dy;
          final double edgeTop =
              edgeOffsetInScrollableCoordinates.dy - lineHeight;
          if (edgeBottom >= scrollableRect.bottom &&
              edgeTop <= scrollableRect.top) {
            return;
          }
          if (edgeBottom > scrollableRect.bottom) {
            position
                .jumpTo(position.pixels + edgeBottom - scrollableRect.bottom);
            return;
          }
          if (edgeTop < scrollableRect.top) {
            position.jumpTo(position.pixels + edgeTop - scrollableRect.top);
          }
          return;
        }
      case AxisDirection.left:
        {
          final double edge = edgeOffsetInScrollableCoordinates.dx;
          if (edge >= scrollableRect.right && edge <= scrollableRect.left) {
            return;
          }
          if (edge > scrollableRect.right) {
            position.jumpTo(position.pixels + scrollableRect.right - edge);
            return;
          }
          if (edge < scrollableRect.left) {
            position.jumpTo(position.pixels + scrollableRect.left - edge);
          }
          return;
        }
    }
  }

  bool _globalPositionInScrollable(Offset globalPosition) {
    final RenderBox box = state.context.findRenderObject()! as RenderBox;
    final Offset localPosition = box.globalToLocal(globalPosition);
    final Rect rect = Rect.fromLTWH(0, 0, box.size.width, box.size.height);
    return rect.contains(localPosition);
  }

  Rect _dragTargetFromEvent(SelectionEdgeUpdateEvent event) {
    return Rect.fromCenter(
      center: event.globalPosition,
      width: _kDefaultDragTargetSize,
      height: _kDefaultDragTargetSize,
    );
  }

  @override
  SelectionResult dispatchSelectionEventToChild(
    Selectable selectable,
    SelectionEvent event,
  ) {
    switch (event.type) {
      case SelectionEventType.startEdgeUpdate:
        _selectableStartEdgeUpdateRecords[selectable] = state.position.pixels;
        ensureChildUpdated(selectable);
        break;
      case SelectionEventType.endEdgeUpdate:
        _selectableEndEdgeUpdateRecords[selectable] = state.position.pixels;
        ensureChildUpdated(selectable);
        break;
      case SelectionEventType.granularlyExtendSelection:
      case SelectionEventType.directionallyExtendSelection:
        ensureChildUpdated(selectable);
        _selectableStartEdgeUpdateRecords[selectable] = state.position.pixels;
        _selectableEndEdgeUpdateRecords[selectable] = state.position.pixels;
        break;
      case SelectionEventType.clear:
        _selectableEndEdgeUpdateRecords.remove(selectable);
        _selectableStartEdgeUpdateRecords.remove(selectable);
        break;
      case SelectionEventType.selectAll:
      case SelectionEventType.selectWord:
        _selectableEndEdgeUpdateRecords[selectable] = state.position.pixels;
        _selectableStartEdgeUpdateRecords[selectable] = state.position.pixels;
        break;
    }
    return super.dispatchSelectionEventToChild(selectable, event);
  }

  @override
  void ensureChildUpdated(Selectable selectable) {
    final double newRecord = state.position.pixels;
    final double? previousStartRecord =
        _selectableStartEdgeUpdateRecords[selectable];
    if (_currentDragStartRelatedToOrigin != null &&
        (previousStartRecord == null ||
            (newRecord - previousStartRecord).abs() >
                precisionErrorTolerance)) {
      final Offset deltaToOrigin = _getDeltaToScrollOrigin(state);
      final Offset startOffset = _currentDragStartRelatedToOrigin!
          .translate(-deltaToOrigin.dx, -deltaToOrigin.dy);
      selectable.dispatchSelectionEvent(
        SelectionEdgeUpdateEvent.forStart(globalPosition: startOffset),
      );
    }
    final double? previousEndRecord =
        _selectableEndEdgeUpdateRecords[selectable];
    if (_currentDragEndRelatedToOrigin != null &&
        (previousEndRecord == null ||
            (newRecord - previousEndRecord).abs() > precisionErrorTolerance)) {
      final Offset deltaToOrigin = _getDeltaToScrollOrigin(state);
      final Offset endOffset = _currentDragEndRelatedToOrigin!
          .translate(-deltaToOrigin.dx, -deltaToOrigin.dy);
      selectable.dispatchSelectionEvent(
        SelectionEdgeUpdateEvent.forEnd(globalPosition: endOffset),
      );
    }
  }

  @override
  void dispose() {
    _selectableStartEdgeUpdateRecords.clear();
    _selectableEndEdgeUpdateRecords.clear();
    _scheduledLayoutChange = false;
    _autoScroller.stopAutoScroll();
    super.dispose();
  }
}

Offset _getDeltaToScrollOrigin(MultiPointScrollableState scrollableState) {
  switch (scrollableState.axisDirection) {
    case AxisDirection.down:
      return Offset(0, scrollableState.position.pixels);
    case AxisDirection.up:
      return Offset(0, -scrollableState.position.pixels);
    case AxisDirection.left:
      return Offset(-scrollableState.position.pixels, 0);
    case AxisDirection.right:
      return Offset(scrollableState.position.pixels, 0);
  }
}

class _RestorableScrollOffset extends RestorableValue<double?> {
  @override
  double? createDefaultValue() => null;

  @override
  void didUpdateValue(double? oldValue) {
    notifyListeners();
  }

  @override
  double fromPrimitives(Object? data) {
    return data! as double;
  }

  @override
  Object? toPrimitives() {
    return value;
  }

  @override
  bool get enabled => value != null;
}

class _ScrollSemantics extends SingleChildRenderObjectWidget {
  const _ScrollSemantics({
    super.key,
    required this.position,
    required this.allowImplicitScrolling,
    required this.semanticChildCount,
    super.child,
  }) : assert(semanticChildCount == null || semanticChildCount >= 0);

  final ScrollPosition position;
  final bool allowImplicitScrolling;
  final int? semanticChildCount;

  @override
  _RenderScrollSemantics createRenderObject(BuildContext context) {
    return _RenderScrollSemantics(
      position: position,
      allowImplicitScrolling: allowImplicitScrolling,
      semanticChildCount: semanticChildCount,
    );
  }

  @override
  void updateRenderObject(
    BuildContext context,
    _RenderScrollSemantics renderObject,
  ) {
    renderObject
      ..allowImplicitScrolling = allowImplicitScrolling
      ..position = position
      ..semanticChildCount = semanticChildCount;
  }
}

class _RenderScrollSemantics extends RenderProxyBox {
  _RenderScrollSemantics({
    required ScrollPosition position,
    required bool allowImplicitScrolling,
    required int? semanticChildCount,
    RenderBox? child,
  })  : _position = position,
        _allowImplicitScrolling = allowImplicitScrolling,
        _semanticChildCount = semanticChildCount,
        super(child) {
    position.addListener(markNeedsSemanticsUpdate);
  }

  ScrollPosition get position => _position;
  ScrollPosition _position;

  set position(ScrollPosition value) {
    if (value == _position) {
      return;
    }
    _position.removeListener(markNeedsSemanticsUpdate);
    _position = value;
    _position.addListener(markNeedsSemanticsUpdate);
    markNeedsSemanticsUpdate();
  }

  bool get allowImplicitScrolling => _allowImplicitScrolling;
  bool _allowImplicitScrolling;

  set allowImplicitScrolling(bool value) {
    if (value == _allowImplicitScrolling) {
      return;
    }
    _allowImplicitScrolling = value;
    markNeedsSemanticsUpdate();
  }

  int? get semanticChildCount => _semanticChildCount;
  int? _semanticChildCount;

  set semanticChildCount(int? value) {
    if (value == semanticChildCount) {
      return;
    }
    _semanticChildCount = value;
    markNeedsSemanticsUpdate();
  }

  @override
  void describeSemanticsConfiguration(SemanticsConfiguration config) {
    super.describeSemanticsConfiguration(config);
    config.isSemanticBoundary = true;
    if (position.haveDimensions) {
      config
        ..hasImplicitScrolling = allowImplicitScrolling
        ..scrollPosition = _position.pixels
        ..scrollExtentMax = _position.maxScrollExtent
        ..scrollExtentMin = _position.minScrollExtent
        ..scrollChildCount = semanticChildCount;
    }
  }

  SemanticsNode? _innerNode;

  @override
  void assembleSemanticsNode(
    SemanticsNode node,
    SemanticsConfiguration config,
    Iterable<SemanticsNode> children,
  ) {
    if (children.isEmpty ||
        !children.first.isTagged(RenderViewport.useTwoPaneSemantics)) {
      super.assembleSemanticsNode(node, config, children);
      return;
    }

    _innerNode ??= SemanticsNode(showOnScreen: showOnScreen);
    _innerNode!
      ..isMergedIntoParent = node.isPartOfNodeMerging
      ..rect = node.rect;

    int? firstVisibleIndex;
    final List<SemanticsNode> excluded = <SemanticsNode>[_innerNode!];
    final List<SemanticsNode> included = <SemanticsNode>[];
    for (final SemanticsNode child in children) {
      assert(child.isTagged(RenderViewport.useTwoPaneSemantics));
      if (child.isTagged(RenderViewport.excludeFromScrolling)) {
        excluded.add(child);
      } else {
        if (!child.hasFlag(SemanticsFlag.isHidden)) {
          firstVisibleIndex ??= child.indexInParent;
        }
        included.add(child);
      }
    }
    config.scrollIndex = firstVisibleIndex;
    node.updateWith(config: null, childrenInInversePaintOrder: excluded);
    _innerNode!
        .updateWith(config: config, childrenInInversePaintOrder: included);
  }

  @override
  void clearSemantics() {
    super.clearSemantics();
    _innerNode = null;
  }
}
