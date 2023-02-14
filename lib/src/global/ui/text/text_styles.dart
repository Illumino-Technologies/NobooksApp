import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Use the extensionMethod withBold, withSemibold and withExtraBold to get the
/// textStyle's weighted counterparts
/// the weight defaults to the smallest weight
abstract class TextStyles {
  static final TextStyle headline1 = TextStyle(
    fontSize: 64.sp,
    height: 1.2,
    fontWeight: FontWeight.w600,
  );

  static final TextStyle headline2 = TextStyle(
    fontSize: 48.sp,
    height: 1.208,
    fontWeight: FontWeight.w600,
  );

  static final TextStyle headline3 = TextStyle(
    fontSize: 36.sp,
    height: 1.194,
    fontWeight: FontWeight.w600,
  );

  static final TextStyle headline4 = TextStyle(
    fontSize: 32.sp,
    height: 1.188,
    fontWeight: FontWeight.w600,
  );

  static final TextStyle headline5 = TextStyle(
    fontSize: 28.sp,
    height: 1.214,
    fontWeight: FontWeight.w600,
  );

  static final TextStyle headline6 = TextStyle(
    fontSize: 24.sp,
    height: 1.21,
    fontWeight: FontWeight.w600,
  );

  static final TextStyle subHeading = TextStyle(
    fontSize: 20.sp,
    height: 1.2,
    fontWeight: FontWeight.w400,
  );

  static final TextStyle paragraph1 = TextStyle(
    fontSize: 14.sp,
    height: 1.214,
    fontWeight: FontWeight.w400,
  );

  static final TextStyle paragraph2 = TextStyle(
    fontSize: 16.sp,
    height: 1.188,
    fontWeight: FontWeight.w400,
  );

  static final TextStyle paragraph3 = TextStyle(
    fontSize: 18.sp,
    height: 1.222,
    fontWeight: FontWeight.w400,
  );

  static final TextStyle footer = TextStyle(
    fontSize: 12.sp,
    height: 1.167,
    fontWeight: FontWeight.w400,
  );
}
