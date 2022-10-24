import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nobook/src/features/dashboard/view/widgets/calendar.dart';
//import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:nobook/src/features/dashboard/view/widgets/dashboar_widget.dart';

import 'package:nobook/src/features/dashboard/view/widgets/card_widget.dart';
import 'package:nobook/src/utils/constants/constants.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);
  @override
  DashboardScreenState createState() => DashboardScreenState();
}

class DashboardScreenState extends ConsumerState<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: mBackgroundColor,
                ),
                child: SingleChildScrollView(
                  child: Column(children: [
                    const SizedBox(height: 40),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 200,
                      child: const Center(child: DashboardWidget()),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 280,
                      child: const Center(
                        child: CardWidgets(),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 280,
                      child: const Center(
                        child: CardWidgets2(),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 480,
                      child: Center(
                        child: Container(
                          width: 694,
                          height: 433,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: mCardColor,
                          ),
                        ),
                      ),
                    ),
                  ]),
                ),
              ),
            ],
          ),
          // Column(
          //   // ignore: prefer_const_literals_to_create_immutables
          //   children: [
          //     const CalendarWidget(),
          //   ],
          // )
        ],
      ),
    );
  }
}
