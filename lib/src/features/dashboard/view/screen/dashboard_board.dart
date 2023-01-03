// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nobook/src/core/themes/color.dart';
//import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:nobook/src/features/dashboard/view/widgets/dashboar_widget.dart';

import 'package:nobook/src/features/dashboard/view/widgets/card_widget.dart';

class DashboardBoard extends ConsumerStatefulWidget {
  const DashboardBoard({Key? key}) : super(key: key);
  @override
  DashboardScreenState createState() => DashboardScreenState();
}

class DashboardScreenState extends ConsumerState<DashboardBoard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 761.w,
        decoration: const BoxDecoration(
          color: AppColors.mBackgroundColor,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: SingleChildScrollView(
            child: Column(children: [
              SizedBox(height: 32.h),
              Center(child: DashboardWidget()),
              SizedBox(height: 32.h),
              Center(
                child: CardWidgets(),
              ),
              SizedBox(height: 32.h),
              Center(
                child: CardWidgets2(),
              ),
              SizedBox(height: 32.h),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Container(
                    width: 694.w,
                    height: 433.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        image: const DecorationImage(
                          image: AssetImage("assets/graph.png"),
                          fit: BoxFit.fill,
                        )),
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
