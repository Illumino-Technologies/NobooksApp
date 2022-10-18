import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nobook/src/app/themes/colors.dart';
import 'package:nobook/src/features/dashboard/view/widget/dash_icon.dart';
import 'package:nobook/src/features/dashboard/view/widget/dash_icon_with_name.dart';
import 'package:nobook/src/utils/constants/assets.dart';
import 'package:nobook/src/utils/sizing/sizing.dart';

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
        child:
          Column(
            children: [
                        //  AppText('')
//         Row(children: [
//           AppText('Hi, Boluwatife🧑'),
//          // SvgPicture.asset(Assets.logo)
//          SizedBox(width: context.width * 0.4,
//            child: TextFormField(decoration: InputDecoration(prefixIcon: Icon(Icons.search,color: Colors.black,),
//            hintText: 'Search for anything',hintStyle: TextStyle(fontSize: 20,color: Colors.black)),),
//          ),
// SvgPicture.asset(Assets.libraryIcon),
//  SvgPicture.asset(Assets.notificationIcon),
//   Image.asset(Assets.dp)
//         ],)
              YMargin(20),
              InkWell(onTap: (){
                setState(() {
                  isSelected = !isSelected;
                });
              },
                child: isSelected  ?SvgPicture.asset(Assets.drawerIcon):
                 SvgPicture.asset(Assets.drawerLeft)),
              AnimatedSwitcher(
                    duration: const Duration(milliseconds: 100),
                    reverseDuration: const Duration(milliseconds:100),
                    child:
                        isSelected ? const DashIconWithName() : const DashIcon(),
                  ),
            ],
          ),
        
      ),
    );
  }
}