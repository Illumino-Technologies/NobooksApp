import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nobook/src/global/global_barrel.dart';
import 'package:nobook/src/utils/utils_barrel.dart';

part 'util/nav_item.dart';

part 'widgets/nav_drawer.dart';

part 'widgets/nav_item_widget.dart';

/// Row
///   Col
///   Col
///     Row
///       page [scrollable]
///       Calendar/Timetable [scrollable]
///

class NoBooksScaffold extends StatelessWidget {
  const NoBooksScaffold({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = context.screenWidth;
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0),
      body: Row(
        children: [
          _NavDrawer(onNavItemChanged: onSelected),
        ],
      ),
    );
  }

  void onSelected(NavItem item) {}
}
