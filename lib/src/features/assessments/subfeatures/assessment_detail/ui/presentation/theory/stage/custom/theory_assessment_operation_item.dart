part of '../theory_stage_page.dart';

class _TheoryAssessmentOperationItem extends ConsumerStatefulWidget {
  final TheoryAssessmentOperation operation;
  final OperationIndices indices;

  const _TheoryAssessmentOperationItem({
    super.key,
    required this.operation,
    required this.indices,
  });

  @override
  ConsumerState createState() => __TheoryAssessmentOperationItemState();
}

class __TheoryAssessmentOperationItemState
    extends ConsumerState<_TheoryAssessmentOperationItem>
    with IntrinsicCanvasSizeMixin {
  late final TheoryAssessmentOperation operation = widget.operation;

  //TODO: implement saving
  @override
  NoteDocumentController get controller => _controller;

  late final NoteDocumentController _controller = NoteDocumentController(
    noteDocument: UtilFunctions.noteDocumentFromList(
      operation.answer.toSerializerList(),
    ),
  )..initialize();

  late final OperationIndices index = widget.indices;

  @override
  double get extraWidth => 50.w;

  @override
  double get extraHeight => 50.h;

  @override
  void initState() {
    super.initState();
    controller;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _controller.addListener(controllerListener);
    });
  }

  void controllerListener() {
    syncAnswer();
  }

  void syncAnswer() {
    if (!mounted) return;
    final NoteDocument note = controller.noteDocument;
    Assessment assessment =
        ref.read(AssessmentStageNotifier.provider).assessment!;

    operation.answer.clear();
    operation.answer.addAll(note);

    final List<AssessmentOperation> myOperations = assessment.assessments;

    myOperations[index.operationIndex] = operation;

    assessment = assessment.copyWith(
      assessments: List.from(myOperations),
    );

    ref.read(AssessmentStageNotifier.provider.notifier).updateAssessment(
          assessment,
        );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
