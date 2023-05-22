part of '../multiple_choice_assessment_stage_page.dart';

class _MCQOperationItem extends ConsumerWidget {
  final int index;

  const _MCQOperationItem({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final MultipleChoiceAssessmentOperation operation = ref.watch(
      AssessmentStageNotifier.provider.select(
        (value) => value.assessment!.assessments[index]
            as MultipleChoiceAssessmentOperation,
      ),
    );

    return Column(
      children: [
        _QuestionView(
          index: index,
          question: operation.question,
        ),
        8.boxHeight,
        ...operation.options.map((option) {
          return _OptionView(
            key: ValueKey('${operation.mcqAnswer} $option ${operation.id}'),
            onChanged: () {
              final List<MultipleChoiceAssessmentOperation> assessments = ref
                  .read(AssessmentStageNotifier.provider)
                  .assessment!
                  .assessments
                  .cast();

              assessments.replaceWhere(
                [
                  operation.copyWith(
                    answer: operation.options.indexOf(option),
                  ),
                ],
                (element) =>
                    assessments.indexOf(element) ==
                    assessments.indexOf(operation),
              );

              ref
                  .read(AssessmentStageNotifier.provider.notifier)
                  .updateAssessment(
                    ref
                        .read(AssessmentStageNotifier.provider)
                        .assessment!
                        .copyWith(assessments: List.from(assessments)),
                  );
            },
            index: operation.options.indexOf(option),
            option: option,
            selected: operation.mcqAnswer == null
                ? false
                : operation.mcqAnswer == operation.options.indexOf(option),
          );
        }).toList(),
      ],
    );
  }

  void effectChange(WidgetRef ref) {}
}
