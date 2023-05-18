part of '../assignments_page.dart';

class AssignmentNoteWidget extends StatelessWidget {
  const AssignmentNoteWidget({
    super.key,
    required this.currentAssignment,
  });

  final Assignment currentAssignment;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.goNamed(
        AppRoute.assignment.name,
        extra: currentAssignment,
      ),
      child: Align(
        child: Container(
          height: 160.h,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(8.r),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: SizedBox(
              width: 128.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  16.boxHeight,
                  SubjectWidget(
                    subject: currentAssignment.subject,
                    boxSize: 32.r,
                    fontSize: 16.sp,
                  ),
                  16.boxHeight,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        currentAssignment.subject.name,
                        style: TextStyles.headline3.copyWith(
                          fontSize: 12.sp,
                          height: 1.33,
                          color: AppColors.neutral600,
                        ),
                      ),
                      4.boxHeight,
                      Text(
                        currentAssignment.topic,
                        style: TextStyles.subHeading.copyWith(
                          fontSize: 12.sp,
                          height: 1.33,
                          color: AppColors.neutral300,
                        ),
                      ),
                      16.boxHeight,
                      Text(
                        '${UtilFunctions.formatLongDate(
                          currentAssignment.createdDate,
                          ', ',
                        )} • ${UtilFunctions.formatTime(
                          currentAssignment.submissionDate,
                        )}',
                        style: TextStyles.footer.copyWith(
                          fontSize: 8.sp,
                          height: 1.5,
                          color: AppColors.neutral200,
                        ),
                      ),
                      4.boxHeight,
                      Text(
                        'Expires ${DateFormat.MMMd().format(
                          currentAssignment.submissionDate,
                        )}, ${DateFormat.jm().format(
                              currentAssignment.submissionDate,
                            ).removeAllSpaces.toLowerCase()}',
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
      ),
    );
  }
}
