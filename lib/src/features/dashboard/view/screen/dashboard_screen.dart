import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:nobook/src/app/themes/colors.dart';
import 'package:nobook/src/features/dashboard/view/widget/dash_icon.dart';
import 'package:nobook/src/features/dashboard/view/widget/dash_icon_with_name.dart';
import 'package:nobook/src/utils/constants/assets.dart';
import 'package:nobook/src/utils/extensions/size_extension.dart';
import 'package:nobook/src/utils/sizing/sizing.dart';
import 'package:nobook/src/utils/widgets/text/app_text.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Row(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
               
          ],
        ),
      ),
    );
  }
}
