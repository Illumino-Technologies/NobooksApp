import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router_flow/go_router_flow.dart';
import 'package:intl/intl.dart';
import 'package:nobook/src/features/assessments/assessments_barrel.dart';

// import 'package:nobook/src/global/domain/models/models_barrel.dart';
import 'package:nobook/src/global/global_barrel.dart';

// import 'package:nobook/src/utils/function/extensions/extensions.dart';
import 'package:nobook/src/utils/function/utility_functions_barrel.dart';

class TestPage extends ConsumerWidget {
  const TestPage({
    required this.assessmentsBySubject,
    required this.availableSubjects,
    super.key,
  });

  final Map<Subject, List<Assessment>> assessmentsBySubject;
  final List<Subject> availableSubjects;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.separated(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: assessmentsBySubject.length,
      separatorBuilder: (_, __) => 48.boxHeight,
      itemBuilder: (context, index) {
        final Subject subject = availableSubjects[index];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              subject.name,
              style: TextStyles.headline3.copyWith(
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.neutral600,
              ),
            ),
            24.boxHeight,
            SizedBox(
              height: 160.h,
              child: ListView.separated(
                separatorBuilder: (_, __) => 16.boxWidth,
                scrollDirection: Axis.horizontal,
                itemCount: assessmentsBySubject[subject]!.length,
                itemBuilder: (context, index) {
                  final Assessment assessment =
                      assessmentsBySubject[subject]![index];
                  return InkWell(
                    onTap: () {
                      context.goNamed(
                        AppRoute.assessmentStage.name,
                        extra: (assessment, AssessmentType.test),
                      );
                    },
                    child: Container(
                      height: 160.h,
                      width: 160.w,
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(8.r),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                        ),
                        child: SizedBox(
                          width: 128.w,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              16.boxHeight,
                              SubjectWidget(
                                subject: assessment.subject,
                                boxSize: 32.r,
                                fontSize: 16.sp,
                              ),
                              16.boxHeight,
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    assessment.subject.name,
                                    style: TextStyles.headline3.copyWith(
                                      fontSize: 12.sp,
                                      height: 1.33,
                                      color: AppColors.neutral600,
                                    ),
                                  ),
                                  4.boxHeight,
                                  Text(
                                    assessment.questionTypes.first.name,
                                    style: TextStyles.subHeading.copyWith(
                                      fontSize: 12.sp,
                                      height: 1.33,
                                      color: AppColors.neutral300,
                                    ),
                                  ),
                                  16.boxHeight,
                                  Text(
                                    '${UtilFunctions.formatLongDate(
                                      assessment.startTime,
                                      ', ',
                                    )} • ${UtilFunctions.formatTime(assessment.endTime)}',
                                    style: TextStyles.footer.copyWith(
                                      fontSize: 8.sp,
                                      height: 1.5,
                                      color: AppColors.neutral200,
                                    ),
                                  ),
                                  4.boxHeight,
                                  Text(
                                    'Expires ${DateFormat.MMMd().format(
                                      assessment.endTime,
                                    )}, ${DateFormat.jm().format(assessment.endTime).removeAllSpaces.toLowerCase()}',
                                    style: TextStyles.headline4.copyWith(
                                      fontSize: 8.sp,
                                      color: AppColors.neutral400,
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
      },
    );
  }
}
