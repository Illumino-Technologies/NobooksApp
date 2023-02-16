import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nobook/src/global/global_barrel.dart';

/// Row
///   Col
///   Col
///     Row
///       page [scrollable]
///       Calendar/Timetable [scrollable]
///

class NoBooksScaffold extends StatelessWidget {
  const NoBooksScaffold({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0),
      body: Row(
        children: [
          Container(
            width: 240.w,
            color: AppColors.subjectBlue,
            child: Column(
              children: [],
            ),
          ),
        ],
      ),
    );
  }
}
