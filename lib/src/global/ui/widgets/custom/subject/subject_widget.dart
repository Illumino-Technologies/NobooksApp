import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nobook/src/global/domain/domain_barrel.dart';
import 'package:nobook/src/global/ui/ui_barrel.dart';
import 'package:nobook/src/utils/utils_barrel.dart';

class SubjectWidget extends StatelessWidget {
  final Subject subject;
  final double boxSize;
  final double fontSize;

  const SubjectWidget({
    Key? key,
    required this.subject,
    this.boxSize = 40,
    this.fontSize = 18,
  }) : super(key: key);

  const SubjectWidget.small({
    Key? key,
    required this.subject,
    this.boxSize = 32,
    this.fontSize = 16,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: boxSize.r,
      height: boxSize.r,
      decoration: BoxDecoration(
        color: subject.color,
        borderRadius: Ui.allBorderRadius(4.r),
      ),
      alignment: Alignment.center,
      child: Text(
        subject.code.cleanUpper,
        style: TextStyles.headline6.copyWith(
          color: AppColors.white,
          fontSize: fontSize.sp,
        ),
      ),
    );
  }
}
