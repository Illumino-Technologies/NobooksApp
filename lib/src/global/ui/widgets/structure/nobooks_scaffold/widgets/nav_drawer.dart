part of '../nobooks_scaffold.dart';

class _NavDrawer extends StatefulWidget {
  final ValueChanged<NavItem> onNavItemChanged;

  const _NavDrawer({
    Key? key,
    required this.onNavItemChanged,
  }) : super(key: key);

  @override
  State<_NavDrawer> createState() => _NavDrawerState();
}

class _NavDrawerState extends State<_NavDrawer> {
  @override
  Widget build(BuildContext context) {
    context.screenWidth <= 1024.h;

    MediaQuery.of(context);
    final bool showIconOnly = showIconOnlyNotifier;
    return Container(
      width: showIconOnly ? 90.w : 240.w,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          14.boxHeight,
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              onPressed: () {
                showIconOnlyNotifier = !showIconOnlyNotifier;
                setState(() {});
              },
              icon: SvgPicture.asset(
                !showIconOnly
                    ? VectorAssets.circledChevronLeft
                    : VectorAssets.circledChevronRight,
                color: AppColors.blue500,
              ),
            ),
          ),
          14.boxHeight,
          SvgPicture.asset(
            showIconOnly ? VectorAssets.logoSmall : VectorAssets.logo,
          ),
          56.boxHeight,
          ValueListenableBuilder<NavItem>(
            valueListenable: selectedItemNotifier,
            builder: (_, selectedItem, __) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...NavItem.values.map(
                    (item) => NavItemWidget(
                      item: item,
                      selected: item == selectedItem,
                      showIconOnly: showIconOnly,
                      onPressed: () => onItemSelected(item),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    initializeShowIconOnly();
  }

  void initializeShowIconOnly() {
    showIconOnlyNotifier = context.screenWidth <= 1024.h;
  }

  final ValueNotifier<NavItem> selectedItemNotifier = ValueNotifier(
    NavItem.dashboard,
  );

  bool showIconOnlyNotifier = false;

  @override
  void dispose() {
    selectedItemNotifier.dispose();
    super.dispose();
  }

  void onItemSelected(NavItem item) {
    if (item == selectedItemNotifier.value) return;
    selectedItemNotifier.value = item;
    widget.onNavItemChanged(item);
  }
}
