import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nobook/src/core/constants/assets.dart';

import 'package:nobook/src/core/utils/sizing/sizing.dart';

import 'package:nobook/src/features/dashboard/view/widget/dash_icon.dart';
import 'package:nobook/src/features/dashboard/view/widget/dash_icon_with_name.dart';

class DashBoardNavigation extends StatefulWidget {
  const DashBoardNavigation({Key? key}) : super(key: key);

  @override
  State<DashBoardNavigation> createState() => _DashBoardNavigationState();
}

class _DashBoardNavigationState extends State<DashBoardNavigation> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const YMargin(10),
        InkWell(
            onTap: () {
              setState(() {
                isSelected = !isSelected;
              });
            },
            child: isSelected
                ? Padding(
                    padding: const EdgeInsets.only(left: 0),
                    child: SvgPicture.asset(Assets.drawerIcon),
                  )
                : Padding(
                    padding: const EdgeInsets.only(right: 0),
                    child: SvgPicture.asset(Assets.drawerLeft),
                  )),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 100),
          reverseDuration: const Duration(milliseconds: 100),
          child: isSelected ? const DashIconWithName() : const DashIcon(),
        ),
        // Row(
        //     children: [
        //       AppText.semiBold('Hi, Boluwatife🧑'),
        //       const XMargin(220),
        //       SizedBox(
        //         width: context.width * 0.3,
        //         child: TextFormField(
        //           decoration: const InputDecoration(
        //               border: InputBorder.none,
        //               prefixIcon: Icon(
        //                 Icons.search,
        //                 color: Colors.black,
        //                  size: 10,
        //               ),
        //               hintText: 'Search for anything',
        //               hintStyle: TextStyle(fontSize: 10, color: Colors.black)),
        //         ),
        //       ),
        //       SvgPicture.asset(Assets.libraryIcon),
        //       const XMargin(30),
        //       SvgPicture.asset(Assets.notificationIcon),
        //       const XMargin(30),
        //       Image.asset(
        //         Assets.dp,
        //         width: 70,
        //         height: 30,
        //       )
        //     ],
        //  ),
      ],
    );
  }
}

//  