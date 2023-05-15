import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:nobook/src/features/assessments/assessments_barrel.dart';
// import 'package:nobook/src/features/assignments/domain/fakes/fake_assignments.dart';
import 'package:nobook/src/global/domain/domain_barrel.dart';
import 'package:nobook/src/global/global_barrel.dart';
import 'package:nobook/src/utils/function/extensions/extensions.dart';

import '../../../../../../utils/function/util_functions/util_functions.dart';

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
                            'Your Assignments',
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
                                      backgroundColor: !isTest.value
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
                                ? ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    itemCount: assessmentsBySubject.length,
                                    itemBuilder: (context, index) {
                                      final Subject subject =
                                          availableSubjects[index];
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            subject.name,
                                            style:
                                                TextStyles.headline3.copyWith(
                                              fontSize: 20.sp,
                                              fontWeight: FontWeight.w700,
                                              color: AppColors.neutral600,
                                            ),
                                          ),
                                          24.boxHeight,
                                          SizedBox(
                                            height: 160.h,
                                            child: ListView.separated(
                                              separatorBuilder: (_, __) =>
                                                  16.boxWidth,
                                              scrollDirection: Axis.horizontal,
                                              itemCount:
                                                  assessmentsBySubject[subject]!
                                                      .length,
                                              itemBuilder: (context, index) {
                                                final Assessment assessment =
                                                    assessmentsBySubject[
                                                        subject]![index];
                                                return Align(
                                                  child: Container(
                                                    height: 160.h,
                                                    decoration: BoxDecoration(
                                                      color: AppColors.white,
                                                      borderRadius:
                                                          BorderRadius.all(
                                                        Radius.circular(8.r),
                                                      ),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                        horizontal: 16.w,
                                                      ),
                                                      child: SizedBox(
                                                        width: 128.w,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            16.boxHeight,
                                                            SubjectWidget(
                                                              subject:
                                                                  assessment
                                                                      .subject,
                                                              boxSize: 32.r,
                                                              fontSize: 16.sp,
                                                            ),
                                                            16.boxHeight,
                                                            Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  assessment
                                                                      .subject
                                                                      .name,
                                                                  style: TextStyles
                                                                      .headline3
                                                                      .copyWith(
                                                                    fontSize:
                                                                        12.sp,
                                                                    height:
                                                                        1.33,
                                                                    color: AppColors
                                                                        .neutral600,
                                                                  ),
                                                                ),
                                                                4.boxHeight,
                                                                Text(
                                                                  assessment
                                                                      .subject
                                                                      .name,
                                                                  style: TextStyles
                                                                      .subHeading
                                                                      .copyWith(
                                                                    fontSize:
                                                                        12.sp,
                                                                    height:
                                                                        1.33,
                                                                    color: AppColors
                                                                        .neutral300,
                                                                  ),
                                                                ),
                                                                16.boxHeight,
                                                                Text(
                                                                  '${UtilFunctions.formatLongDate(
                                                                    assessment
                                                                        .startTime,
                                                                    ', ',
                                                                  )} • ${UtilFunctions.formatTime(assessment.endTime)}',
                                                                  style: TextStyles
                                                                      .footer
                                                                      .copyWith(
                                                                    fontSize:
                                                                        8.sp,
                                                                    height: 1.5,
                                                                    color: AppColors
                                                                        .neutral200,
                                                                  ),
                                                                ),
                                                                4.boxHeight,
                                                                Text(
                                                                  'Expires ${DateFormat.MMMd().format(
                                                                    assessment
                                                                        .endTime,
                                                                  )}, ${DateFormat.jm().format(assessment.endTime).removeAllSpaces.toLowerCase()}',
                                                                  style: TextStyles
                                                                      .headline4
                                                                      .copyWith(
                                                                    fontSize:
                                                                        8.sp,
                                                                    color: AppColors
                                                                        .neutral400,
                                                                    height: 1.5,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      );
                                    })
                                : Container();
                          })
                    ],
                  ),
                ),
              ))
            ],
          );
        },
      ),
    );
  }
}
