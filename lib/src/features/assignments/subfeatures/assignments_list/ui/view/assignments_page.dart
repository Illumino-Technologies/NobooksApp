import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nobook/src/features/assignments/assignments_barrel.dart';
import 'package:nobook/src/features/assignments/subfeatures/assignment/ui/widgets/available_assignment.dart';
import 'package:nobook/src/global/domain/domain_barrel.dart';
import 'package:nobook/src/global/ui/ui_barrel.dart';
import 'package:nobook/src/utils/utils_barrel.dart';

class AssignmentsPage extends ConsumerStatefulWidget {
  const AssignmentsPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AssignmentPageState();
}

class _AssignmentPageState extends ConsumerState<AssignmentsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) {
          final List<Assignment> assignments = FakeAssignmentData.assignments;
          final List<Subject> availableAssignments =
              Set<Subject>.from(assignments.map((e) => e.subject)).toList();

          final Map<Subject, List<Assignment>> assignmentsBySubject = {};

          for (Subject subject in availableAssignments) {
            assignmentsBySubject.addAll({
              subject: assignments.where((element) {
                return element.subject == subject;
              }).toList(),
            });
          }
          return Row(
            children: [
              Expanded(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 32.w, vertical: 32.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Your Assignments',
                        style: TextStyles.headline2.copyWith(
                          fontSize: 28.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.neutral600,
                        ),
                      ),
                      20.boxHeight,
                      Expanded(
                        child: ListView.separated(
                          shrinkWrap: true,
                          itemCount: availableAssignments.length,
                          separatorBuilder: (_, __) => 48.boxHeight,
                          itemBuilder: (context, index) {
                            final Subject currentAssignment =
                                availableAssignments[index];
                            return AvailableAssignmentWidget(
                              currentAssignmentSubject: currentAssignment,
                              assignmentNotes: assignmentsBySubject,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: 320.w,
                margin: EdgeInsets.symmetric(vertical: 32.h, horizontal: 32.w),
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: Ui.allBorderRadius(8.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    24.boxHeight,
                    Text(
                      'Your Subject',
                      style: TextStyles.headline1.withSize(18.sp).copyWith(
                            color: AppColors.neutral500,
                          ),
                    ),
                    24.boxHeight,
                    Expanded(
                      child: SizedBox(
                        width: 320.w,
                        child: ListView.separated(
                          itemCount: FakeAssignmentData.assignments.length,
                          separatorBuilder: (_, __) => 16.boxHeight,
                          itemBuilder: (context, index) => Container(
                            decoration: BoxDecoration(
                              borderRadius: Ui.allBorderRadius(8.r),
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset.zero,
                                  blurRadius: 5,
                                  spreadRadius: 0,
                                  color: AppColors.black.withOpacity(0.05),
                                )
                              ],
                              color: context.theme.colorScheme.background,
                            ),
                            child: ExpansionTile(
                              iconColor: AppColors.neutral600,
                              textColor: AppColors.neutral600,
                              shape: const RoundedRectangleBorder(
                                side: BorderSide.none,
                              ),
                              expandedAlignment: Alignment.centerLeft,
                              expandedCrossAxisAlignment:
                                  CrossAxisAlignment.start,
                              title: Row(
                                // mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SubjectWidget(
                                    subject: FakeAssignmentData
                                        .assignments[index].subject,
                                    boxSize: 60.r,
                                    fontSize: 30.sp,
                                  ),
                                  10.boxWidth,
                                  Expanded(
                                    child: Text(
                                      FakeAssignmentData
                                          .assignments[index].subject.name,
                                      style: TextStyles.paragraph1.asSemibold,
                                    ),
                                  ),
                                ],
                              ),
                              childrenPadding: EdgeInsets.symmetric(
                                horizontal: 8.w,
                                vertical: 8.h,
                              ),
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Continuous Assessment',
                                      style: TextStyles.paragraph1.withSize(10),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: AppColors.blueVariant05,
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 15.w,
                                          vertical: 5.h,
                                        ),
                                        child: Text(
                                          '40',
                                          style: TextStyles.headline6
                                              .withSize(10)
                                              .withBlack,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                20.boxHeight,
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Examination',
                                      style: TextStyles.paragraph1.withSize(10),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: AppColors.blueVariant05,
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 15.w,
                                          vertical: 5.h,
                                        ),
                                        child: Text(
                                          '40',
                                          style: TextStyles.headline6
                                              .withSize(10)
                                              .withBlack,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
