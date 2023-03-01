import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nobook/src/features/features_barrel.dart';
import 'package:nobook/src/global/ui/text/text_styles.dart';
import 'package:nobook/src/utils/function/extensions/extensions.dart';

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
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Your Notes'),
                      // Spacer(),
                      Row(
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              backgroundColor: Colors.blue,
                              // : Colors.white,
                            ),
                            onPressed: () {},
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
                            child: const Text('General',
                                style: TextStyle(fontSize: 16)),
                          ),
                        ],
                      ),
                    ],
                  ),
                  10.boxHeight,
                  const BiologyNoteCards(),
                  10.boxHeight,
                  const ChemistryNoteCards(),
                  10.boxHeight,
                  const BookKeepingNoteCards(),
                  10.boxHeight,
                  const CivicNoteCards()
                ],
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                const Text('Your Subjects'),
                SizedBox(
                  height: context.screenHeight * 0.85,
                  width: context.screenHeight * 0.35,
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: FakeAssignmentData.timeTable.length,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Container(
                          height: 32,
                          width: 32,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(4),
                            ),
                            image: DecorationImage(
                              image: AssetImage(FakeAssignmentData
                                  .timeTable[index].subjectLogo,),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        title: Text(FakeAssignmentData.timeTable[index].subject),
                        trailing: const Icon(Icons.keyboard_arrow_down),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
