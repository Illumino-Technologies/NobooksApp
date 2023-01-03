import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nobook/src/core/themes/color.dart';

class DashboardWidget extends ConsumerWidget {
  const DashboardWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    return Container(
      height: 200.h,
      width: 694.w,
      decoration: const BoxDecoration(
          color: AppColors.mBackgroundColor, //kDashWidgetColor
          borderRadius: BorderRadius.all(Radius.circular(8))),
      child: Container(
        decoration: const BoxDecoration(
            color: AppColors.blue,
            borderRadius: BorderRadius.all(Radius.circular(8))),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 30,
          ),
          child: Row(
            children: [
              // ignore: prefer_const_literals_to_create_immutables
              SizedBox(
                width: 350.w,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 8.h,
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0.sp),
                        child: SizedBox(
                          width: 196.w,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text('Exam is close!!!',
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 28.sp,
                                    color: const Color.fromRGBO(
                                        255, 255, 255, 1))),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 389.w,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'The First term examination for the 2022/2023 Academic session comes up on the 3rd of December, 2022. You need to study your notes to prepare well for the exam.',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14.sp,
                                color: const Color.fromRGBO(234, 235, 237, 1)),
                          ),
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Padding(
                        padding: EdgeInsets.all(8.0.sp),
                        child: MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4.0)),
                            height: 33.h,
                            minWidth: 105.w,
                            color: const Color.fromRGBO(255, 255, 255, 1),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Get Started',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14.sp,
                                    color: Colors.blue[500]),
                              ),
                            ),
                            onPressed: () {}),
                      )
                    ]),
              ),
              const Spacer(),
              Container(
                height: 142.h,
                width: 166.w,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/books.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
