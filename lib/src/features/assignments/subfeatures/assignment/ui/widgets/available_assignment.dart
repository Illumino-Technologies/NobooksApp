import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nobook/src/features/assignments/assignments_barrel.dart';
import 'package:nobook/src/features/assignments/subfeatures/assignment/ui/widgets/assignment_note.dart';
import 'package:nobook/src/global/global_barrel.dart';
import 'package:nobook/src/utils/function/utility_functions_barrel.dart';

class AvailableAssignmentWidget extends StatelessWidget {
  const AvailableAssignmentWidget({
    required this.currentSubject,
    required this.assignmentNotes,
    super.key,
  });

  final Subject currentSubject;
  final Map<Subject, List<Assignment>> assignmentNotes;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 20.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                currentSubject.name,
                style: TextStyles.headline1.withSize(24.sp),
              ),
            ],
          ),
          20.boxHeight,
          Row(
            children: [
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 20.w,
                ),
                height: 260.h,
                width: 160.w,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(8.r),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/plus.png',
                    ),
                    8.boxHeight,
                    Text(
                      'Add Note',
                      style: TextStyles.headline3.withSize(14.sp),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SizedBox(
                  height: 260.h,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: assignmentNotes[currentSubject]!.length,
                    itemBuilder: (context, index) {
                      final Assignment currentAssignment =
                          assignmentNotes[currentSubject]![index];
                      return AssignmentNoteWidget(
                          currentAssignment: currentAssignment);
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
