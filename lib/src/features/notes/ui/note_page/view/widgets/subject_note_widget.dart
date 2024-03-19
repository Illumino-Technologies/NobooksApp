part of '../note_page.dart';

class SubjectNoteWidget extends StatelessWidget {
  const SubjectNoteWidget({
    super.key,
    required this.currentNote,
  });

  final Note currentNote;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.goNamed(
        AppRoute.noteDetailPage.name,
        extra: currentNote,
      ),
      child: Container(
        width: 160.w,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: Ui.allBorderRadius(8),
          boxShadow: const [
            BoxShadow(
              color: AppColors.black5,
              blurRadius: 5,
              offset: Offset(0, 2),
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SubjectWidget.small(
              subject: currentNote.subject,
            ),
            16.boxHeight,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  currentNote.subject.name,
                  style: TextStyles.paragraph1.copyWith(
                    fontSize: 14.spMax,
                    fontWeight: FontWeight.w600,
                    color: AppColors.neutral600,
                    height: 1.142,
                  ),
                ),
                4.boxHeight,
                Text(
                  // currentNote.noteBody.isEmpty,
                  currentNote.topic,
                  style: TextStyles.paragraph2.copyWith(
                    fontSize: 12.spMax,
                    color: AppColors.neutral300,
                    height: 1.333,
                  ),
                ),
                32.boxHeight,
                Text(
                  formatDate(),
                  style: TextStyles.headline4.copyWith(
                    height: 1.5,
                    fontSize: 8.spMax,
                    color: AppColors.neutral200,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String formatDate() {
    final DateTime date = currentNote.createdAt;
    final int day = date.day;
    final String month = DateFormat.MMMM().format(date);
    final int year = currentNote.createdAt.year;

    final String time = DateFormat.jmz()
        .format(date)
        .toLowerCase()
        .split(':')
        .map((e) => e.padLeft(2, '0'))
        .join(':');

    return '${day.toOrdinal()} $month, $year • $time';
  }
}
