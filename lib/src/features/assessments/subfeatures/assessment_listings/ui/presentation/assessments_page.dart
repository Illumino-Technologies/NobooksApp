import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nobook/src/features/assessments/assessments_barrel.dart';
import 'package:nobook/src/features/assessments/subfeatures/assessment_listings/ui/presentation/widgets/test.dart';
import 'package:nobook/src/global/global_barrel.dart';
import 'package:nobook/src/utils/function/extensions/extensions.dart';

class AssessmentsPage extends StatefulWidget {
  const AssessmentsPage({Key? key}) : super(key: key);

  @override
  State<AssessmentsPage> createState() => _AssessmentsPageState();
}

class _AssessmentsPageState extends State<AssessmentsPage> {
  final ValueNotifier<bool> isTest = ValueNotifier<bool>(true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) {
          final List<Assessment> assessments =
              FakeAssessmentsData.getSubjectAssessments(
            startTime: DateTime.now(),
          );
          final List<Subject> availableSubjects =
              Set<Subject>.from(assessments.map((e) => e.subject)).toList();
          final Map<Subject, List<Assessment>> assessmentsBySubject = {};

          for (Subject subject in availableSubjects) {
            assessmentsBySubject.addAll({
              subject: assessments.where((element) {
                return element.subject == subject;
              }).toList(),
            });
          }
          return Row(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 32.w,
                      vertical: 32.h,
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Your Tests and Exams',
                              style: TextStyles.headline2.copyWith(
                                fontSize: 28.sp,
                                fontWeight: FontWeight.w700,
                                color: AppColors.neutral600,
                              ),
                            ),
                            Row(
                              children: [
                                ValueListenableBuilder(
                                  valueListenable: isTest,
                                  builder: (context, value, child) {
                                    return ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        elevation: 0,
                                        backgroundColor: isTest.value
                                            ? AppColors.blue500
                                            : AppColors.white,
                                        // : Colors.white,
                                      ),
                                      onPressed: () {
                                        isTest.value = true;
                                      },
                                      child: Text(
                                        'Test',
                                        style: TextStyles.headline3
                                            .withSize(16.sp)
                                            .copyWith(
                                              color: isTest.value
                                                  ? AppColors.white
                                                  : AppColors.black,
                                            ),
                                      ),
                                    );
                                  },
                                ),
                                10.boxWidth,
                                ValueListenableBuilder(
                                  valueListenable: isTest,
                                  builder: (context, value, child) {
                                    return ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        elevation: 0,
                                        backgroundColor: !value
                                            ? AppColors.blue500
                                            : AppColors.white,
                                        // : Colors.white,
                                      ),
                                      onPressed: () {
                                        isTest.value = false;
                                      },
                                      child: Text(
                                        'Exam',
                                        style: TextStyles.headline3
                                            .withSize(16.sp)
                                            .copyWith(
                                              color: !isTest.value
                                                  ? AppColors.white
                                                  : AppColors.black,
                                            ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            )
                          ],
                        ),
                        24.boxHeight,
                        ValueListenableBuilder(
                          valueListenable: isTest,
                          builder: (context, value, child) {
                            return isTest.value
                                ? TestPage(
                                    assessmentsBySubject: assessmentsBySubject,
                                    availableSubjects: availableSubjects,
                                  )
                                : Container();
                          },
                        )
                      ],
                    ),
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
                      style: TextStyles.headline1
                          .withSize(18.sp)
                          .copyWith(color: AppColors.neutral500),
                    ),
                    24.boxHeight,
                    Expanded(
                      child: SizedBox(
                        width: 320.w,
                        child: ListView.separated(
                          itemCount: availableSubjects.length,
                          // itemCount: FakeAssignmentData.assignments.length,
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
                                    subject: availableSubjects[index],
                                    boxSize: 60.r,
                                    fontSize: 30.sp,
                                  ),
                                  10.boxWidth,
                                  Expanded(
                                    child: Text(
                                      availableSubjects[index].name,
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
                                        borderRadius: BorderRadius.circular(
                                          10.r,
                                        ),
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
                                        borderRadius: BorderRadius.circular(
                                          10.r,
                                        ),
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
                    )
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
