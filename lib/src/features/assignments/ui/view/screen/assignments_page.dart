
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nobook/src/utils/utils_barrel.dart';
import 'package:nobook/src/global/ui/ui_barrel.dart';

import 'package:nobook/src/features/assignments/assignment_barrel.dart';

class AssignmentPage extends ConsumerStatefulWidget {
  const AssignmentPage({Key? key}) : super(key: key);
  @override
  AssignmentPageState createState() => AssignmentPageState();
}

class AssignmentPageState extends ConsumerState<AssignmentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 758,
          height: MediaQuery.of(context).size.height,
          color: AppColors.backgroundGrey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 29),
              child: Column(
                children: [
                  const SizedBox(
                    height: 32,
                  ),

                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Your Assignments',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: 29,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Biology",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  SizedBox(
                    height: context.screenHeight * 0.25,
                    child: ListView.builder(
                      itemCount: FakeAssignmentData.bioassignments.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ReusedAssCard(
                            image:
                                FakeAssignmentData.bioassignments[index].image,
                            status:
                                FakeAssignmentData.bioassignments[index].status,
                            topic:
                                FakeAssignmentData.bioassignments[index].topic,
                            subject: FakeAssignmentData
                                .bioassignments[index].subject,
                            date: FakeAssignmentData.bioassignments[index].date,
                            expire:
                                FakeAssignmentData.bioassignments[index].expire,
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 48,
                  ),
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Book Keeping",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  SizedBox(
                    height: context.screenHeight * 0.25,
                    child: ListView.builder(
                      itemCount: FakeAssignmentData.bkassignments.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ReusedAssCard(
                            image:
                                FakeAssignmentData.bkassignments[index].image,
                            status:
                                FakeAssignmentData.bkassignments[index].status,
                            topic:
                                FakeAssignmentData.bkassignments[index].topic,
                            subject:
                                FakeAssignmentData.bkassignments[index].subject,
                            date: FakeAssignmentData.bkassignments[index].date,
                            expire:
                                FakeAssignmentData.bkassignments[index].expire,
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 48,
                  ),

                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Chemistry",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  SizedBox(
                    height: context.screenHeight * 0.25,
                    child: ListView.builder(
                      itemCount: FakeAssignmentData.chassignments.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ReusedAssCard(
                            image:
                                FakeAssignmentData.chassignments[index].image,
                            status:
                                FakeAssignmentData.chassignments[index].status,
                            topic:
                                FakeAssignmentData.chassignments[index].topic,
                            subject:
                                FakeAssignmentData.chassignments[index].subject,
                            date: FakeAssignmentData.chassignments[index].date,
                            expire:
                                FakeAssignmentData.chassignments[index].expire,
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 48,
                  ),
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Civic Education",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  SizedBox(
                    height: context.screenHeight * 0.25,
                    child: ListView.builder(
                      itemCount: FakeAssignmentData.cvassignments.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ReusedAssCard(
                            image:
                                FakeAssignmentData.cvassignments[index].image,
                            status:
                                FakeAssignmentData.cvassignments[index].status,
                            topic:
                                FakeAssignmentData.cvassignments[index].topic,
                            subject:
                                FakeAssignmentData.cvassignments[index].subject,
                            date: FakeAssignmentData.cvassignments[index].date,
                            expire:
                                FakeAssignmentData.cvassignments[index].expire,
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 48,
                  ),
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Economics",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  SizedBox(
                    height: context.screenHeight * 0.25,
                    child: ListView.builder(
                      itemCount: FakeAssignmentData.fmassignments.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ReusedAssCard(
                            image:
                                FakeAssignmentData.fmassignments[index].image,
                            status:
                                FakeAssignmentData.fmassignments[index].status,
                            topic:
                                FakeAssignmentData.fmassignments[index].topic,
                            subject:
                                FakeAssignmentData.fmassignments[index].subject,
                            date: FakeAssignmentData.fmassignments[index].date,
                            expire:
                                FakeAssignmentData.fmassignments[index].expire,
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 48,
                  ),
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "English Language",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  SizedBox(
                    height: context.screenHeight * 0.25,
                    child: ListView.builder(
                      itemCount: FakeAssignmentData.engassignments.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ReusedAssCard(
                            image:
                                FakeAssignmentData.engassignments[index].image,
                            status:
                                FakeAssignmentData.engassignments[index].status,
                            topic:
                                FakeAssignmentData.engassignments[index].topic,
                            subject: FakeAssignmentData
                                .engassignments[index].subject,
                            date: FakeAssignmentData.engassignments[index].date,
                            expire:
                                FakeAssignmentData.engassignments[index].expire,
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 48,
                  ),
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Further Maths",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  SizedBox(
                    height: context.screenHeight * 0.25,
                    child: ListView.builder(
                      itemCount: FakeAssignmentData.fmassignments.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ReusedAssCard(
                            image:
                                FakeAssignmentData.fmassignments[index].image,
                            status:
                                FakeAssignmentData.fmassignments[index].status,
                            topic:
                                FakeAssignmentData.fmassignments[index].topic,
                            subject:
                                FakeAssignmentData.fmassignments[index].subject,
                            date: FakeAssignmentData.fmassignments[index].date,
                            expire:
                                FakeAssignmentData.fmassignments[index].expire,
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 48,
                  ),
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Geography",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  SizedBox(
                    height: context.screenHeight * 0.25,
                    child: ListView.builder(
                      itemCount: FakeAssignmentData.geoassignments.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ReusedAssCard(
                            image:
                                FakeAssignmentData.geoassignments[index].image,
                            status:
                                FakeAssignmentData.geoassignments[index].status,
                            topic:
                                FakeAssignmentData.geoassignments[index].topic,
                            subject: FakeAssignmentData
                                .geoassignments[index].subject,
                            date: FakeAssignmentData.geoassignments[index].date,
                            expire:
                                FakeAssignmentData.geoassignments[index].expire,
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 48,
                  ),
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Maths",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  SizedBox(
                    height: context.screenHeight * 0.25,
                    child: ListView.builder(
                      itemCount: FakeAssignmentData.mathassignments.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ReusedAssCard(
                            image:
                                FakeAssignmentData.mathassignments[index].image,
                            status: FakeAssignmentData
                                .mathassignments[index].status,
                            topic:
                                FakeAssignmentData.mathassignments[index].topic,
                            subject: FakeAssignmentData
                                .mathassignments[index].subject,
                            date:
                                FakeAssignmentData.mathassignments[index].date,
                            expire: FakeAssignmentData
                                .mathassignments[index].expire,
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 48,
                  ),
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Physics",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  SizedBox(
                    height: context.screenHeight * 0.25,
                    child: ListView.builder(
                      itemCount: FakeAssignmentData.phyassignments.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ReusedAssCard(
                            image:
                                FakeAssignmentData.phyassignments[index].image,
                            status:
                                FakeAssignmentData.phyassignments[index].status,
                            topic:
                                FakeAssignmentData.phyassignments[index].topic,
                            subject: FakeAssignmentData
                                .phyassignments[index].subject,
                            date: FakeAssignmentData.phyassignments[index].date,
                            expire:
                                FakeAssignmentData.phyassignments[index].expire,
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 48,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}