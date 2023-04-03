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
    return Container(
      margin:  EdgeInsets.symmetric(
        vertical: 20.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                currentSubject.name,
                style: TextStyles.headline1.withSize(24.sp),
              ),
            ],
          ),
          20.boxHeight,
          Row(
            children: [
              Container(
                margin:  EdgeInsets.symmetric(
                  horizontal: 20.w,
                ),
                height: 260.h,
                width: 160.w,
                decoration:  BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.all(
                  Radius.circular(8.r),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/plus.png',
                    ),
                    8.boxHeight,
                    Text(
                      'Add Note',
                      style: TextStyles.headline3.withSize(14.sp),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SizedBox(
                  height: 260.h,
                  child: ListView.builder(
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
