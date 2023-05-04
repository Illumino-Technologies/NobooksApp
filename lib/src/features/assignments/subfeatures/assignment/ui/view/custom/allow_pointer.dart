import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class AllowPointer extends SingleChildRenderObjectWidget {
  const AllowPointer({
    super.key,
    this.allowing = true,
    this.ignoringSemantics,
    super.child,
  });

  final bool allowing;

  final bool? ignoringSemantics;

  @override
  RenderAllowPointer createRenderObject(BuildContext context) {
    return RenderAllowPointer(
      allowing: allowing,
      ignoringSemantics: ignoringSemantics,
    );
  }

  @override
  void updateRenderObject(
      BuildContext context, RenderAllowPointer renderObject) {
    renderObject
      ..allowing = allowing
      ..ignoringSemantics = ignoringSemantics;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<bool>('allowing', allowing));
    properties.add(
      DiagnosticsProperty<bool>(
        'ignoringSemantics',
        ignoringSemantics,
        defaultValue: null,
      ),
    );
  }
}

class RenderAllowPointer extends RenderProxyBox {
  RenderAllowPointer({
    RenderBox? child,
    bool allowing = true,
    bool? ignoringSemantics,
  })  : _allowing = allowing,
        _ignoringSemantics = ignoringSemantics,
        super(child);

  bool get allowing => _allowing;
  bool _allowing;

  set allowing(bool value) {
    if (value == _allowing) return;

    _allowing = value;
    if (_ignoringSemantics == null || !_ignoringSemantics!) {
      markNeedsSemanticsUpdate();
    }
  }

  bool? get ignoringSemantics => _ignoringSemantics;
  bool? _ignoringSemantics;

  set ignoringSemantics(bool? value) {
    if (value == _ignoringSemantics) {
      return;
    }
    final bool oldEffectiveValue = _effectiveIgnoringSemantics;
    _ignoringSemantics = value;
    if (oldEffectiveValue != _effectiveIgnoringSemantics) {
      markNeedsSemanticsUpdate();
    }
  }

  bool get _effectiveIgnoringSemantics => ignoringSemantics ?? allowing;

  @override
  bool hitTest(BoxHitTestResult result, {required Offset position}) {
    return false;
  }

  @override
  void visitChildrenForSemantics(RenderObjectVisitor visitor) {
    if (child != null && !_effectiveIgnoringSemantics) {
      visitor(child!);
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<bool>('allowing', allowing));
    properties.add(
      DiagnosticsProperty<bool>(
        'ignoringSemantics',
        _effectiveIgnoringSemantics,
        description: ignoringSemantics == null
            ? 'implicitly $_effectiveIgnoringSemantics'
            : null,
      ),
    );
  }
}
