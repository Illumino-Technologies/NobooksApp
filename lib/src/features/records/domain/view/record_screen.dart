import 'package:flutter/material.dart';
import 'package:nobook/src/features/records/domain/view/record_graph.dart';

import 'package:nobook/src/features/dashboard/view/screen/dashboard_calender.dart';

class RecordScreen extends StatefulWidget {
  const RecordScreen({super.key});

  @override
  State<RecordScreen> createState() => _RecordScreenState();
}

class _RecordScreenState extends State<RecordScreen> {

  @override
  Widget build(BuildContext context) {
    return Expanded(child: Row(
        children: const [
          RecordGraph(),
           DashboardCalender(),
        ],
      ),
    );
  }
}
