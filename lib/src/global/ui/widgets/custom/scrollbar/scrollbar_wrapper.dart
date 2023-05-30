import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nobook/src/global/ui/ui_barrel.dart';

class ScrollbarWrapper extends StatelessWidget {
  final Widget child;
  final ScrollController? controller;

  ///feel free to update fields if you need to add more params
  const ScrollbarWrapper({
    Key? key,
    required this.child,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScrollbarTheme(
      data: ScrollbarThemeData(
        trackBorderColor: MaterialStateProperty.all(Colors.transparent),
        trackColor: MaterialStateProperty.all(AppColors.grey100),
        thumbColor: MaterialStateProperty.all(AppColors.grey),
      ),
      child: Scrollbar(
        controller: controller,
        thickness: 16.w,
        radius: const Radius.circular(100),
        interactive: true,
        thumbVisibility: true,
        child: child,
      ),
    );
  }
}
