import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension BuildContextExtension on BuildContext {
  Size get size => MediaQuery.of(this).size;
  double get height => size.height;
  double get width => size.width;
}

// extension ResponsivenessExtension on num {
//   double get height => h;
//   double get width => w;
//   double get fontSize => sp + ScreenUtil().setSp(toInt());
//  // ScreenUtil().setSp(28) 

//}