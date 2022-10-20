import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nobook/src/core/constants/assets.dart';
import 'package:nobook/src/core/extensions/size_extension.dart';
import 'package:nobook/src/core/themes/color.dart';
import 'package:nobook/src/core/utils/sizing/sizing.dart';
import 'package:nobook/src/core/widgets/app_text.dart';
import 'package:nobook/src/features/dashboard/view/widget/dash_icon.dart';
import 'package:nobook/src/features/dashboard/view/widget/dash_icon_with_name.dart';


class DashBoardPage extends StatefulWidget {
  const DashBoardPage({Key? key}) : super(key: key);

  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
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
                            padding: const EdgeInsets.only(left: 140),
                            child: SvgPicture.asset(Assets.drawerIcon),
                          )
                        : Padding(
                            padding: const EdgeInsets.only(right: 0),
                            child: SvgPicture.asset(Assets.drawerLeft),
                          )),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 100),
                  reverseDuration: const Duration(milliseconds: 100),
                  child:
                      isSelected ? const DashIconWithName() : const DashIcon(),
                ),
              ],
            ),
            const XMargin(30),
            Row(
              children: [
                AppText.semiBold('Hi, Boluwatife🧑'),
                const XMargin(220),
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
                SvgPicture.asset(Assets.libraryIcon),
                const XMargin(30),
                SvgPicture.asset(Assets.notificationIcon),
                const XMargin(30),
                Image.asset(
                  Assets.dp,
                  width: 70,
                  height: 30,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
