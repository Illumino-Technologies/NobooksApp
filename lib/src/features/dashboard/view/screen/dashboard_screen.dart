import 'package:flutter/material.dart';
import 'package:nobook/src/features/dashboard/dashboard_barrel.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  bool expand = true;

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        DashboardBoardPage(),
        DashboardCalender(),
      ],
    );
  }
}
