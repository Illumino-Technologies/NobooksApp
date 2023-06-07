import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:nobook/src/features/features_barrel.dart';
import 'package:nobook/src/features/notes/model/note_list.dart';
import 'package:nobook/src/features/notes/subfeatures/calculator/view/calcPages.dart';
import 'package:nobook/src/global/domain/domain_barrel.dart';
import 'package:nobook/src/global/ui/ui_barrel.dart';
import 'package:nobook/src/utils/function/extensions/extensions.dart';

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
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.0.w,
                      vertical: 10.0.h,
                    ),
                    child: Column(
                      children: [
                        10.boxHeight,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
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
                            Row(
                              children: [
                                ValueListenableBuilder(
                                  valueListenable: isPersonalNotifier,
                                  builder: (context, value, child) {
                                    return ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        elevation: 0,
                                        backgroundColor:
                                            isPersonalNotifier.value
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
                                        backgroundColor:
                                            !isPersonalNotifier.value
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
                        ValueListenableBuilder(
                          valueListenable: isPersonalNotifier,
                          builder: (context, value, child) {
                            return isPersonalNotifier.value
                                ? ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: availableSubjects.length,
                                    itemBuilder: (context, index) {
                                      final Subject currentSubject =
                                          availableSubjects[index];
                                      return _AvailableSubjectWidget(
                                        currentSubject: currentSubject,
                                        subjectNotes: subjectNotes,
                                      );
                                    },
                                  )
                                : ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: availableSubjects.length,
                                    itemBuilder: (context, index) {
                                      final Subject currentSubject =
                                          availableSubjects[index];
                                      return Container(
                                        margin: EdgeInsets.symmetric(
                                          vertical: 20.h,
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            20.boxHeight,
                                            SizedBox(
                                              height: 260.h,
                                              child: ListView.builder(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemCount: subjectNotes[
                                                        currentSubject]!
                                                    .length,
                                                itemBuilder: (context, index) {
                                                  final Note currentNote =
                                                      subjectNotes[
                                                              currentSubject]![
                                                          index];
                                                  return NoteListItem(
                                                    currentNote: currentNote,
                                                  );
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.0.w,
                    vertical: 10.0.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Your Subjects',
                        style: TextStyles.headline1.withSize(18),
                      ),
                      SizedBox(
                        height: context.screenHeight * 0.85,
                        width: 320.w,
                        child: ListView.builder(
                          itemCount: FakeSubjects.subjects.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              leading: SubjectWidget(
                                subject: FakeSubjects.subjects[index],
                                boxSize: 40.r,
                                fontSize: 25.sp,
                              ),
                              title: Text(
                                FakeSubjects.subjects[index].name,
                                style: TextStyles.paragraph1.asSemibold,
                              ),
                              trailing: Icon(
                                Icons.keyboard_arrow_down,
                                size: 24.r,
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
