import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nobook/src/app/navigation/app_routes.dart';
import 'package:nobook/src/app/themes/colors.dart';
import 'package:nobook/src/utils/constants/assets.dart';
import 'package:nobook/src/utils/sizing/sizing.dart';
import 'package:nobook/src/utils/widgets/text/app_text.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   return Scaffold(backgroundColor: AppColors.white,
    body: Column(children: [
      AppText.medium('NNKKK',),
      YMargin(40),
    SizedBox(height: 40,),
  Image.asset(Assets.logo),
    ElevatedButton(onPressed: (){context.goNamed(AppRoutes.note);}, child: AppText.bold('nnn'))
      
   ]),);
  }
}  