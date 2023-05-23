part of '../theory_stage_page.dart';

class _QuestionView extends StatefulWidget {
  final AssessmentOperation operation;
  final OperationIndices operationIndexes;

  const _QuestionView({
    Key? key,
    required this.operation,
    required this.operationIndexes,
  }) : super(key: key);

  @override
  State<_QuestionView> createState() => _QuestionViewState();
}

class _QuestionViewState extends State<_QuestionView>
    with IntrinsicCanvasSizeMixin {
  late final AssessmentOperation operation = widget.operation;

  @override
  NoteDocumentController get controller => NoteDocumentController(
        noteDocument: operation.question,
      )..initialize();

  @override
  double get extraWidth => 20.w;

  @override
  double get extraHeight => 10.h;

  int get operationValue => widget.operationIndexes.operationIndex + 1;

  int? get subOperationValue => widget.operationIndexes.subIndex == null
      ? null
      : widget.operationIndexes.subIndex!;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 12.h),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '$operationValue ',
                style: TextStyles.subHeading.copyWith(
                  color: AppColors.neutral600,
                ),
              ),
              4.boxWidth,
              subOperationValue == null
                  ? 32.boxWidth
                  : Text(
                      '(${Values.lowerAlphas[subOperationValue!]})',
                      style: TextStyles.subHeading.copyWith(
                        color: AppColors.neutral600,
                      ),
                    ),
            ],
          ),
        ),
        24.boxWidth,
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AbsorbPointer(
              child: FocusScope(
                canRequestFocus: false,
                child: DocumentEditorCanvas(
                  canvasSize: canvasSize,
                  controller: controller,
                ),
              ),
            ),
            if (operation.marks != null)
              Container(
                alignment: Alignment.centerRight,
                margin: EdgeInsets.only(right: 44.w),
                child: Text(
                  '${operation.marks} mark${operation.marks?.pluralValue}}',
                  style: TextStyles.subHeading.copyWith(
                    color: AppColors.neutral600,
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}
