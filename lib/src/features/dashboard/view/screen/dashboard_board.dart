// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nobook/src/core/extensions/size_extension.dart';
import 'package:nobook/src/core/themes/color.dart';
import 'package:nobook/src/core/utils/sizing/sizing.dart';
import 'package:nobook/src/features/dashboard/models/dashboard_note_model.dart';
//import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:nobook/src/features/dashboard/view/widgets/dashboar_widget.dart';

import 'package:nobook/src/features/dashboard/view/widgets/reusable_cardWidget.dart';

class DashboardBoard extends ConsumerStatefulWidget {
  const DashboardBoard({Key? key}) : super(key: key);
  @override
  DashboardScreenState createState() => DashboardScreenState();
}

class DashboardScreenState extends ConsumerState<DashboardBoard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: context.width * 0.50,
        decoration: const BoxDecoration(
          color: AppColors.mBackgroundColor,
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SingleChildScrollView(
              child: Column(children: [
                //YMargin(10),
                DashboardWidget(),
                YMargin(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Your Notes',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w700),
                    ),
                    Text(
                      'Veiw all >',
                      style: TextStyle(
                          color: Colors.blue[500],
                          fontSize: 12,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),

                SizedBox(
                  height: context.height * 0.25,
                  child: ListView.builder(
                      itemCount: dashBoard.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ReuseableCard(
                            firstImage: dashBoard[index].firstImage,
                            secondImage: dashBoard[index].secondImage,
                            title: dashBoard[index].title,
                            subTitle: dashBoard[index].subTitle,
                            bottomsubTitle: dashBoard[index].bottomsubTitle,
                            bottomtitle: dashBoard[index].bottomtitle,
                          ),
                        );
                      }),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Your Assignments',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w700),
                    ),
                    Text(
                      'Veiw all >',
                      style: TextStyle(
                          color: Colors.blue[500],
                          fontSize: 12,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),

                SizedBox(
                  height: context.height * 0.25,
                  child: ListView.builder(
                      itemCount: dashBoard.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ReuseableCard(
                            firstImage: dashBoard[index].firstImage,
                            secondImage: dashBoard[index].secondImage,
                            title: dashBoard[index].title,
                            subTitle: dashBoard[index].subTitle,
                            bottomsubTitle: dashBoard[index].bottomsubTitle,
                            bottomtitle: dashBoard[index].bottomtitle,
                          ),
                        );
                      }),
                ),
                SizedBox(height: 32.h),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Container(
                      width: 694,
                      height: 433,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          image: const DecorationImage(
                            image: AssetImage("assets/graph.png"),
                            fit: BoxFit.fill,
                          )),
                    ),
                  ),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
