part of '../record_page.dart';

class _SubjectsSideTab extends StatelessWidget {
  const _SubjectsSideTab();

  @override
  Widget build(BuildContext context) {
    return Container(
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
            'All Subjects Taken Up',
            style: TextStyles.headline1.withSize(18.sp).copyWith(
                  color: AppColors.neutral500,
                ),
          ),
          24.boxHeight,
          Expanded(
            child: SizedBox(
              width: 320.w,
              child: ListView.separated(
                itemCount: FakeSubjects.subjects.length,
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
                    expandedCrossAxisAlignment: CrossAxisAlignment.start,
                    title: Row(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SubjectWidget(
                          subject: FakeSubjects.subjects[index],
                          boxSize: 60.r,
                          fontSize: 30.sp,
                        ),
                        10.boxWidth,
                        Expanded(
                          child: Text(
                            FakeSubjects.subjects[index].name,
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Continuous Assessment',
                            style: TextStyles.paragraph1.withSize(10),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: AppColors.blueVariant05,
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 15.w,
                                vertical: 5.h,
                              ),
                              child: Text(
                                '40',
                                style:
                                    TextStyles.headline6.withSize(10).withBlack,
                              ),
                            ),
                          ),
                        ],
                      ),
                      20.boxHeight,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Examination',
                            style: TextStyles.paragraph1.withSize(10),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: AppColors.blueVariant05,
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 15.w,
                                vertical: 5.h,
                              ),
                              child: Text(
                                '40',
                                style:
                                    TextStyles.headline6.withSize(10).withBlack,
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
    );
  }
}
