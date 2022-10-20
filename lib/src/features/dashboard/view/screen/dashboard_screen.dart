

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nobook/src/core/extensions/size_extension.dart';


class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
   return Scaffold(backgroundColor: Colors.white,
    body: Column(children: [
 
      Container(height: 200.h,
      width: 200.w,),
      Text('nnn',style: TextStyle(fontSize: 12.fontSize),)
   ]),);
  }
}
