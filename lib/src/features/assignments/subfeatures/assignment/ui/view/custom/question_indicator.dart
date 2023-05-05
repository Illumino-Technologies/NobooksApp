part of '../assignment_screen.dart';

class QuestionIndicator extends StatelessWidget {
  final int currentIndex, questionLength;
  final VoidCallback onPreviousPressed;
  final VoidCallback onNextPressed;

  const QuestionIndicator({
    Key? key,
    required this.currentIndex,
    required this.questionLength,
    required this.onPreviousPressed,
    required this.onNextPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: currentIndex == 0 ? null : onPreviousPressed,
          icon: Icon(
            Icons.arrow_back_ios,
            color: currentIndex == 0 ? AppColors.grey100 : AppColors.grey270,
          ),
        ),
        4.boxWidth,
        Text(
          'Question ${(currentIndex + 1).toString().padLeft(2, '0')} of'
          ' ${questionLength.toString().padLeft(2, '0')}',
          style: TextStyles.headline1.copyWith(
            fontSize: 20,
            color: AppColors.blue500,
          ),
        ),
        4.boxWidth,
        IconButton(
          onPressed:
              currentIndex == (questionLength - 1) ? null : onNextPressed,
          icon: Icon(
            Icons.arrow_forward_ios,
            color: currentIndex == (questionLength - 1)
                ? AppColors.grey100
                : AppColors.grey270,
          ),
        ),
      ],
    );
  }
}
