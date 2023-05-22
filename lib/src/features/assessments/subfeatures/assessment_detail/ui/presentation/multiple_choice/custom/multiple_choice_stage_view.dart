part of '../multiple_choice_assessment_stage_page.dart';

class MultipleChoiceView extends ConsumerWidget {
  final Assessment assessment;
  final ScrollController scrollController;

  const MultipleChoiceView({
    Key? key,
    required this.assessment,
    required this.scrollController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: AppColors.white,
      child: ListView.separated(
        controller: scrollController,
        itemCount: assessment.assessments.length,
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
        separatorBuilder: (context, index) => 64.boxHeight,
        itemBuilder: (context, index) => _MCQOperationItem(
          index: index,
          key: ValueKey(
            '${assessment.assessments[index].id} ${index + 1} ${assessment.assessments[index].answer}',
          ),
        ),
      ),
    );
  }
}
