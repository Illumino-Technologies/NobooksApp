import 'package:flutter/material.dart';
import 'package:nobook/src/features/assignments/assignment_barrel.dart';
import 'package:nobook/src/global/ui/ui_barrel.dart';
import 'package:nobook/src/utils/utils_barrel.dart';

class AssignmentBoard extends StatelessWidget {
  const AssignmentBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Your Assignments',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                20.boxHeight,
                const Text(
                  'Biology',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                10.boxHeight,
                SizedBox(
                  height: context.screenHeight * 0.25,
                  width: context.screenWidth * 0.55,
                  child: ListView.builder(
                    itemCount: FakeAssignmentData.assignments.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return AssignmentTile(
                        status: FakeAssignmentData.assignments[index].status,
                        subject: FakeAssignmentData.assignments[index].subject,
                        topic: FakeAssignmentData.assignments[index].topic,
                        expire: FakeAssignmentData.assignments[index].expire,
                        image: FakeAssignmentData.assignments[index].image,
                        date: FakeAssignmentData.assignments[index].date,
                      );
                    },
                  ),
                ),
                20.boxHeight,
                const Text(
                  'Biology',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                10.boxHeight,
                SizedBox(
                  height: context.screenHeight * 0.25,
                  width: context.screenWidth * 0.55,
                  child: ListView.builder(
                    itemCount: FakeAssignmentData.assignments.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return AssignmentTile(
                        status: FakeAssignmentData.assignments[index].status,
                        subject: FakeAssignmentData.assignments[index].subject,
                        topic: FakeAssignmentData.assignments[index].topic,
                        expire: FakeAssignmentData.assignments[index].expire,
                        image: FakeAssignmentData.assignments[index].image,
                        date: FakeAssignmentData.assignments[index].date,
                      );
                    },
                  ),
                ),
                20.boxHeight,
                const Text(
                  'Biology',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                10.boxHeight,
                SizedBox(
                  height: context.screenHeight * 0.25,
                  width: context.screenWidth * 0.55,
                  child: ListView.builder(
                    itemCount: FakeAssignmentData.assignments.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return AssignmentTile(
                        status: FakeAssignmentData.assignments[index].status,
                        subject: FakeAssignmentData.assignments[index].subject,
                        topic: FakeAssignmentData.assignments[index].topic,
                        expire: FakeAssignmentData.assignments[index].expire,
                        image: FakeAssignmentData.assignments[index].image,
                        date: FakeAssignmentData.assignments[index].date,
                      );
                    },
                  ),
                ),
                20.boxHeight,
                const Text(
                  'Biology',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                10.boxHeight,
                SizedBox(
                  height: context.screenHeight * 0.25,
                  width: context.screenWidth * 0.55,
                  child: ListView.builder(
                    itemCount: FakeAssignmentData.assignments.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return AssignmentTile(
                        status: FakeAssignmentData.assignments[index].status,
                        subject: FakeAssignmentData.assignments[index].subject,
                        topic: FakeAssignmentData.assignments[index].topic,
                        expire: FakeAssignmentData.assignments[index].expire,
                        image: FakeAssignmentData.assignments[index].image,
                        date: FakeAssignmentData.assignments[index].date,
                      );
                    },
                  ),
                ),
              ],
            ),
            Column(
              children: [
                const Text('Your Subjects'),
                SizedBox(
                  height: context.screenHeight * 0.85,
                  width: context.screenHeight * 0.35,
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),

                    itemCount: FakeAssignmentData.timeTable.length,
                    // scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Image.asset(
                          FakeAssignmentData.timeTable[index].subjectLogo,
                        ),
                        title:
                            Text(FakeAssignmentData.timeTable[index].subject),
                        trailing: const Icon(Icons.keyboard_arrow_down),
                      );
                    },
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class AssignmentTile extends StatelessWidget {
  final String image;
  final String subject;
  final String topic;
  final String date;
  final String expire;
  final String status;

  const AssignmentTile({
    Key? key,
    required this.image,
    required this.subject,
    required this.topic,
    required this.date,
    required this.expire,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: context.screenHeight * 0.25,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          margin: const EdgeInsets.symmetric(horizontal: 7),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              15.boxHeight,
              Container(
                height: context.screenHeight * 0.06,
                width: context.screenHeight * 0.06,
                decoration: BoxDecoration(
                  color: AppColors.backgroundGrey,
                  borderRadius: BorderRadius.circular(7),
                ),
                child: const Center(child: Text('FM')),
              ),
              10.boxHeight,
              Text(
                subject,
                style: const TextStyle(fontSize: 15, color: Color(0xFF383F4D)),
              ),
              //   SizedBox(height: 3),
              Text(
                topic,
                style: const TextStyle(fontSize: 11, color: Color(0xFF898C94)),
              ),
              const SizedBox(height: 10),
              Text(
                date,
                style: const TextStyle(fontSize: 11, color: Color(0xFF999EAA)),
              ),
              const SizedBox(height: 5),
              Text(
                expire,
                style: const TextStyle(fontSize: 11, color: Color(0xFF636876)),
              ),
            ],
          ),
        ),
        Positioned(
          top: 10,
          right: 35,
          child: Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: status.contains('Submitted') == true
                  ? Colors.green.withOpacity(0.2)
                  : Colors.red.withOpacity(0.2),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Text(
              status,
              style: TextStyle(
                fontSize: 10,
                color: status.contains('Submitted') == true
                    ? Colors.green
                    : Colors.red,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
