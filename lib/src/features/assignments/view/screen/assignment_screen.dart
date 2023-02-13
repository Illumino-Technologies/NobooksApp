import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nobook/core.dart';
import 'package:nobook/src/features/assignments/view/screen/assignment_board.dart';
import 'package:nobook/src/features/dashboard/view/screen/dashboard_navigation.dart';
import 'package:nobook/src/utils/utils_barrel.dart';

import 'package:nobook/src/global/ui/ui_barrel.dart';

class AssignmentScreen extends StatefulWidget {
  const AssignmentScreen({Key? key}) : super(key: key);

  @override
  State<AssignmentScreen> createState() => _AssignmentScreenState();
}

class _AssignmentScreenState extends State<AssignmentScreen> {
  bool expand = true;

  toggleminimize() {
    expand = !expand;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Structure(
      animateDuration: const Duration(milliseconds: 100),
      // no need to add animation inside Dashboard navigation widget use this animateDuration instead
      animateReverseDuration: const Duration(milliseconds: 100),
      expandLeftBar: expand,
      appBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            'Hi, Boluwatife🧑',
            style: TextStyles.headline6,
          ),
          250.boxWidth,
          SizedBox(
            width: context.width * 0.25,
            height: context.height * 0.065,
            child: TextFormField(
              decoration: const InputDecoration(
                border: InputBorder.none,
                fillColor: Colors.red,
                filled: true,
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.black,
                  size: 18,
                ),
                hintText: 'Search for anything',
                hintStyle: TextStyle(fontSize: 10, color: Colors.black),
              ),
            ),
          ),
          //10.boxWidth,
          SvgPicture.asset(Assets.libraryIcon),
          //10.boxWidth,
          SvgPicture.asset(Assets.notificationIcon),
          // 10.boxWidth,
          Image.asset(
            Assets.dp,
            height: 30,
          )
        ],
      ),
      leftBar: DashBoardNavigation(expand: toggleminimize, isSelected: expand),
      //rightBar: const DashboardCalender(),
      body: const AssignmentBoard(),
    );
  }
}
