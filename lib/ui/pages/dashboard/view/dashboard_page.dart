import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nobook/ui/pages/dashboard/widgets/dashboar_widget.dart';
import 'package:nobook/ui/pages/dashboard/widgets/graphwidget.dart';
import 'package:nobook/ui/pages/dashboard/widgets/reusable_card_widget.dart';
import 'package:nobook/utilities/constants.dart';

class DashboardPage extends ConsumerStatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);
  @override
  DashboardPageState createState() => DashboardPageState();
}

class DashboardPageState extends ConsumerState<DashboardPage> {
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
              child: Column(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Your Results"),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(
                      child: GraphWidget(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
