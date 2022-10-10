import 'package:flutter/material.dart';
import 'package:nobook/ui/pages/dashboard/widgets/dashboar_widget.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 264,
          child: const Center(
            child: Expanded(
              child: DashboardWidget(),
            ),
          ),
        ),
      ]),
    );
  }
}
