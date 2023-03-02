import 'package:flutter/material.dart';
import 'package:nobook/src/features/dashboard/dashboard_barrel.dart';
import 'package:nobook/src/features/dashboard/view/screen/dashboard_calender.dart';
import 'package:nobook/src/features/testandexams/view/screen/testandexams.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  bool expand = true;

  toggleminimize() {
    expand = !expand;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: const [
          DashboardBoardPage(),
          DashboardCalender(),
        ],
      ),
    );
  }
}
