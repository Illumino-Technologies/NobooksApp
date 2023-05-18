part of '../assessment_preview_page.dart';

class _AssessmentNoteItem extends StatelessWidget {
  final String title;
  final NoteDocument note;

  const _AssessmentNoteItem({
    Key? key,
    required this.title,
    required this.note,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyles.headline6.copyWith(
            height: 1.33,
            color: AppColors.neutral600,
          ),
        ),
        DocumentEditorCanvas(
          canvasSize: Size(double.infinity, 50.h),
          readOnly: true,
          controller: NoteDocumentController(
            noteDocument: note,
          )..initialize(),
        ),
      ],
    );
  }
}
