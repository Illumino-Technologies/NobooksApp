part of '../assignment_screen.dart';

class _QuestionAnswerView extends StatefulWidget {
  final AssignmentOperation question;
  final AssignmentOperation? answer;

  const _QuestionAnswerView({
    Key? key,
    required this.question,
    this.answer,
  }) : super(key: key);

  @override
  State<_QuestionAnswerView> createState() => _QuestionAnswerViewState();
}

class _QuestionAnswerViewState extends State<_QuestionAnswerView> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        ScrollbarTheme(
          data: ScrollbarThemeData(
            trackBorderColor: MaterialStateProperty.all(Colors.transparent),
            trackColor: MaterialStateProperty.all(AppColors.grey100),
            thumbColor: MaterialStateProperty.all(AppColors.grey),
          ),
          child: Scrollbar(
            thickness: 16.w,
            radius: const Radius.circular(100),
            interactive: true,
            thumbVisibility: true,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  200.boxHeight,
                  _QuestionView(question: widget.question),
                  // DocumentEditorCanvas(
                  //   controller: controller,
                  //   canvasSize: canvasSize,
                  // ),
                ],
              ),
            ),
          ),
        ),
        FittedBox(
          child: ToolBarWidget(
            controller: controller,
          ),
        ),
      ],
    );
  }

  late final NoteDocumentController controller = NoteDocumentController(
    noteDocument: widget.answer?.content ?? [],
  )..initialize();

  @override
  void dispose() {
    super.dispose();
  }
}
