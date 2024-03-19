part of '../note_page.dart';

class _AvailableSubjectWidget extends StatelessWidget {
  const _AvailableSubjectWidget({
    required this.currentSubject,
    required this.subjectNotes,
    // super.key,
  });

  final Subject currentSubject;
  final Map<Subject, List<Note>> subjectNotes;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 32.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            currentSubject.name,
            style: TextStyles.paragraph3.copyWith(
              color: AppColors.neutral500,
              fontWeight: FontWeight.w700,
            ),
          ),
          24.boxHeight,
          Row(
            children: [
              Container(
                height: 160.h,
                width: 160.w,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(8.r),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox.square(
                      dimension: 48.l,
                      child: Image.asset(
                        'assets/plus.png',
                      ),
                    ),
                    16.boxHeight,
                    Text(
                      'Add Note',
                      style: TextStyles.footer.copyWith(
                        fontSize: 12.sp,
                        color: const Color(0xFF5d5d5d),
                      ),
                    ),
                  ],
                ),
              ),
              16.boxWidth,
              Expanded(
                child: SizedBox(
                  height: 160.h,
                  child: ListView.separated(
                    separatorBuilder: (_, __) => 16.boxWidth,
                    scrollDirection: Axis.horizontal,
                    itemCount: subjectNotes[currentSubject]!.length,
                    itemBuilder: (context, index) {
                      final Note currentNote =
                          subjectNotes[currentSubject]![index];
                      return SubjectNoteWidget(currentNote: currentNote);
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
