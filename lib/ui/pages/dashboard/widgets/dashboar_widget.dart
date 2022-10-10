import 'package:flutter/material.dart';
import 'package:nobook/utilities/constants.dart';

class DashboardWidget extends StatelessWidget {
  const DashboardWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 200,
        width: 694,
        decoration: const BoxDecoration(
            color: kDashWidgetColor,
            borderRadius: BorderRadius.all(Radius.circular(8))),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Row(
            children: [Column(children: [])],
          ),
        ));
  }
}
