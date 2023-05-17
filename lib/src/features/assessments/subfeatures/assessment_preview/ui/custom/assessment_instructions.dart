part of '../assessment_preview_page.dart';

class _AssessmentInstructions extends StatelessWidget {
  final Assessment assessment;

  const _AssessmentInstructions({
    Key? key,
    required this.assessment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${assessment.type.longName} Conduct',
          style: TextStyles.headline6.copyWith(
            height: 1.33,
            color: AppColors.neutral600,
          ),
        ),
        24.boxHeight,
        if (assessment.assessmentInstructions.containsWhere(
            (value) => value.runtimeType == TextEditorController))
          TextField(
            controller: (assessment.assessmentInstructions.firstWhere(
                    (element) => element.runtimeType == TextEditorController)
                as TextEditorController),
            maxLines: null,
            readOnly: true,
            enabled: false,
          ),
        DocumentEditorCanvas(
          canvasSize: Size(double.infinity, 600.h),
          readOnly: true,
          controller: NoteDocumentController(
            noteDocument: assessment.assessmentInstructions,
          )..initialize(),
        ),
      ],
    );
  }
}
