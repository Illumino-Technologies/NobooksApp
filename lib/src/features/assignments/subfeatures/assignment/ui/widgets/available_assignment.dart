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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          currentAssignmentSubject.name,
          style: TextStyles.paragraph3.copyWith(
            color: AppColors.neutral500,
            fontWeight: FontWeight.w700,
          ),
        ),
        24.boxHeight,
        SizedBox(
          height: 160.h,
          child: ListView.separated(
            separatorBuilder: (_, __) => 16.boxWidth,
            scrollDirection: Axis.horizontal,
            itemCount: assignmentNotes[currentAssignmentSubject]!.length,
            itemBuilder: (context, index) {
              final Assignment currentAssignment =
                  assignmentNotes[currentAssignmentSubject]![index];
              return AssignmentNoteWidget(
                currentAssignment: currentAssignment,
              );
            },
          ),
        ),
      ],
    );
  }
}
