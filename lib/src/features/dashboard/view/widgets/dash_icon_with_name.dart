import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nobook/src/global/ui/ui_barrel.dart';
import 'package:nobook/src/utils/utils_barrel.dart';

class DashIconWithName extends StatefulWidget {
  const DashIconWithName({Key? key}) : super(key: key);

  @override
  State<DashIconWithName> createState() => _DashIconWithNameState();
}

class _DashIconWithNameState extends State<DashIconWithName> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SizedBox(
        width: 240,
        child: Column(
          children: [
            20.boxHeight,
            SvgPicture.asset(VectorAssets.logo),
            40.boxHeight,
            InkWell(
              onTap: () {
                setState(() {
                  selectedIndex = 0;
                });
              },
              child: Container(
                height: context.screenHeight * 0.04,
                width: context.screenHeight * 0.25,
                decoration: BoxDecoration(
                  color: selectedIndex == 0
                      ? AppColors.blue500
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  children: [
                    10.boxWidth,
                    SvgPicture.asset(
                      VectorAssets.dashboardIcon,
                      color: selectedIndex == 0
                          ? AppColors.white
                          : AppColors.neutral200,
                    ),
                    15.boxWidth,
                    Text(
                      'Dashboard',
                      style: TextStyles.paragraph3.copyWith(
                        color: selectedIndex == 0
                            ? AppColors.white
                            : AppColors.neutral200,
                      ),
                    )
                  ],
                ),
              ),
            ),
            20.boxHeight,
            InkWell(
              onTap: () {
                setState(() {
                  selectedIndex = 1;
                });
              },
              child: Container(
                height: context.screenHeight * 0.04,
                width: context.screenHeight * 0.25,
                decoration: BoxDecoration(
                  color: selectedIndex == 1
                      ? AppColors.blue500
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  children: [
                    10.boxWidth,
                    SvgPicture.asset(
                      VectorAssets.noteIcon,
                      color: selectedIndex == 1
                          ? AppColors.white
                          : AppColors.neutral200,
                    ),
                    15.boxWidth,
                    Text(
                      'Notes',
                      style: TextStyles.paragraph3.copyWith(
                        color: selectedIndex == 1
                            ? AppColors.white
                            : AppColors.neutral200,
                      ),
                    )
                  ],
                ),
              ),
            ),
            20.boxHeight,
            InkWell(
              onTap: () {
                setState(() {
                  selectedIndex = 2;
                });
              },
              child: Container(
                height: context.screenHeight * 0.04,
                width: context.screenHeight * 0.25,
                decoration: BoxDecoration(
                  color: selectedIndex == 2
                      ? AppColors.blue500
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  children: [
                    10.boxWidth,
                    SvgPicture.asset(
                      VectorAssets.assignmentIcon,
                      color: selectedIndex == 2
                          ? AppColors.white
                          : AppColors.neutral200,
                    ),
                    15.boxWidth,
                    Text(
                      'Assignments',
                      style: TextStyles.paragraph3.copyWith(
                        color: selectedIndex == 2
                            ? AppColors.white
                            : AppColors.neutral200,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            20.boxHeight,
            InkWell(
              onTap: () {
                setState(() {
                  selectedIndex = 3;
                });
              },
              child: Container(
                height: context.screenHeight * 0.04,
                width: context.screenHeight * 0.25,
                decoration: BoxDecoration(
                  color: selectedIndex == 3
                      ? AppColors.blue500
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  children: [
                    10.boxWidth,
                    SvgPicture.asset(
                      VectorAssets.examIcon,
                      color: selectedIndex == 3
                          ? AppColors.white
                          : AppColors.neutral200,
                    ),
                    15.boxWidth,
                    Text(
                      'Tests & Exams',
                      style: TextStyles.paragraph3.copyWith(
                        color: selectedIndex == 3
                            ? AppColors.white
                            : AppColors.neutral200,
                      ),
                    )
                  ],
                ),
              ),
            ),
            20.boxHeight,
            InkWell(
              onTap: () {
                setState(() {
                  selectedIndex = 4;
                });
              },
              child: Container(
                height: context.screenHeight * 0.04,
                width: context.screenHeight * 0.25,
                decoration: BoxDecoration(
                  color: selectedIndex == 4
                      ? AppColors.blue500
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  children: [
                    10.boxWidth,
                    SvgPicture.asset(
                      VectorAssets.recordIcon,
                      color: selectedIndex == 4
                          ? AppColors.white
                          : AppColors.neutral200,
                    ),
                    15.boxWidth,
                    Text(
                      'Records',
                      style: TextStyles.paragraph3.copyWith(
                        color: selectedIndex == 4
                            ? AppColors.white
                            : AppColors.neutral200,
                      ),
                    )
                  ],
                ),
              ),
            ),
            20.boxHeight,
            InkWell(
              onTap: () {
                setState(() {
                  selectedIndex = 5;
                });
              },
              child: Container(
                height: context.screenHeight * 0.04,
                width: context.screenHeight * 0.25,
                decoration: BoxDecoration(
                  color: selectedIndex == 5
                      ? AppColors.blue500
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  children: [
                    10.boxWidth,
                    SvgPicture.asset(
                      VectorAssets.arenaIcon,
                      color: selectedIndex == 5
                          ? AppColors.white
                          : AppColors.neutral200,
                    ),
                    15.boxWidth,
                    Text(
                      'Arena',
                      style: TextStyles.paragraph3.copyWith(
                        color: selectedIndex == 2
                            ? AppColors.white
                            : AppColors.neutral200,
                      ),
                    )
                  ],
                ),
              ),
            ),
            20.boxHeight,
            InkWell(
              onTap: () {
                setState(() {
                  selectedIndex = 6;
                });
              },
              child: Container(
                height: context.screenHeight * 0.04,
                width: context.screenHeight * 0.25,
                decoration: BoxDecoration(
                  color: selectedIndex == 6
                      ? AppColors.blue500
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  children: [
                    10.boxWidth,
                    SvgPicture.asset(
                      VectorAssets.forumIcon,
                      color: selectedIndex == 6
                          ? AppColors.white
                          : AppColors.neutral200,
                    ),
                    15.boxWidth,
                    Text(
                      'Forum',
                      style: TextStyles.paragraph3.copyWith(
                        color: selectedIndex == 6
                            ? AppColors.white
                            : AppColors.neutral200,
                      ),
                    )
                  ],
                ),
              ),
            ),
            20.boxHeight,
          ],
        ),
      ),
    );
  }
}
