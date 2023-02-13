import 'package:flutter/material.dart';
import 'package:nobook/src/global/ui/ui_barrel.dart';
import 'package:nobook/src/utils/utils_barrel.dart';

class OutlineButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  final bool shrink;
  final bool shrinkHeight;
  final bool shrinkWidth;
  final double height;
  final double outlineThickness;
  final double width;
  final bool center;
  final double radius;
  final Color? fillColor;
  final Color color;
  final bool disabled;
  final bool loading;
  final EdgeInsets padding;
  final EdgeInsets margin;

  const OutlineButton({
    Key? key,
    required this.onPressed,
    required this.child,
    this.shrink = false,
    this.shrinkHeight = false,
    this.shrinkWidth = false,
    this.height = 56,
    this.outlineThickness = 2,
    this.width = double.infinity,
    this.center = true,
    this.radius = 16,
    this.fillColor,
    this.color = AppColors.blue500,
    this.disabled = false,
    this.loading = false,
    this.padding = EdgeInsets.zero,
    this.margin = EdgeInsets.zero,
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
            shape: RoundedRectangleBorder(
              borderRadius: Ui.allBorderRadius(radius),
              side: BorderSide(
                color: color,
                width: outlineThickness,
              ),
            ),
            elevation: 0,
            highlightElevation: 0,
            color: fillColor,
            onPressed: disabled ? null : onPressed,
            padding: padding,
            child: loading
                ? const Center(child: CircularProgressIndicator())
                : center
                    ? Center(child: child)
                    : child,
          ),
        ),
      ),
    );
  }
}
