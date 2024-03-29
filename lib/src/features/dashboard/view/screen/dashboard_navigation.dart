// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:nobook/src/utils/utils_barrel.dart';

import 'package:nobook/src/features/dashboard/view/widgets/dash_icon.dart';
import 'package:nobook/src/features/dashboard/view/widgets/dash_icon_with_name.dart';

class DashBoardNavigation extends StatefulWidget {
  dynamic expand;
  bool isSelected;
  DashBoardNavigation({Key? key, this.expand, this.isSelected = true})
      : super(key: key);

  @override
  State<DashBoardNavigation> createState() => _DashBoardNavigationState();
}

class _DashBoardNavigationState extends State<DashBoardNavigation> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        10.boxHeight,
        InkWell(
          onTap: () {
            widget.expand();
          },
          child: widget.isSelected
              ? Padding(
                  padding: const EdgeInsets.only(left: 0),
                  child: SvgPicture.asset(VectorAssets.arenaIcon),
                )
              : Padding(
                  padding: const EdgeInsets.only(right: 0),
                  child: SvgPicture.asset(VectorAssets.circledChevronRight),
                ),
        ),
        widget.isSelected ? const DashIconWithName() : const DashIcon(),
      ],
    );
  }
}

//
