part of '../theory_questions_page.dart';

class _TheoryAssessmentWidget extends StatefulWidget {
  final TheoryAssessmentOperation operation;
  final VoidCallback onPressed;
  final int index;

  const _TheoryAssessmentWidget({
    Key? key,
    required this.operation,
    required this.onPressed,
    required this.index,
  }) : super(key: key);

  @override
  State<_TheoryAssessmentWidget> createState() =>
      _TheoryAssessmentWidgetState();
}

class _TheoryAssessmentWidgetState extends State<_TheoryAssessmentWidget>
    with IntrinsicCanvasSizeMixin {
  TheoryAssessmentOperation get operation => widget.operation;

  @override
  NoteDocumentController get controller => NoteDocumentController(
        noteDocument: widget.operation.question,
      )..initialize();

  @override
  double get extraWidth => 20.w;

  @override
  double get extraHeight => 10.h;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Text(
              (widget.index + 1).toString(),
              style: TextStyles.subHeading.copyWith(
                color: AppColors.neutral600,
              ),
            ),
            24.boxWidth,
            Expanded(
              child: DocumentEditorCanvas(
                readOnly: true,
                canvasSize: canvasSize,
                controller: controller,
              ),
            ),
          ],
        ),
        if (operation.marks != null)
          Container(
            margin: EdgeInsets.only(right: 44.w),
            alignment: Alignment.centerRight,
            child: Text(
              '(${operation.marks} mark${operation.marks?.pluralValue})',
              style: TextStyles.paragraph2
                  .withColor(AppColors.neutral500)
                  .asSemibold,
            ),
          ),
      ],
    );
  }
}
