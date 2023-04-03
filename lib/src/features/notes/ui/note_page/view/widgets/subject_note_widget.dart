part of '../note_page.dart';

class SubjectNoteWidget extends StatelessWidget {
  const SubjectNoteWidget({
    super.key,
    required this.currentNote,
  });

  final Note currentNote;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:  EdgeInsets.symmetric(
        horizontal: 20.w,
      ),
      width: 160.w,
  decoration:  BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(8.r),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            16.boxHeight,
            SubjectWidget(
              subject: currentNote.subject,
              boxSize: 40.r,
              fontSize: 25.sp,
            ),
            20.boxHeight,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    currentNote.topic,
                    style: TextStyles.headline3.withSize(
                      14.sp,
                    ),
                  ),
                  8.boxHeight,
                  Text(
                    // currentNote.noteBody.isEmpty,
                    'Hello there',
                    style: TextStyles.headline4.withSize(
                      12.sp,
                    ),
                  ),
                  40.boxHeight,
                  Text(
                    DateFormat.yMEd().add_jms().format(
                      currentNote.createdAt,
                    ),
                    style: TextStyles.headline4.withSize(
                      12.sp,
                    ).copyWith(
                      color: AppColors.neutral400,
                    ),
                    ),
                  
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
