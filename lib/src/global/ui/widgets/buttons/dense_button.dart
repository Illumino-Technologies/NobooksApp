import 'package:flutter/material.dart';
import 'package:nobook/src/global/global_barrel.dart';
import 'package:nobook/src/utils/utils_barrel.dart';

class DenseButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  final double elevation;
  final double height;
  final double width;
  final bool center;
  final bool shrink;
  final bool shrinkHeight;
  final bool shrinkWidth;
  final double radius;
  final Color color;
  final bool disabled;
  final bool shadow;
  final bool loading;
  final EdgeInsets padding;
  final EdgeInsets margin;

  const DenseButton({
    Key? key,
    required this.onPressed,
    required this.child,
    this.elevation = 0,
    this.height = 40,
    this.width = double.infinity,
    this.center = true,
    this.shrink = false,
    this.shrinkHeight = false,
    this.shrinkWidth = false,
    this.radius = 4,
    this.color = AppColors.blue500,
    this.disabled = false,
    this.shadow = true,
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
        child: Container(
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
          decoration: BoxDecoration(
            borderRadius: Ui.allBorderRadius(radius),
          ),
          child: MaterialButton(
            elevation: elevation,
            color: color,
            disabledColor: color,
            highlightElevation: elevation,
            shape: RoundedRectangleBorder(
              borderRadius: Ui.allBorderRadius(radius),
            ),
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
