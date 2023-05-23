part of '../theory_stage_page.dart';

class _TheoryAssessmentOperationItem extends StatefulWidget {
  final TheoryAssessmentOperation operation;
  final OperationIndices indices;

  const _TheoryAssessmentOperationItem({
    super.key,
    required this.operation,
    required this.indices,
  });

  @override
  State<_TheoryAssessmentOperationItem> createState() =>
      _TheoryAssessmentOperationItemState();
}

class _TheoryAssessmentOperationItemState
    extends State<_TheoryAssessmentOperationItem> {
  late final TheoryAssessmentOperation operation = widget.operation;

  late final NoteDocumentController controller = NoteDocumentController(
    noteDocument: operation.answer,
  )..initialize();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ToolBarWidget(controller: controller),
        Expanded(
          child: _QuestionView(
            operation: operation,
            operationIndexes: widget.indices,
          ),
        ),
      ],
    );
  }
}
