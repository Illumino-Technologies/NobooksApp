part of '../assignment_screen.dart';

class _QuestionAnswerView extends ConsumerStatefulWidget {
  final Assignment assignment;
  final AssignmentOperation question;
  final AssignmentOperation? answer;

  final NoteDocumentController answerController;

  const _QuestionAnswerView({
    Key? key,
    required this.question,
    required this.answerController,
    required this.assignment,
    this.answer,
  }) : super(key: key);

  @override
  ConsumerState createState() => _QuestionAnswerViewState();
}

class _QuestionAnswerViewState extends ConsumerState<_QuestionAnswerView> {
  Assignment get assignment => widget.assignment;

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
            child: NPointerSingleChildScrollView(
              numberOfPointers: 2,
              padding: EdgeInsets.symmetric(horizontal: 32.0.w),
              child: Column(
                children: [
                  200.boxHeight,
                  Row(
                    children: [
                      Text(
                        assignment.subject.name,
                        style: TextStyles.headline4.copyWith(
                          color: AppColors.neutral500,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        'Deadline: ${UtilFunctions.formatDateAndTime(
                          assignment.submissionDate,
                        )}',
                        style: TextStyles.headline6.copyWith(
                          color: AppColors.neutral400,
                          fontSize: 14.sp,
                          height: 1.142,
                        ),
                      ),
                    ],
                  ),
                  _QuestionView(question: widget.question),
                  const Divider(
                    color: AppColors.grey100,
                    height: 1,
                    thickness: 1,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.grey100,
                        width: 1,
                      ),
                    ),
                    child: DocumentEditorCanvas(
                      key: const ValueKey('answer document editor canvas'),
                      controller: widget.answerController,
                      canvasSize: Size(
                        context.screenWidth - 2,
                        context.screenHeight * 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Transform.scale(
          scale: 0.8,
          child: FittedBox(
            child: ToolBarWidget(
              controller: controller,
            ),
          ),
        ),
      ],
    );
  }

  late NoteDocumentController controller = widget.answerController;

  @override
  void didUpdateWidget(covariant _QuestionAnswerView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.answerController == widget.answerController) return;
    controller.dispose();
    controller = widget.answerController;
  }
}
