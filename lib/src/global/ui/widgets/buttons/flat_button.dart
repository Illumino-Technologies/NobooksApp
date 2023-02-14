import 'package:flutter/material.dart';
import 'package:nobook/src/global/ui/ui_barrel.dart';
import 'package:nobook/src/utils/utils_barrel.dart';

class FlatButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  final double height;
  final bool shrink;
  final bool shrinkHeight;
  final bool shrinkWidth;

  ///if the flat button has a round border, e.g circle avatar button
  final bool round;
  final double width;
  final bool center;
  final double radius;
  final double? elevation;
  final Color color;
  final bool disabled;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final bool loading;

  const FlatButton({
    Key? key,
    required this.onPressed,
    required this.child,
    this.elevation = 0,
    this.height = 48,
    this.width = double.infinity,
    this.center = true,
    this.shrink = false,
    this.shrinkHeight = false,
    this.shrinkWidth = false,
    this.radius = 16,
    this.color = Colors.blue,
    this.disabled = false,
    this.loading = false,
    this.padding = EdgeInsets.zero,
    this.margin = EdgeInsets.zero,
    this.round = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: ColorFiltered(
        colorFilter: ColorFilter.matrix(
          disabled ? Matrix.identity.opacity(0.5) : Matrix.identity.matrix,
        ),
        child: SizedBox(
          width: shrink
              ? null
              : shrinkWidth
                  ? null
                  : width,
          height: shrink
              ? null
              : shrinkHeight
                  ? null
                  : height,
          child: MaterialButton(
            elevation: elevation,
            shape: round
                ? const CircleBorder()
                : RoundedRectangleBorder(
                    borderRadius: Ui.allBorderRadius(radius),
                  ),
            onPressed: disabled ? null : onPressed,
            padding: padding,
            child: center ? Center(child: child) : child,
          ),
        ),
      ),
    );
  }
}
