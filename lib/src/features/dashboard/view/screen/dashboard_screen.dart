import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nobook/src/features/dashboard/dashboard_barrel.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: DashboardBoardPage(),
        ),
        SizedBox(
          width: 320.w,
          child: const DashboardCalender(),
        ),
      ],
    );
  }
}
