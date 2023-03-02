import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nobook/src/features/features_barrel.dart';
import 'package:nobook/src/features/notes/model/note_list.dart';
import 'package:nobook/src/global/ui/ui_barrel.dart';
import 'package:nobook/src/utils/function/extensions/extensions.dart';

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

          return ListView.builder(
            shrinkWrap: true,
            itemCount: availableSubjects.length,
            itemBuilder: (context, index) {
              final Subject currentSubject = availableSubjects[index];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        currentSubject.name,
                        style: TextStyles.headline1.withSize(24),
                      ),
                      SubjectWidget(
                        subject: currentSubject,
                        boxSize: 80,
                        fontSize: 50,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 200,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: subjectNotes[currentSubject]!.length,
                      itemBuilder: (context, index) {
                        final Note currentNote =
                            subjectNotes[currentSubject]![index];
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 30),
                          child: Text(currentNote.topic),
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

      // Row(
      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //   children: [
      //     Column(
      //       children: [
      //         10.boxHeight,
      //         Padding(
      //           padding: const EdgeInsets.symmetric(horizontal: 10.0),
      //           child: Row(
      //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //             children: [
      //               const Text(
      //                 'Your Notes',
      //                 style: TextStyle(
      //                   fontSize: 24,
      //                   color: Colors.black,
      //                   fontWeight: FontWeight.bold,
      //                 ),
      //               ),
      //               // Spacer(),
      //
      //
      //               Row(
      //                 children: [
      //                   ElevatedButton(
      //                     style: ElevatedButton.styleFrom(
      //                       elevation: 0,
      //                       backgroundColor: Colors.blue,
      //                       // : Colors.white,
      //                     ),
      //                     onPressed: () {
      //                       context.goNamed(
      //                         AppRoute.notePage.name,
      //                         extra: NoteModel(),
      //                       );
      //                     },
      //                     child: const Text(
      //                       'Personal',
      //                       style: TextStyle(fontSize: 16),
      //                     ),
      //                   ),
      //                   const SizedBox(width: 10),
      //                   ElevatedButton(
      //                     style: ElevatedButton.styleFrom(
      //                       elevation: 0,
      //                       backgroundColor: Colors.transparent,
      //                       // : Colors.white,
      //                     ),
      //                     onPressed: () {},
      //                     child: const Text(
      //                       'General',
      //                       style: TextStyle(
      //                         fontSize: 16,
      //                         color: Colors.black54,
      //                       ),
      //                     ),
      //                   ),
      //                 ],
      //               ),
      //             ],
      //           ),
      //         ),
      //         30.boxHeight,
      //         const BiologyNoteCards(),
      //         30.boxHeight,
      //         const ChemistryNoteCards(),
      //         30.boxHeight,
      //         const BookKeepingNoteCards(),
      //         30.boxHeight,
      //         const CivicNoteCards()
      //       ],
      //     ),
      //
      //     // SingleChildScrollView(
      //     //   child: Column(
      //     //     crossAxisAlignment: CrossAxisAlignment.start,
      //     //     children: [
      //     //       const Text(
      //     //         'Your Subjects',
      //     //         style: TextStyle(
      //     //           fontSize: 18,
      //     //           color: Colors.black54,
      //     //           // fontWeight: FontWeight.bold,
      //     //         ),
      //     //       ),
      //     //       SizedBox(
      //     //         height: context.screenHeight * 0.85,
      //     //         width: context.screenHeight * 0.35,
      //     //         child: ListView.builder(
      //     //           physics: const NeverScrollableScrollPhysics(),
      //     //           itemCount: FakeAssignmentData.timeTable.length,
      //     //           scrollDirection: Axis.vertical,
      //     //           shrinkWrap: true,
      //     //           itemBuilder: (context, index) {
      //     //             return ListTile(
      //     //               leading: Container(
      //     //                 height: 32,
      //     //                 width: 32,
      //     //                 decoration: BoxDecoration(
      //     //                   borderRadius: const BorderRadius.all(
      //     //                     Radius.circular(4),
      //     //                   ),
      //     //                   image: DecorationImage(
      //     //                     image: AssetImage(
      //     //                       FakeAssignmentData.timeTable[index].subjectLogo,
      //     //                     ),
      //     //                     fit: BoxFit.fill,
      //     //                   ),
      //     //                 ),
      //     //               ),
      //     //               title:
      //     //                   Text(FakeAssignmentData.timeTable[index].subject),
      //     //               trailing: const Icon(Icons.keyboard_arrow_down),
      //     //             );
      //     //           },
      //     //         ),
      //     //       )
      //     //     ],
      //     //   ),
      //     // ),
      //   ],
      // ),
    );
  }
}
