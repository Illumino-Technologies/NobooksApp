import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nobook/src/global/global_barrel.dart';
import 'package:nobook/src/utils/constants/assets/assets.dart';
import 'package:nobook/src/utils/function/extensions/extensions.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blue300,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SvgPicture.asset(
              VectorAssets.splashImage,
              width: 200.l,
            ),
          ],
        ),
      ),
    );
  }
}
