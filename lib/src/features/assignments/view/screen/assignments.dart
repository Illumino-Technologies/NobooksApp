// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nobook/src/utils/utils_barrel.dart';
import 'package:nobook/src/global/ui/ui_barrel.dart';

import 'package:nobook/src/features/assignments/models/assignments_model.dart';
import 'package:nobook/src/features/assignments/view/widgets/reused_card_widget.dart';

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
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  const SizedBox(
                    height: 32,
                  ),
                  // ignore: sort_child_properties_last
                  // ignore: prefer_const_literals_to_create_immutables

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Your Assignments',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 29),
                    ),
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
                        itemCount: bioassignments.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ReusedAssCard(
                              image: bioassignments[index].image,
                              status: bioassignments[index].status,
                              topic: bioassignments[index].topic,
                              subject: bioassignments[index].subject,
                              date: bioassignments[index].date,
                              expire: bioassignments[index].expire,
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
                        itemCount: bkassignments.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ReusedAssCard(
                              image: bkassignments[index].image,
                              status: bkassignments[index].status,
                              topic: bkassignments[index].topic,
                              subject: bkassignments[index].subject,
                              date: bkassignments[index].date,
                              expire: bkassignments[index].expire,
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
                        itemCount: chassignments.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ReusedAssCard(
                              image: chassignments[index].image,
                              status: chassignments[index].status,
                              topic: chassignments[index].topic,
                              subject: chassignments[index].subject,
                              date: chassignments[index].date,
                              expire: chassignments[index].expire,
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
                        itemCount: cvassignments.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ReusedAssCard(
                              image: cvassignments[index].image,
                              status: cvassignments[index].status,
                              topic: cvassignments[index].topic,
                              subject: cvassignments[index].subject,
                              date: cvassignments[index].date,
                              expire: cvassignments[index].expire,
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
                        itemCount: fmassignments.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ReusedAssCard(
                              image: fmassignments[index].image,
                              status: fmassignments[index].status,
                              topic: fmassignments[index].topic,
                              subject: fmassignments[index].subject,
                              date: fmassignments[index].date,
                              expire: fmassignments[index].expire,
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
                        itemCount: engassignments.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ReusedAssCard(
                              image: engassignments[index].image,
                              status: engassignments[index].status,
                              topic: engassignments[index].topic,
                              subject: engassignments[index].subject,
                              date: engassignments[index].date,
                              expire: engassignments[index].expire,
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
                        itemCount: fmassignments.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ReusedAssCard(
                              image: fmassignments[index].image,
                              status: fmassignments[index].status,
                              topic: fmassignments[index].topic,
                              subject: fmassignments[index].subject,
                              date: fmassignments[index].date,
                              expire: fmassignments[index].expire,
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
                        itemCount: geoassignments.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ReusedAssCard(
                              image: geoassignments[index].image,
                              status: geoassignments[index].status,
                              topic: geoassignments[index].topic,
                              subject: geoassignments[index].subject,
                              date: geoassignments[index].date,
                              expire: geoassignments[index].expire,
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
                        itemCount: mathassignments.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ReusedAssCard(
                              image: mathassignments[index].image,
                              status: mathassignments[index].status,
                              topic: mathassignments[index].topic,
                              subject: mathassignments[index].subject,
                              date: mathassignments[index].date,
                              expire: mathassignments[index].expire,
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
                        itemCount: phyassignments.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ReusedAssCard(
                              image: phyassignments[index].image,
                              status: phyassignments[index].status,
                              topic: phyassignments[index].topic,
                              subject: phyassignments[index].subject,
                              date: phyassignments[index].date,
                              expire: phyassignments[index].expire,
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
