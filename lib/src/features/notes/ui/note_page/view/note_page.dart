import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router_flow/go_router_flow.dart';
import 'package:intl/intl.dart';
import 'package:nobook/src/features/features_barrel.dart';
import 'package:nobook/src/features/notes/model/note_list.dart';
import 'package:nobook/src/features/notes/subfeatures/calculator/view/calcPages.dart';
import 'package:nobook/src/global/domain/domain_barrel.dart';
import 'package:nobook/src/global/ui/ui_barrel.dart';
import 'package:nobook/src/utils/function/extensions/extensions.dart';
import 'package:nobook/src/utils/utils_barrel.dart';

part 'widgets/available_subject_widget.dart';

part 'widgets/note_list_item.dart';

part 'widgets/subject_note_widget.dart';

class NoteScreen extends ConsumerStatefulWidget {
  const NoteScreen({Key? key, this.style}) : super(key: key);
  final TextStyles? style;

  @override
  NoteScreenState createState() => NoteScreenState();
}

class NoteScreenState extends ConsumerState<NoteScreen> {
  // bool isPersonal = true;
  final ValueNotifier<bool> isPersonalNotifier = ValueNotifier(true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) {
          final List<Note> notes = FakeNotes.allNotes;

          final List<Subject> availableSubjects =
              Set<Subject>.from(notes.map((e) => e.subject)).toList();

          final Map<Subject, List<Note>> subjectNotes = {};

          for (Subject subject in availableSubjects) {
            subjectNotes.addAll({
              subject: notes.where((element) {
                return element.subject == subject;
              }).toList(),
            });
          }

          return Row(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(vertical: 28.h),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 32.w),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: ((context) => const CalcPage()),
                                  ),
                                );
                              },
                              child: Text(
                                'Your Notes',
                                style: TextStyles.headline1.withSize(24),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              ValueListenableBuilder(
                                valueListenable: isPersonalNotifier,
                                builder: (context, value, child) {
                                  return ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      elevation: 0,
                                      backgroundColor: isPersonalNotifier.value
                                          ? AppColors.blue500
                                          : AppColors.white,
                                      // : Colors.white,
                                    ),
                                    onPressed: () {
                                      isPersonalNotifier.value = true;
                                    },
                                    child: Text(
                                      'Personal',
                                      style: TextStyles.headline3
                                          .withSize(16.sp)
                                          .copyWith(
                                            color: isPersonalNotifier.value
                                                ? AppColors.white
                                                : AppColors.black,
                                          ),
                                    ),
                                  );
                                },
                              ),
                              ValueListenableBuilder(
                                valueListenable: isPersonalNotifier,
                                builder: (context, value, child) {
                                  return ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      elevation: 0,
                                      backgroundColor: !isPersonalNotifier.value
                                          ? AppColors.blue500
                                          : Colors.white,
                                      // : Colors.white,
                                    ),
                                    onPressed: () {
                                      isPersonalNotifier.value = false;
                                    },
                                    child: Text(
                                      'General',
                                      style: TextStyles.headline3
                                          .withSize(16.sp)
                                          .copyWith(
                                            color: !isPersonalNotifier.value
                                                ? AppColors.white
                                                : AppColors.black,
                                          ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                      12.boxHeight,
                      ValueListenableBuilder(
                        valueListenable: isPersonalNotifier,
                        builder: (context, value, child) {
                          return isPersonalNotifier.value
                              ? ListView.separated(
                                  shrinkWrap: true,
                                  itemCount: availableSubjects.length,
                                  separatorBuilder: (context, index) =>
                                      48.boxHeight,
                                  itemBuilder: (context, index) {
                                    final Subject currentSubject =
                                        availableSubjects[index];
                                    return _AvailableSubjectWidget(
                                      currentSubject: currentSubject,
                                      subjectNotes: subjectNotes,
                                    );
                                  },
                                )
                              : ListView.separated(
                                  shrinkWrap: true,
                                  itemCount: availableSubjects.length,
                                  separatorBuilder: (context, index) =>
                                      48.boxHeight,
                                  itemBuilder: (context, index) {
                                    final Subject currentSubject =
                                        availableSubjects[index];
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          currentSubject.name,
                                          style: TextStyles.paragraph3.copyWith(
                                            color: AppColors.neutral500,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        24.boxHeight,
                                        SizedBox(
                                          height: 170.h,
                                          child: ListView.separated(
                                            scrollDirection: Axis.horizontal,
                                            itemCount:
                                                subjectNotes[currentSubject]!
                                                    .length,
                                            separatorBuilder:
                                                (context, index) => 16.boxWidth,
                                            itemBuilder: (context, index) {
                                              final Note currentNote =
                                                  subjectNotes[currentSubject]![
                                                      index];
                                              return NoteListItem(
                                                currentNote: currentNote,
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.only(
                    top: 32.h,
                    right: 32.w,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: Ui.allBorderRadius(8.l),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.w,
                    vertical: 24.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Your Subjects',
                        style: TextStyles.paragraph3.copyWith(
                          color: AppColors.neutral500,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      24.boxHeight,
                      SizedBox(
                        width: 320.w,
                        child: ListView.separated(
                          shrinkWrap: true,
                          itemCount: FakeSubjects.subjects.length,
                          separatorBuilder: (context, index) => 16.boxHeight,
                          itemBuilder: (context, index) {
                            return Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: Ui.allBorderRadius(4.l),
                                boxShadow: const [
                                  BoxShadow(
                                    color: AppColors.black5,
                                    blurRadius: 5,
                                    offset: Offset.zero,
                                  ),
                                ],
                              ),
                              child: ListTile(
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 8.w,
                                ),
                                leading: SubjectWidget(
                                  subject: FakeSubjects.subjects[index],
                                ),
                                title: Text(
                                  FakeSubjects.subjects[index].name,
                                  style: TextStyles.paragraph1.asSemibold
                                      .withColor(
                                    AppColors.neutral600,
                                  ),
                                ),
                                trailing: Icon(
                                  Icons.keyboard_arrow_down,
                                  size: 24.r,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
