import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:nobook/src/features/assignments/assignments_barrel.dart';
import 'package:nobook/src/global/global_barrel.dart';
import 'package:nobook/src/utils/function/utility_functions_barrel.dart';

class AssignmentNoteWidget extends StatelessWidget {
  const AssignmentNoteWidget({
    super.key,
    required this.currentAssignment,
  });

  final Assignment currentAssignment;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 20.w,
      ),
      width: 160.w,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(8.r),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            16.boxHeight,
            SubjectWidget(
              subject: currentAssignment.subject,
              boxSize: 40.r,
              fontSize: 25.sp,
            ),
            20.boxHeight,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    currentAssignment.topic,
                    style: TextStyles.headline3.withSize(
                      14.sp,
                    ),
                  ),
                  8.boxHeight,
                  Text(
                    // currentNote.noteBody.isEmpty,
                    'Hello there',
                    style: TextStyles.headline4.withSize(
                      12.sp,
                    ),
                  ),
                  40.boxHeight,
                  Text(
                    DateFormat.yMEd().add_jms().format(
                          currentAssignment.createdDate,
                        ),
                    style: TextStyles.headline4
                        .withSize(
                          12.sp,
                        )
                        .copyWith(
                          color: AppColors.neutral400,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
