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
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      width: 160.w,
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(8),
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
              boxSize: 40,
              fontSize: 25,
            ),
            20.boxHeight,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    currentNote.topic,
                    style: TextStyles.headline3.withSize(
                      14,
                    ),
                  ),
                  8.boxHeight,
                  Text(
                    // currentNote.noteBody.isEmpty,
                    'Hello there',
                    style: TextStyles.headline4.withSize(
                      12,
                    ),
                  ),
                  40.boxHeight,
                  Text(
                    DateFormat.yMEd().add_jms().format(
                      currentNote.createdAt,
                    ),
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
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
