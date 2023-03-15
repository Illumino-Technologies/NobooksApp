import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nobook/src/features/features_barrel.dart';
import 'package:nobook/src/features/notes/model/note_list.dart';
import 'package:nobook/src/features/notes/subfeatures/calculator/view/calcPages.dart';
import 'package:nobook/src/global/domain/fakes/subject/fake_subjects.dart';
import 'package:nobook/src/global/ui/ui_barrel.dart';
import 'package:nobook/src/utils/function/extensions/extensions.dart';
import 'package:intl/intl.dart';

import 'package:nobook/src/global/domain/domain_barrel.dart';

class NoteScreen extends ConsumerStatefulWidget {
  const NoteScreen({Key? key, this.style}) : super(key: key);
  final TextStyles? style;

  @override
  NoteScreenState createState() => NoteScreenState();
}

class NoteScreenState extends ConsumerState<NoteScreen> {
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
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 10.0,
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
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    backgroundColor: AppColors.blue500,
                                    // : Colors.white,
                                  ),
                                  onPressed: () {
                                    // context.router.pushNamed(
                                    //   AppRoute.notePage.name,
                                    //   extra: NoteModel(),
                                    // );
                                  },
                                  child: const Text(
                                    'Personal',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    backgroundColor: Colors.transparent,
                                    // : Colors.white,
                                  ),
                                  onPressed: () {},
                                  child: const Text(
                                    'General',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: availableSubjects.length,
                          itemBuilder: (context, index) {
                            final Subject currentSubject =
                                availableSubjects[index];
                            return Container(
                              margin: const EdgeInsets.symmetric(vertical: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        currentSubject.name,
                                        style:
                                            TextStyles.headline1.withSize(24),
                                      ),
                                    ],
                                  ),
                                  20.boxHeight,
                                  SizedBox(
                                    height: 160,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount:
                                          subjectNotes[currentSubject]!.length,
                                      itemBuilder: (context, index) {
                                        final Note currentNote = subjectNotes[
                                            currentSubject]![index];
                                        return Container(
                                          margin: const EdgeInsets.symmetric(
                                            horizontal: 20,
                                          ),
                                          width: 160,
                                          decoration: const BoxDecoration(
                                            color: AppColors.white,
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(8),
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
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
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        currentNote.topic,
                                                        style: TextStyles
                                                            .headline3
                                                            .withSize(14),
                                                      ),
                                                      8.boxHeight,
                                                      Text(
                                                        currentNote.noteBody,
                                                        style: TextStyles
                                                            .headline4
                                                            .withSize(12),
                                                      ),
                                                      40.boxHeight,
                                                      Text(
                                                        DateFormat.yMEd()
                                                            .add_jms()
                                                            .format(
                                                              currentNote
                                                                  .createdAt,
                                                            ),
                                                        style: const TextStyle(
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w400,
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
                                      },
                                    ),
                                  ),
                                ],
                              ),
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
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 10.0,
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
                        width: context.screenHeight * 0.35,
                        child: ListView.builder(
                          itemCount: FakeSubjects.subjects.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              leading: SubjectWidget(
                                subject: FakeSubjects.subjects[index],
                                boxSize: 40,
                                fontSize: 25,
                              ),
                              title: Text(FakeSubjects.subjects[index].name),
                              trailing: const Icon(Icons.keyboard_arrow_down),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
