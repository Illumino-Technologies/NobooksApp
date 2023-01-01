import 'package:flutter/material.dart';
import 'package:nobook/src/core/constants/assets.dart';
import 'package:nobook/src/model/assignments_model.dart';

class AssignmentCard extends StatefulWidget {
  const AssignmentCard({super.key, this.assignment });
  final Assignments? assignment;
  @override
  State<AssignmentCard> createState() => _AssignmentCardState();
}

class _AssignmentCardState extends State<AssignmentCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: Card(
        child: Column(
          children: [
            Row(
              children: [
                Image.asset(Assets.mt),
                Column(
                  children: [
                    Text("Economics"),
                    Text('Demand and Supply'),
                    Text('Expires 19th April, 8:00am'),
                    Text('Expires 19th April, 8:00am'),
                    Text('Submitted'),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
