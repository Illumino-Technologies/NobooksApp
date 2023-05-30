part of '../assessment_review_page.dart';

class _QuestionItem extends StatelessWidget {
  final bool answered;
  final int number;
  final VoidCallback onPressed;
  final bool enabled;

  const _QuestionItem({
    Key? key,
    required this.answered,
    required this.number,
    required this.onPressed,
    required this.enabled,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: enabled ? onPressed : null,
      child: Container(
        height: 64.r,
        width: 64.r,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: Ui.allBorderRadius(4),
          color: answered ? AppColors.blue900 : null,
          border: answered
              ? null
              : Border.all(
                  color: AppColors.blue900,
                  width: 1.r,
                ),
        ),
        child: Text(
          '$number'.padLeft(2, '0'),
          style: TextStyles.headline6.copyWith(
            height: 1.33,
            fontWeight: FontWeight.w400,
            color: answered ? AppColors.white : AppColors.blue900,
          ),
        ),
      ),
    );
  }
}
