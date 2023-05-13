import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nobook/src/global/ui/ui_barrel.dart';

class LoaderWidget extends StatelessWidget {
  final double strokeWidth;
  final double size;
  final bool absorbPointer;
  final Color backgroundColor;

  const LoaderWidget({
    Key? key,
    this.strokeWidth = 4,
    this.size = 70,
    this.absorbPointer = true,
    this.backgroundColor = AppColors.neutral50,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: absorbPointer,
      child: Container(
        color: backgroundColor,
        child: Center(
          child: SizedBox.square(
            dimension: size.sp,
            child: CircularProgressIndicator(
              strokeWidth: strokeWidth,
            ),
          ),
        ),
      ),
    );
  }
}
