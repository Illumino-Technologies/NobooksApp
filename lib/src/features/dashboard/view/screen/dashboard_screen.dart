import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nobook/src/core/extensions/size_extension.dart';
import "package:nobook/core.dart";

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Structure(
        // expandLeftBar: false,
        bodyBackgroundColor: Colors.green ,
        rightBarBackgroundColor: Colors.brown,
        appBar: Row(
      children: const [Text("hello"), Icon(Icons.abc)],
    ));
  }
}
