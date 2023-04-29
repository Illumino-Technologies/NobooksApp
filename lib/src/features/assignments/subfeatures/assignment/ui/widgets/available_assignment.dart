import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nobook/src/features/assignments/assignments_barrel.dart';
import 'package:nobook/src/features/assignments/subfeatures/assignment/ui/widgets/assignment_note.dart';
import 'package:nobook/src/global/global_barrel.dart';
import 'package:nobook/src/utils/function/utility_functions_barrel.dart';

class AvailableAssignmentWidget extends StatelessWidget {
  const AvailableAssignmentWidget({
    required this.currentAssignmentSubject,
    required this.assignmentNotes,
    super.key,
  });

  final Subject currentAssignmentSubject;
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
                currentAssignmentSubject.name,
                style: TextStyles.headline1.withSize(24.sp),
              ),
            ],
          ),
          20.boxHeight,
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 260.h,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount:
                        assignmentNotes[currentAssignmentSubject]!.length,
                    itemBuilder: (context, index) {
                      final Assignment currentAssignment =
                          assignmentNotes[currentAssignmentSubject]![index];
                      return AssignmentNoteWidget(
                        currentAssignment: currentAssignment,
                      );
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
