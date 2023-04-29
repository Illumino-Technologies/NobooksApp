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
  late final NoteDocumentController controller = NoteDocumentController(
    noteDocument: widget.question.content,
  )..initialize(noteDocument: widget.question.content);

  @override
  Widget build(BuildContext context) {
    return DocumentEditorCanvas(
      readOnly: true,
      canvasSize: Size(double.infinity, 300.h),
      controller: controller,
    );
  }
}
