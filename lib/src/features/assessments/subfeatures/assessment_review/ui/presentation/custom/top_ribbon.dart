part of '../assessment_review_page.dart';

class _TopRibbon extends StatelessWidget {
  final AssessmentType type;

  const _TopRibbon({
    Key? key,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.blue900,
      padding: EdgeInsets.symmetric(vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'You’ve come to the end of your assessment',
            textAlign: TextAlign.center,
            style: TextStyles.headline4.copyWith(
              fontWeight: FontWeight.w400,
              color: AppColors.white,
              height: 1.5,
            ),
          ),
          16.boxHeight,
          Text(
            'Check below for unanswered question(s).\n'
            'Make sure to check through carefully, there will be no opportunity'
            ' to redo this exam.',
            textAlign: TextAlign.center,
            style: TextStyles.headline4.copyWith(
              fontWeight: FontWeight.w500,
              color: AppColors.white,
              height: 1.333,
            ),
          )
        ],
      ),
    );
  }
}
