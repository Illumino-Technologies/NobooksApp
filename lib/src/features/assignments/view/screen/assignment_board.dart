import 'package:flutter/material.dart';
import 'package:nobook/src/core/extensions/size_extension.dart';
import 'package:nobook/src/core/themes/color.dart';
import 'package:nobook/src/core/utils/sizing/sizing.dart';
import 'package:nobook/src/features/assignments/models/assignments_model.dart';
import 'package:nobook/src/features/assignments/models/subjects.dart';

class AssignmentBoard extends StatelessWidget {
  const AssignmentBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: (
        Row(
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Your Assignments',
                    style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold)),
                const YMargin(20),
                const Text('Biology',
                    style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold)),
                const YMargin(10),
                SizedBox(
                  height: context.height * 0.25,
                  width: context.width * 0.55,
                  child: ListView.builder(
                      itemCount: assignments.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        return AssignmentTile(
                          status: assignments[index].status,
                          subject: assignments[index].subject,
                          topic: assignments[index].topic,
                          expire: assignments[index].expire,
                          image: assignments[index].image,
                          date: assignments[index].date,
                        );
                      }),
                ),
              
            
                const YMargin(20),
                const Text('Biology',
                    style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold)),
                const YMargin(10),
                SizedBox(
                  height: context.height * 0.25,
                  width: context.width * 0.55,
                  child: ListView.builder(
                      itemCount: assignments.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        return AssignmentTile(
                          status: assignments[index].status,
                          subject: assignments[index].subject,
                          topic: assignments[index].topic,
                          expire: assignments[index].expire,
                          image: assignments[index].image,
                          date: assignments[index].date,
                        );
                      }),
                ),
                
                const YMargin(20),
                const Text('Biology',
                    style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold)),
                const YMargin(10),
                SizedBox(
                  height: context.height * 0.25,
                  width: context.width * 0.55,
                  child: ListView.builder(
                      itemCount: assignments.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        return AssignmentTile(
                          status: assignments[index].status,
                          subject: assignments[index].subject,
                          topic: assignments[index].topic,
                          expire: assignments[index].expire,
                          image: assignments[index].image,
                          date: assignments[index].date,
                        );
                      }),
                ),
                  const YMargin(20),
                const Text('Biology',
                    style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold)),
                const YMargin(10),
                SizedBox(
                  height: context.height * 0.25,
                  width: context.width * 0.55,
                  child: ListView.builder(
                      itemCount: assignments.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        return AssignmentTile(
                          status: assignments[index].status,
                          subject: assignments[index].subject,
                          topic: assignments[index].topic,
                          expire: assignments[index].expire,
                          image: assignments[index].image,
                          date: assignments[index].date,
                        );
                      }),
                ),
              ],
            ),
            Column(children: [
              const Text('Your Subjects'),
              SizedBox(
                height: context.height * 0.85,
                width: context.height * 0.35,
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),

                  itemCount: timeTable.length,
                  // scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Image.asset(timeTable[index].subjectLogo),
                      title: Text(timeTable[index].subject),
                      trailing: const Icon(Icons.keyboard_arrow_down),
                    );
                  },
                ),
              )
            ]),
          ],
        )),
    
    ));
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
          height: context.height * 0.25,
          decoration: BoxDecoration(
              color: AppColors.white, borderRadius: BorderRadius.circular(10)),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          margin: const EdgeInsets.symmetric(horizontal: 7),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const YMargin(15),
              Container(
                height: context.height * 0.06,
                width: context.height * 0.06,
                child: const Center(child: Text('FM')),
                decoration: BoxDecoration(
                    color: AppColors.grey,
                    borderRadius: BorderRadius.circular(7)),
              ),
              const YMargin(10),
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
                  borderRadius: BorderRadius.circular(5)),
              child: Text(status,
                  style: TextStyle(
                      fontSize: 10,
                      color: status.contains('Submitted') == true
                          ? Colors.green
                          : Colors.red,
                      fontWeight: FontWeight.w400)),
            )),
      ],
    );
  }
}
