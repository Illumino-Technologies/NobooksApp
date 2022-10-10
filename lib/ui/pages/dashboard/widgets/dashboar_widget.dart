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
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 29),
          child: Row(
            children: [
              // ignore: prefer_const_literals_to_create_immutables
              Column(children: [
                const Text('Exam is close!!!',
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 28,
                        color: Color.fromRGBO(255, 255, 255, 1))),
                const Text(
                  'The First term examination for the 2022/2023 Academic \nsession comes up on the 3rd of December, 2022. You need to study your notes to prepare well for the exam.',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: Color.fromRGBO(234, 235, 237, 1)),
                )
              ])
            ],
          ),
        ));
  }
}
