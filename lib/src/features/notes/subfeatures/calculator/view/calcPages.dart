import 'package:flutter/material.dart';
import 'package:nobook/src/features/notes/subfeatures/calculator/calculator_barrel.dart';

class CalcPage extends StatelessWidget {
  const CalcPage({super.key});

  static List<Tab> myTabs = <Tab>[
    const Tab(
      child: Text('Simple', style: TextStyle(color: Colors.white)),
    ),
    const Tab(
      child: Text('Scientific', style: TextStyle(color: Colors.white)),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(41, 29, 211, 1),
          elevation: 0,
          title: TabBar(
            labelColor: Colors.black,
            unselectedLabelColor: const Color.fromRGBO(12, 51, 255, 1),
            tabs: myTabs,
          ),
        ),
        body: const TabBarView(
          children: [
            SimpleCalculator(),
            ScientificCalculator(),
          ],
        ),
      ),
    );
  }
}
