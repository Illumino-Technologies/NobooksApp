part of '../assignment_screen.dart';

class _QuestionView extends StatefulWidget {
  final AssignmentOperation question;

  const _QuestionView({
    Key? key,
    required this.question,
  }) : super(key: key);

  @override
  State<_QuestionView> createState() => _QuestionViewState();
}

class _QuestionViewState extends State<_QuestionView> {
  late NoteDocumentController controller = NoteDocumentController(
    noteDocument: widget.question.content,
  )..initialize(noteDocument: widget.question.content);

  @override
  void didUpdateWidget(covariant _QuestionView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.question.content == widget.question.content) return;
    controller = NoteDocumentController(
      noteDocument: widget.question.content,
    )..initialize(noteDocument: widget.question.content);
  }

  Size canvasSize = Size(double.infinity, 300.h);

  void computeDrawingSize() {
    if (controller.drawingController.drawings.isEmpty) return;

    Size size =
        controller.drawingController.drawings.computeCanvasSizeByOffets();

    if (size == Size.zero) return;
    size = Size(
      size.width + 50.w,
      size.height + 50.h,
    );

    canvasSize = size;
  }

  @override
  void initState() {
    super.initState();
    computeDrawingSize();
  }

  @override
  Widget build(BuildContext context) {
    return DocumentEditorCanvas(
      readOnly: true,
      canvasSize: canvasSize,
      controller: controller,
    );
  }
}
