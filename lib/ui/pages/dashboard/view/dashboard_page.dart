import 'package:flutter/material.dart';
import 'package:nobook/ui/pages/dashboard/widgets/dashboar_widget.dart';
import 'package:nobook/ui/pages/dashboard/widgets/reusable_card_widget.dart';
import 'package:nobook/utilities/constants.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: mBackgroundColor,
      ),
      child: SingleChildScrollView(
        child: Column(children: [
          const SizedBox(height: 30),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 200,
            child: const Center(child: DashboardWidget()),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 320,
            child: const Center(
              child: CardWidgets(),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 320,
            child: const Center(
              child: CardWidgets(),
            ),
          ),
        ]),
      ),
    );
  }
}
