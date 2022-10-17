import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/parser.dart';
import 'package:go_router/go_router.dart';
import 'package:nobook/src/app/navigation/app_routes.dart';
import 'package:nobook/src/app/themes/colors.dart';
import 'package:nobook/src/utils/constants/assets.dart';
import 'package:nobook/src/utils/extensions/size_extension.dart';
import 'package:nobook/src/utils/sizing/sizing.dart';
import 'package:nobook/src/utils/widgets/text/app_text.dart';
import 'package:table_calendar/table_calendar.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   return Scaffold(backgroundColor: AppColors.white,
    body: Column(children: [
       TableCalendar(focusedDay: DateTime.now(), firstDay: DateTime(1990), lastDay: DateTime(2050)),
    
   ]),);
  }
}  