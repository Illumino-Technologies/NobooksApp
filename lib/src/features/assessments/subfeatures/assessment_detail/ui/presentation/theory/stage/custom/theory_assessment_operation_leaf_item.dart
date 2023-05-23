part of '../theory_stage_page.dart';

class _TheoryAssessmentOperationLeafItem extends StatefulWidget {
  final TheoryAssessmentOperationLeaf operation;
  final OperationIndices indices;

  const _TheoryAssessmentOperationLeafItem({
    super.key,
    required this.operation,
    required this.indices,
  });

  @override
  State<_TheoryAssessmentOperationLeafItem> createState() =>
      _TheoryAssessmentOperationLeafItemState();
}

class _TheoryAssessmentOperationLeafItemState
    extends State<_TheoryAssessmentOperationLeafItem>
    with IntrinsicCanvasSizeMixin {
  late final TheoryAssessmentOperationLeaf operation = widget.operation;

  //TODO: implement saving
  @override
  NoteDocumentController get controller => _controller;

  late final NoteDocumentController _controller = NoteDocumentController(
    noteDocument: operation.answer,
  )..initialize();

  @override
  double get extraWidth => 0.w;

  @override
  double get extraHeight => 0.h;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ToolBarWidget(controller: controller),
        32.boxHeight,
        _QuestionView(
          operation: operation,
          operationIndexes: widget.indices,
        ),
        Container(
          color: AppColors.white,
          child: DocumentEditorCanvas(
            canvasSize: canvasSize.width == 0 || canvasSize.height == 0
                ? Size(900.w, 900.h)
                : canvasSize,
            controller: controller,
          ),
        ),
      ],
    );
  }
}
