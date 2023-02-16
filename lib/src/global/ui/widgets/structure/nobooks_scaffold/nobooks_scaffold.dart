import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nobook/src/global/global_barrel.dart';
import 'package:nobook/src/utils/utils_barrel.dart';

part 'util/nav_item.dart';

part 'widgets/nav_drawer.dart';

part 'widgets/nav_item_widget.dart';

/// Row
///   Col [done]()
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
          Expanded(
            child: Column(
              children: [
                TopBar(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void onSelected(NavItem item) {}
}

class TopBar extends ConsumerStatefulWidget {
  const TopBar({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _TopBarState();
}

class _TopBarState extends ConsumerState<TopBar> {
  @override
  Widget build(BuildContext context) {
    final User? user = ref.watch(UserNotifier.provider);
    return Container(
      color: AppColors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hi ${user?.firstname ?? ''}',
              ),
              Image.asset(Assets.hiImage)
            ],
          ),
          const Spacer(),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 24.h),
            child: Row(
              children: [
                TopBarField(
                  onChanged: onFieldChanged,
                ),
                32.boxWidth,
                IconButton(
                  onPressed: onBooksPressed,
                  icon: SvgPicture.asset(VectorAssets.libraryIcon),
                ),
                IconButton(
                  onPressed: onNotificationPressed,
                  icon: SvgPicture.asset(VectorAssets.notification),
                ),
                InkWell(
                  child: Image.asset(
                    user?.profilePhoto ?? '',
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void onBooksPressed() {}

  void onNotificationPressed() {}

  void onProfileImagePressed() {}

  void onFieldChanged(String value) {}
}

class TopBarField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final ValueChanged<String?>? onSubmitted;

  const TopBarField({
    Key? key,
    required this.onChanged,
    this.onSubmitted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: 322.w,
        maxHeight: 48.h,
      ),
      child: TextField(
        decoration: InputDecoration(
          filled: true,
          prefixIcon: const Icon(Icons.search),
          hintText: 'Search for anything',
          hintStyle: TextStyles.footer,
          fillColor: AppColors.backgroundGrey,
          border: OutlineInputBorder(
            borderRadius: Ui.allBorderRadius(8),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
