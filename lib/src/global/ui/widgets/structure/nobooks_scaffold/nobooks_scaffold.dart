import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nobook/src/features/assessments/assessments_barrel.dart';
import 'package:nobook/src/global/global_barrel.dart';
import 'package:nobook/src/utils/utils_barrel.dart';

part 'util/nav_item.dart';

part 'widgets/nav_drawer.dart';

part 'widgets/nav_item_widget.dart';

part 'widgets/top_bar.dart';

part 'widgets/top_bar_field.dart';

/// Row
///   Col [done]()
///   Col
///     Row
///       page [scrollable]
///       Calendar/Timetable [scrollable]
///

class NoBooksScaffold extends StatelessWidget {
  final Widget body;
  final ValueChanged<String>? onSearchFieldChanged;
  final ValueChanged<NavItem> onNavItemChanged;

  const NoBooksScaffold({
    Key? key,
    this.onSearchFieldChanged,
    required this.onNavItemChanged,
    required this.body,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0),
      body: Row(
        children: [
          _NavDrawer(onNavItemChanged: onNavItemChanged),
          Expanded(
            child: Column(
              children: [
                TopBar(onSearchFieldChanged: onSearchFieldChanged),
                Expanded(child: body),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
