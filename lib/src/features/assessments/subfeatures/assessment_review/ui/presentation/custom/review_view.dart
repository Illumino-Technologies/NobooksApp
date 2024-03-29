part of '../assessment_review_page.dart';

class _ReviewView extends ConsumerWidget {
  const _ReviewView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Assessment assessment =
        ref.watch(AssessmentStageNotifier.provider).assessment!;
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              24.boxHeight,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.w),
                child: Row(
                  children: [
                    const AssessmentTimerWidget(),
                    const Spacer(),
                    AssessmentNavigatorBar(
                      assessment: assessment,
                      page: NavigatorBarPage.review,
                    ),
                    const Spacer(),
                    Text(
                      assessment.paperType.text,
                      style: TextStyles.subHeading.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.blue500,
                      ),
                    ),
                  ],
                ),
              ),
              64.boxHeight,
              _TopRibbon(type: assessment.type),
              96.boxHeight,
              _QuestionsView(assessment: assessment),
              80.boxHeight,
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: EdgeInsets.only(right: 44.w, bottom: 112.h),
            child: MaterialButton(
              elevation: 0,
              highlightElevation: 0,
              onPressed: () {
                final Assessment assessment_ =
                    ref.read(AssessmentStageNotifier.provider).assessment!;

                if (assessment_.hasNoAnswers) {
                  Ui.showErrorSnackbar(ErrorMessages.noAnswerProvided);
                  return;
                }
                ref
                    .read(AssessmentStageNotifier.provider.notifier)
                    .submit()
                    .then((value) {
                  context.goNamed(AppRoute.dashboard.name);
                }).onError((error, stackTrace) {
                  Ui.showErrorSnackbar(
                    error is Failure
                        ? error.message ?? error.toString()
                        : error.toString(),
                  );
                });
              },
              color: AppColors.blue500,
              padding: EdgeInsets.symmetric(horizontal: 56.w, vertical: 12.h),
              shape: RoundedRectangleBorder(
                borderRadius: Ui.allBorderRadius(8.r),
              ),
              child: Text(
                'Submit ${assessment.type.name.toFirstUpperCase()}',
                style: TextStyles.paragraph3.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.white,
                  height: 1.33,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
