import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router_flow/go_router_flow.dart';
import 'package:nobook/src/features/notes/model/note_list.dart';
import 'package:nobook/src/global/ui/ui_barrel.dart';
import 'package:nobook/src/utils/utils_barrel.dart';

class DashboardWidget extends ConsumerWidget {
  const DashboardWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    return Column(
      children: [
        Container(
          width: 694.w,
          padding: EdgeInsets.symmetric(
            horizontal: 40.w,
            vertical: 29.h,
          ),
          decoration: const BoxDecoration(
            color: AppColors.blue500,
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 389.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Exam is close!!!',
                      style: TextStyles.headline5.asBold.withWhite,
                    ),
                    8.boxHeight,
                    Text(
                      'The First term examination for the 2022/2023 Academic session comes up on the 3rd of December, 2022. You need to study your notes to prepare well for the exam.',
                      style: TextStyles.paragraph1.asSemibold.withColor(
                        AppColors.neutral50,
                      ),
                    ),
                    16.boxHeight,
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2.0),
                      ),
                      height: 33.h,
                      minWidth: 105.w,
                      color: const Color.fromRGBO(255, 255, 255, 1),
                      child: Text(
                        'Get Started',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 8.sp,
                          color: AppColors.blue500,
                        ),
                      ),
                      onPressed: () {
                        context.pushNamed(
                          AppRoute.noteDetailPage.name,
                          extra: FakeNotes.allNotes[1],
                        );
                      },
                    )
                  ],
                ),
              ),
              Image.asset(
                'assets/images/books.png',
                height: 142.h,
                width: 166.w,
              )
            ],
          ),
        ),
      ],
    );
  }
}
