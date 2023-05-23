part of '../theory_questions_page.dart';

class _TheoryAssessmentLeafWidget extends StatefulWidget {
  final TheoryAssessmentOperationLeaf operation;
  final VoidCallback onPressed;
  final int index;

  const _TheoryAssessmentLeafWidget({
    Key? key,
    required this.operation,
    required this.onPressed,
    required this.index,
  }) : super(key: key);

  @override
  State<_TheoryAssessmentLeafWidget> createState() =>
      _TheoryAssessmentLeafWidgetState();
}

class _TheoryAssessmentLeafWidgetState
    extends State<_TheoryAssessmentLeafWidget> with IntrinsicCanvasSizeMixin {
  TheoryAssessmentOperationLeaf get operation => widget.operation;

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
    return RawMaterialButton(
      onPressed: widget.onPressed,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Text(
                '(${Values.lowerAlphas[widget.index]})',
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
      ),
    );
  }
}
