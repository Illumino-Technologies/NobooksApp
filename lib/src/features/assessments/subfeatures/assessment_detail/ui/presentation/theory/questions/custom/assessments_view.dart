part of '../theory_questions_page.dart';

class _AssessmentsView extends StatelessWidget {
  final Assessment assessment;

  const _AssessmentsView({
    Key? key,
    required this.assessment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: assessment.assessments.length,
      separatorBuilder: (context, index) => 75.boxHeight,
      itemBuilder: (context, index) {
        final TheoryAssessmentOperation assessmentOperation =
            (assessment.assessments.cast<TheoryAssessmentOperation>())[index];

        if (assessmentOperation.subOperations.isEmpty) {
          return _TheoryAssessmentWidget(
            index: index,
            operation: assessmentOperation,
            onPressed: () {},
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...assessmentOperation.subOperations.map(
              (subOperation) {
                final bool isFirst =
                    assessmentOperation.subOperations.isFirst(subOperation);
                return Padding(
                  padding: EdgeInsets.only(
                    top: isFirst ? 0 : 2.h,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 9.h),
                        child: Text(
                          isFirst ? '${index + 1}   '.toString() : '     ',
                          style: TextStyles.subHeading.copyWith(
                            color: AppColors.neutral600,
                          ),
                        ),
                      ),
                      Expanded(
                        child: _TheoryAssessmentLeafWidget(
                          index: assessmentOperation.subOperations.indexOf(
                            subOperation,
                          ),
                          operation: subOperation,
                          onPressed: () {},
                          key: UniqueKey(),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
