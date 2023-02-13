// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nobook/src/utils/utils_barrel.dart';
import 'package:nobook/src/global/ui/ui_barrel.dart';
import 'package:nobook/src/features/testandexams/model/test_and_exam_model.dart';
import 'package:nobook/src/features/testandexams/view/widgets/reused_card_widget.dart';

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
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  const SizedBox(
                    height: 32,
                  ),
                  // ignore: sort_child_properties_last
                  // ignore: prefer_const_literals_to_create_immutables
                  Row(
                    children: [
                      Text(
                        'Your Test and Exam',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 29),
                      ),
                      Spacer(),
                      MaterialButton(
                        onPressed: () {},
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.0)),
                        height: 38,
                        minWidth: 98,
                        color: AppColors.blue500,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Test',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                color: AppColors.backgroundGrey),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Exams',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Biology",
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          color: Colors.black),
                    ),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  SizedBox(
                    height: context.height * 0.25,
                    child: ListView.builder(
                        itemCount: biotestandexam.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ReusedTestsCard(
                              image: biotestandexam[index].image,
                              topic: biotestandexam[index].topic,
                              subject: biotestandexam[index].subject,
                              date: biotestandexam[index].date,
                            ),
                          );
                        }),
                  ),
                  SizedBox(
                    height: 48,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Book Keeping",
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          color: Colors.black),
                    ),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  SizedBox(
                    height: context.height * 0.25,
                    child: ListView.builder(
                        itemCount: bktestandexam.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ReusedTestsCard(
                              image: bktestandexam[index].image,
                              topic: bktestandexam[index].topic,
                              subject: bktestandexam[index].subject,
                              date: bktestandexam[index].date,
                            ),
                          );
                        }),
                  ),
                  SizedBox(
                    height: 48,
                  ),

                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Chemistry",
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          color: Colors.black),
                    ),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  SizedBox(
                    height: context.height * 0.25,
                    child: ListView.builder(
                        itemCount: chtestandexam.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ReusedTestsCard(
                              image: chtestandexam[index].image,
                              topic: chtestandexam[index].topic,
                              subject: chtestandexam[index].subject,
                              date: chtestandexam[index].date,
                            ),
                          );
                        }),
                  ),
                  SizedBox(
                    height: 48,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Civic Education",
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          color: Colors.black),
                    ),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  SizedBox(
                    height: context.height * 0.25,
                    child: ListView.builder(
                        itemCount: cvtestandexam.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ReusedTestsCard(
                              image: cvtestandexam[index].image,
                              topic: cvtestandexam[index].topic,
                              subject: cvtestandexam[index].subject,
                              date: cvtestandexam[index].date,
                            ),
                          );
                        }),
                  ),
                  SizedBox(
                    height: 48,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Economics",
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          color: Colors.black),
                    ),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  SizedBox(
                    height: context.height * 0.25,
                    child: ListView.builder(
                        itemCount: fmtestandexam.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ReusedTestsCard(
                              image: fmtestandexam[index].image,
                              topic: fmtestandexam[index].topic,
                              subject: fmtestandexam[index].subject,
                              date: fmtestandexam[index].date,
                            ),
                          );
                        }),
                  ),
                  SizedBox(
                    height: 48,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "English Language",
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          color: Colors.black),
                    ),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  SizedBox(
                    height: context.height * 0.25,
                    child: ListView.builder(
                        itemCount: engtestandexam.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ReusedTestsCard(
                              image: engtestandexam[index].image,
                              topic: engtestandexam[index].topic,
                              subject: engtestandexam[index].subject,
                              date: engtestandexam[index].date,
                            ),
                          );
                        }),
                  ),
                  SizedBox(
                    height: 48,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Further Maths",
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          color: Colors.black),
                    ),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  SizedBox(
                    height: context.height * 0.25,
                    child: ListView.builder(
                        itemCount: fmtestandexam.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ReusedTestsCard(
                              image: fmtestandexam[index].image,
                              topic: fmtestandexam[index].topic,
                              subject: fmtestandexam[index].subject,
                              date: fmtestandexam[index].date,
                            ),
                          );
                        }),
                  ),
                  SizedBox(
                    height: 48,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Geography",
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          color: Colors.black),
                    ),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  SizedBox(
                    height: context.height * 0.25,
                    child: ListView.builder(
                        itemCount: geotestandexam.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ReusedTestsCard(
                              image: geotestandexam[index].image,
                              topic: geotestandexam[index].topic,
                              subject: geotestandexam[index].subject,
                              date: geotestandexam[index].date,
                            ),
                          );
                        }),
                  ),
                  SizedBox(
                    height: 48,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Maths",
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          color: Colors.black),
                    ),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  SizedBox(
                    height: context.height * 0.25,
                    child: ListView.builder(
                        itemCount: mathtestandexam.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ReusedTestsCard(
                              image: mathtestandexam[index].image,
                              topic: mathtestandexam[index].topic,
                              subject: mathtestandexam[index].subject,
                              date: mathtestandexam[index].date,
                            ),
                          );
                        }),
                  ),
                  SizedBox(
                    height: 48,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Physics",
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          color: Colors.black),
                    ),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  SizedBox(
                    height: context.height * 0.25,
                    child: ListView.builder(
                        itemCount: phytestandexam.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ReusedTestsCard(
                              image: phytestandexam[index].image,
                              topic: phytestandexam[index].topic,
                              subject: phytestandexam[index].subject,
                              date: phytestandexam[index].date,
                            ),
                          );
                        }),
                  ),
                  SizedBox(
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
