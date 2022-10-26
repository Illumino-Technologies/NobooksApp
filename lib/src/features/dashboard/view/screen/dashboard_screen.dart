import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nobook/src/core/constants/assets.dart';
import 'package:nobook/src/core/extensions/size_extension.dart';
import 'package:nobook/src/core/themes/color.dart';
import 'package:nobook/src/core/utils/sizing/sizing.dart';
import 'package:nobook/src/core/widgets/app_text.dart';
import 'package:nobook/src/features/dashboard/view/screen/dashboard_calender.dart';
import 'package:nobook/src/features/dashboard/view/screen/dashboard_navigation.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title:AppText.semiBold('Hi, Boluwatife🧑'),
      //   backgroundColor: Colors.white,
      //   elevation: 0,
      // ),
      backgroundColor: AppColors.white,
      body: SafeArea(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          DashBoardNavigation(),
          Expanded(
              child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  AppText.semiBold('Hi, Boluwatife🧑'),
                  // const XMargin(220),
                  SizedBox(
                    width: context.width * 0.3,
                    child: TextFormField(
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.black,
                            size: 10,
                          ),
                          hintText: 'Search for anything',
                          hintStyle:
                              TextStyle(fontSize: 10, color: Colors.black)),
                    ),
                  ),
                  const XMargin(10),
                  SvgPicture.asset(Assets.libraryIcon),
                  const XMargin(10),
                  SvgPicture.asset(Assets.notificationIcon),
                  const XMargin(10),
                  Expanded(
                    child: Image.asset(
                      Assets.dp,
                      width: 70,
                      height: 30,
                    ),
                  )
                ],
              ),
              Text(
                'kush',
                textAlign: TextAlign.center,
              ),
            ],
          )),
          DashboardCalender()
        ],
      )),
    );
  }
}
