import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nobook/src/features/testandexams/test_and_exam_barrel.dart';
import 'package:nobook/src/global/ui/ui_barrel.dart';
import 'package:nobook/src/utils/utils_barrel.dart';

class TestandExamScreen extends ConsumerStatefulWidget {
  const TestandExamScreen({Key? key}) : super(key: key);

  @override
  TestandExamScreenState createState() => TestandExamScreenState();
}

class TestandExamScreenState extends ConsumerState<TestandExamScreen> {
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
                  Row(
                    children: [
                      const Text(
                        'Your Test and Exam',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 29,
                        ),
                      ),
                      const Spacer(),
                      MaterialButton(
                        onPressed: () {},
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        height: 38,
                        minWidth: 98,
                        color: AppColors.blue500,
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Test',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: AppColors.backgroundGrey,
                            ),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Exams',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
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
                      itemCount: FakeTestAndExamData.biotestandexam.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ReusedTestsCard(
                            image:
                                FakeTestAndExamData.biotestandexam[index].image,
                            topic:
                                FakeTestAndExamData.biotestandexam[index].topic,
                            subject: FakeTestAndExamData
                                .biotestandexam[index].subject,
                            date:
                                FakeTestAndExamData.biotestandexam[index].date,
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
                      itemCount: FakeTestAndExamData.bktestandexam.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ReusedTestsCard(
                            image:
                                FakeTestAndExamData.bktestandexam[index].image,
                            topic:
                                FakeTestAndExamData.bktestandexam[index].topic,
                            subject: FakeTestAndExamData
                                .bktestandexam[index].subject,
                            date: FakeTestAndExamData.bktestandexam[index].date,
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
                      itemCount: FakeTestAndExamData.chtestandexam.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ReusedTestsCard(
                            image:
                                FakeTestAndExamData.chtestandexam[index].image,
                            topic:
                                FakeTestAndExamData.chtestandexam[index].topic,
                            subject: FakeTestAndExamData
                                .chtestandexam[index].subject,
                            date: FakeTestAndExamData.chtestandexam[index].date,
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
                      itemCount: FakeTestAndExamData.cvtestandexam.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ReusedTestsCard(
                            image:
                                FakeTestAndExamData.cvtestandexam[index].image,
                            topic:
                                FakeTestAndExamData.cvtestandexam[index].topic,
                            subject: FakeTestAndExamData
                                .cvtestandexam[index].subject,
                            date: FakeTestAndExamData.cvtestandexam[index].date,
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
                      itemCount: FakeTestAndExamData.fmtestandexam.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ReusedTestsCard(
                            image:
                                FakeTestAndExamData.fmtestandexam[index].image,
                            topic:
                                FakeTestAndExamData.fmtestandexam[index].topic,
                            subject: FakeTestAndExamData
                                .fmtestandexam[index].subject,
                            date: FakeTestAndExamData.fmtestandexam[index].date,
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
                      itemCount: FakeTestAndExamData.engtestandexam.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ReusedTestsCard(
                            image:
                                FakeTestAndExamData.engtestandexam[index].image,
                            topic:
                                FakeTestAndExamData.engtestandexam[index].topic,
                            subject: FakeTestAndExamData
                                .engtestandexam[index].subject,
                            date:
                                FakeTestAndExamData.engtestandexam[index].date,
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
                      itemCount: FakeTestAndExamData.fmtestandexam.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ReusedTestsCard(
                            image:
                                FakeTestAndExamData.fmtestandexam[index].image,
                            topic:
                                FakeTestAndExamData.fmtestandexam[index].topic,
                            subject: FakeTestAndExamData
                                .fmtestandexam[index].subject,
                            date: FakeTestAndExamData.fmtestandexam[index].date,
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
                      itemCount: FakeTestAndExamData.geotestandexam.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ReusedTestsCard(
                            image:
                                FakeTestAndExamData.geotestandexam[index].image,
                            topic:
                                FakeTestAndExamData.geotestandexam[index].topic,
                            subject: FakeTestAndExamData
                                .geotestandexam[index].subject,
                            date:
                                FakeTestAndExamData.geotestandexam[index].date,
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
                      itemCount: FakeTestAndExamData.mathtestandexam.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ReusedTestsCard(
                            image: FakeTestAndExamData
                                .mathtestandexam[index].image,
                            topic: FakeTestAndExamData
                                .mathtestandexam[index].topic,
                            subject: FakeTestAndExamData
                                .mathtestandexam[index].subject,
                            date:
                                FakeTestAndExamData.mathtestandexam[index].date,
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
                      itemCount: FakeTestAndExamData.phytestandexam.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ReusedTestsCard(
                            image:
                                FakeTestAndExamData.phytestandexam[index].image,
                            topic:
                                FakeTestAndExamData.phytestandexam[index].topic,
                            subject: FakeTestAndExamData
                                .phytestandexam[index].subject,
                            date:
                                FakeTestAndExamData.phytestandexam[index].date,
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
