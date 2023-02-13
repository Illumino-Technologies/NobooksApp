import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nobook/src/core/constants/assets.dart';
import 'package:nobook/src/core/extensions/size_extension.dart';
import 'package:nobook/src/core/themes/color.dart';
import 'package:nobook/src/core/utils/sizing/sizing.dart';

class DashIcon extends StatefulWidget {
  const DashIcon({Key? key}) : super(key: key);

  @override
  State<DashIcon> createState() => _DashIconState();
}

class _DashIconState extends State<DashIcon> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const YMargin(20),
          Padding(

            padding: const EdgeInsets.only(left: 10),
            child: SvgPicture.asset(
              Assets.emptyLogo,
              width: 30,
            ),
          ),
          const YMargin(40),
          InkWell(
            onTap: () {
              setState(() {
                selectedIndex = 0;
              });
            },
            child: Container(
              height: context.height * 0.04,
              width: context.width * 0.04,
              decoration: BoxDecoration(
                  color:
                      selectedIndex == 0 ? AppColors.blue : Colors.transparent,
                  borderRadius: BorderRadius.circular(3)),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                const XMargin(10),
                SvgPicture.asset(Assets.dashboardIcon,
                    color: selectedIndex == 0
                        ? AppColors.white
                        : AppColors.grey100),
              ]),
            ),
          ),
          const YMargin(20),
          InkWell(
            onTap: () {
              setState(() {
                selectedIndex = 1;
              });
            },
            child: Container(
              height: context.height * 0.04,
              width: context.width * 0.04,
              decoration: BoxDecoration(
                  color:
                      selectedIndex == 1 ? AppColors.blue : Colors.transparent,
                  borderRadius: BorderRadius.circular(5)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const XMargin(10),
                  SvgPicture.asset(Assets.noteIcon,
                      color: selectedIndex == 1
                          ? AppColors.white
                          : AppColors.grey100),
                ],
              ),
            ),
          ),
          const YMargin(20),
          InkWell(
            onTap: () {
              setState(() {
                selectedIndex = 2;
              });
            },
            child: Container(
              height: context.height * 0.04,
              width: context.width * 0.04,
              decoration: BoxDecoration(
                  color:
                      selectedIndex == 2 ? AppColors.blue : Colors.transparent,
                  borderRadius: BorderRadius.circular(5)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const XMargin(10),
                  SvgPicture.asset(Assets.assignmentIcon,
                      color: selectedIndex == 2
                          ? AppColors.white
                          : AppColors.grey100),
                ],
              ),
            ),
          ),
          const YMargin(20),
          InkWell(
            onTap: () {
              setState(() {
                selectedIndex = 3;
              });
            },
            child: Container(
              height: context.height * 0.04,
              // width: context.width * 0.04,
              decoration: BoxDecoration(
                  color:
                      selectedIndex == 3 ? AppColors.blue : Colors.transparent,
                  borderRadius: BorderRadius.circular(5)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const XMargin(10),
                  SvgPicture.asset(Assets.examIcon,
                      color: selectedIndex == 3
                          ? AppColors.white
                          : AppColors.grey100),
                ],
              ),
            ),
          ),
          const YMargin(20),
          InkWell(
            onTap: () {
              setState(() {
                selectedIndex = 4;
              });
            },
            child: Container(
              height: context.height * 0.04,
              width: context.width * 0.38,
              decoration: BoxDecoration(
                  color:
                      selectedIndex == 4 ? AppColors.blue : Colors.transparent,
                  borderRadius: BorderRadius.circular(5)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const XMargin(10),
                  SvgPicture.asset(Assets.recordIcon,
                      color: selectedIndex == 4
                          ? AppColors.white
                          : AppColors.grey100),
                ],
              ),
            ),
          ),
          const YMargin(20),
          InkWell(
            onTap: () {
              setState(() {
                selectedIndex = 5;
              });
            },
            child: Container(
              height: context.height * 0.04,
              width: context.width * 0.04,
              decoration: BoxDecoration(
                  color:
                      selectedIndex == 5 ? AppColors.blue : Colors.transparent,
                  borderRadius: BorderRadius.circular(5)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const XMargin(10),
                  SvgPicture.asset(Assets.arenaIcon,
                      color: selectedIndex == 5
                          ? AppColors.white
                          : AppColors.grey100),
                ],
              ),
            ),
          ),
          const YMargin(20),
          InkWell(
            onTap: () {
              setState(() {
                selectedIndex = 6;
              });
            },
            child: Container(
              height: context.height * 0.04,
              width: context.width * 0.04,
              decoration: BoxDecoration(
                  color:
                      selectedIndex == 6 ? AppColors.blue : Colors.transparent,
                  borderRadius: BorderRadius.circular(5)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const XMargin(10),
                  SvgPicture.asset(Assets.forumIcon,
                      color: selectedIndex == 6
                          ? AppColors.white
                          : AppColors.grey100),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
