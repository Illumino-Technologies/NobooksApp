import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nobook/src/features/dashboard/view/widgets/dashboar_widget.dart';

import 'package:nobook/src/features/dashboard/view/widgets/reusable_card_widget.dart';
import 'package:nobook/src/utils/constants/constants.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);
  @override
  DashboardScreenState createState() => DashboardScreenState();
}

class DashboardScreenState extends ConsumerState<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: mBackgroundColor,
        ),
        child: SingleChildScrollView(
          child: Column(children: [
            SizedBox(height: 40.h),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 200.h,
              child: const Center(child: DashboardWidget()),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 280.h,
              child: const Center(
                child: CardWidgets(),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 280.h,
              child: const Center(
                child: CardWidgets2(),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 280.h,
              child: const Center(
                child: CardWidgets2(),
              ),
            ),
            // SizedBox(
            //   width: MediaQuery.of(context).size.width,
            //   height: 480.h,
            //   child: Center(
            //     child: Column(
            //       // ignore: prefer_const_literals_to_create_immutables
            //       children: [
            //         const Align(
            //           alignment: Alignment.centerLeft,
            //           child: Text("Your Results"),
            //         ),
            //         const Padding(
            //           padding: EdgeInsets.all(8.0),
            //           child: Center(
            //             child: GraphWidget(),
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
          ]),
        ),
      ),
    );
  }
}
