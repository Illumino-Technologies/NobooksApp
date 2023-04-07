// part of '..note_page.dart';

// class SubjectsList extends StatelessWidget {
//   const SubjectsList({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//                         height: context.screenHeight * 0.85,
//                         width: 320.w,
//                         child: ListView.builder(
//                           itemCount: FakeSubjects.subjects.length,
//                           itemBuilder: (context, index) {
//                             return ListTile(
//                               leading: SubjectWidget(
//                                 subject: FakeSubjects.subjects[index],
//                                 boxSize: 40.r,
//                                 fontSize: 25.sp,
//                               ),
//                               title: Text(
//                                 FakeSubjects.subjects[index].name,
//                                 style: TextStyles.paragraph1.asSemibold,
//                               ),
//                               trailing: Icon(
//                                 Icons.keyboard_arrow_down,
//                                 size: 24.r,
//                               ),
//                             );
//                           },
//                         ),
//                       ),
//   }
// }
