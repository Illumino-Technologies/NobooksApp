part of '../multiple_choice_assessment_stage_page.dart';

class _QuestionView extends StatefulWidget {
  final int index;
  final NoteDocument question;

  const _QuestionView({
    Key? key,
    required this.index,
    required this.question,
  }) : super(key: key);

  @override
  State<_QuestionView> createState() => _QuestionViewState();
}

class _QuestionViewState extends State<_QuestionView>
    with IntrinsicCanvasSizeMixin {
  @override
  NoteDocumentController get controller => NoteDocumentController(
        noteDocument: widget.question,
      )..initialize();

  @override
  double get extraWidth => context.screenWidth - 160.w;

  @override
  double get extraHeight => 40.h;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          (widget.index + 1).toString(),
          style: TextStyles.subHeading.copyWith(
            color: AppColors.neutral500,
            fontWeight: FontWeight.w600,
          ),
        ),
        16.boxWidth,
        Expanded(
          child: DocumentEditorCanvas(
            readOnly: true,
            canvasSize: canvasSize,
            controller: controller,
          ),
        ),
      ],
    );
  }
}
