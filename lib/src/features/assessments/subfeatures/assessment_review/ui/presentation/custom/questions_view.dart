part of '../assessment_review_page.dart';

class _QuestionsView extends ConsumerStatefulWidget {
  final Assessment assessment;

  const _QuestionsView({
    Key? key,
    required this.assessment,
  }) : super(key: key);

  @override
  ConsumerState createState() => _QuestionsViewState();
}

class _QuestionsViewState extends ConsumerState<_QuestionsView> {
  late final Assessment assessment = widget.assessment;
  List<AssessmentOperation> operations = [];

  void onItemPressed(int index) => switch (assessment.paperType) {
        PaperType.theory => context.goNamed(
            AppRoute.theoryAssessmentStage.name,
            extra: assessment,
            params: {
              'operationIndex': index.toString(),
            },
          ),
        PaperType.multipleChoice => context.goNamed(
            AppRoute.multipleChoiceAssessmentStage.name,
            extra: assessment,
          ),
        _ => null,
      };

  @override
  Widget build(BuildContext context) {
    final bool buttonEnabled = ref.watch(
          AssessmentTimerStateNotifier.requireProvider.select((value) {
            return value.inSeconds;
          }),
        ) <=
        1;
    return SizedBox(
      width: 856.w,
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: 24.w,
        runSpacing: 24.h,
        children: [
          ...widget.assessment.assessments.map((e) {
            final dynamic answer = e.answer;
            return _QuestionItem(
              enabled: buttonEnabled,
              answered: (() {
                if (e is TheoryAssessmentOperation) {
                  final bool isAnswered = e.subOperations.every(
                    (element) => element.answer.isNotNullNorEmpty,
                  );
                  return isAnswered;
                }
                return (answer is List?)
                    ? answer.isNotNullNorEmpty
                    : (answer is int?)
                        ? answer != null
                        : false;
              }()),
              number: widget.assessment.assessments.indexOf(e) + 1,
              onPressed: () => onItemPressed(
                widget.assessment.assessments.indexOf(e),
              ),
            );
          })
        ],
      ),
    );
  }
}
