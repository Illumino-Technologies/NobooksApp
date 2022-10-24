import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nobook/src/core/themes/color.dart';
//import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:nobook/src/features/dashboard/view/widgets/dashboar_widget.dart';

import 'package:nobook/src/features/dashboard/view/widgets/card_widget.dart';

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
        decoration: const BoxDecoration(
          color: AppColors.mBackgroundColor,
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
                    color: AppColors.mCardColor,
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
