import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nobook/src/core/constants/assets.dart';
import 'package:nobook/src/core/extensions/size_extension.dart';
import 'package:nobook/src/core/themes/color.dart';
import 'package:nobook/src/core/utils/sizing/sizing.dart';
import 'package:nobook/src/core/widgets/app_text.dart';
import 'package:nobook/src/features/dashboard/view/screen/assignment_subjects.dart';
import 'package:nobook/src/features/dashboard/view/screen/dashboard_navigation.dart';
import 'package:nobook/src/model/assignments_model.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title:AppText.semiBold('Hi, Boluwatife🧑'),
      //   backgroundColor: Colors.white,
      //   elevation: 0,
      // ),
      backgroundColor: AppColors.white,
      body: SafeArea(
          child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const DashBoardNavigation(),
          Expanded(
              child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  AppText.semiBold('Hi, Boluwatife🧑'),
                  // const XMargin(220),
                  SizedBox(
                    width: context.width * 0.5,
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.black,
                            size: 10,
                          ),
                          hintText: 'Search for anything',
                          hintStyle:
                              TextStyle(fontSize: 10, color: Colors.black)),
                    ),
                  ),
                  const XMargin(10),
                  SvgPicture.asset(Assets.libraryIcon),
                  const XMargin(10),
                  SvgPicture.asset(Assets.notificationIcon),
                  const XMargin(10),
                  Image.asset(
                    Assets.dp,
                    width: 70,
                    height: 30,
                  )
                ],
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 200,
                            width: context.width * 0.6,
                            child: ListView.builder(
                                itemCount: assignments.length,
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, int index) {
                                  return SizedBox(
                                    width: 200,
                                    child: Stack(
                                      children: [
                                        Card(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0, right: 8.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              // crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Row(
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment.start,
                                                      children: [
                                                        Text(assignments[index]
                                                            .subject!),
                                                        SizedBox(height: 20),
                                                        Text(assignments[index]
                                                            .topic!),
                                                        SizedBox(height: 10),
                                                        Text(
                                                            assignments[index].date!),
                                                        SizedBox(height: 5),
                                                        Text(assignments[index]
                                                            .expire!),
                                                        SizedBox(height: 20),
                                                        // Text(assignments[index].status!),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                            top: 10,
                                            right: 0,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.only(right: 8.0),
                                              child: Text(assignments[index].status!,
                                                  style: TextStyle(
                                                      color: assignments[index]
                                                                  .status
                                                                  ?.contains(
                                                                      'Submitted') ==
                                                              true
                                                          ? Colors.green
                                                          : Colors.red,
                                                      fontWeight: FontWeight.bold)),
                                            )),
                                        Positioned(
                                            top: 20,
                                            left: 10,
                                            child: Image.asset(
                                                assignments[index].image!)),
                                      ],
                                    ),
                                  );
                                }),
                          ),
                                   SizedBox(
                            height: 200,
                            width: context.width * 0.6,
                            child: ListView.builder(
                                itemCount: assignments.length,
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, int index) {
                                  return SizedBox(
                                    width: 200,
                                    child: Stack(
                                      children: [
                                        Card(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0, right: 8.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              // crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Row(
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment.start,
                                                      children: [
                                                        Text(assignments[index]
                                                            .subject!),
                                                        SizedBox(height: 20),
                                                        Text(assignments[index]
                                                            .topic!),
                                                        SizedBox(height: 10),
                                                        Text(
                                                            assignments[index].date!),
                                                        SizedBox(height: 5),
                                                        Text(assignments[index]
                                                            .expire!),
                                                        SizedBox(height: 20),
                                                        // Text(assignments[index].status!),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                            top: 10,
                                            right: 0,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.only(right: 8.0),
                                              child: Text(assignments[index].status!,
                                                  style: TextStyle(
                                                      color: assignments[index]
                                                                  .status
                                                                  ?.contains(
                                                                      'Submitted') ==
                                                              true
                                                          ? Colors.green
                                                          : Colors.red,
                                                      fontWeight: FontWeight.bold)),
                                            )),
                                        Positioned(
                                            top: 20,
                                            left: 10,
                                            child: Image.asset(
                                                assignments[index].image!)),
                                      ],
                                    ),
                                  );
                                }),
                          ),
                                    SizedBox(
                            height: 200,
                            width: context.width * 0.6,
                            child: ListView.builder(
                                itemCount: assignments.length,
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, int index) {
                                  return SizedBox(
                                    width: 200,
                                    child: Stack(
                                      children: [
                                        Card(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0, right: 8.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              // crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Row(
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment.start,
                                                      children: [
                                                        Text(assignments[index]
                                                            .subject!),
                                                        SizedBox(height: 20),
                                                        Text(assignments[index]
                                                            .topic!),
                                                        SizedBox(height: 10),
                                                        Text(
                                                            assignments[index].date!),
                                                        SizedBox(height: 5),
                                                        Text(assignments[index]
                                                            .expire!),
                                                        SizedBox(height: 20),
                                                        // Text(assignments[index].status!),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                            top: 10,
                                            right: 0,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.only(right: 8.0),
                                              child: Text(assignments[index].status!,
                                                  style: TextStyle(
                                                      color: assignments[index]
                                                                  .status
                                                                  ?.contains(
                                                                      'Submitted') ==
                                                              true
                                                          ? Colors.green
                                                          : Colors.red,
                                                      fontWeight: FontWeight.bold)),
                                            )),
                                        Positioned(
                                            top: 20,
                                            left: 10,
                                            child: Image.asset(
                                                assignments[index].image!)),
                                      ],
                                    ),
                                  );
                                }),
                          ), 
                        ],
                      ),
                    ),
                    const Expanded(child: DashboardCalender())
                  ],
                ),
              )
            ],
          )),
        ],
      )),
    );
  }
}
