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
  bool itemShowIconOnly = false;

  Future<void> slideOpenWidgets() async {
    if (showIconOnly == itemShowIconOnly) return;

    if (showIconOnly) {
      itemShowIconOnly = showIconOnly;
      return;
    }

    await Future.delayed(
      const Duration(milliseconds: 200),
      () => setState(() {
        itemShowIconOnly = showIconOnly;
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    slideOpenWidgets();
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      color: AppColors.white,
      width: showIconOnly ? 90.w : 240.w,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          24.boxHeight,
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              onPressed: () {
                showIconOnly = !showIconOnly;
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
            itemShowIconOnly ? VectorAssets.logoSmall : VectorAssets.logo,
          ),
          56.boxHeight,
          Expanded(
            child: SingleChildScrollView(
              child: ValueListenableBuilder<NavItem>(
                valueListenable: selectedItemNotifier,
                builder: (_, selectedItem, __) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ...NavItem.values.map(
                        (item) => _NavItemWidget(
                          item: item,
                          selected: item == selectedItem,
                          showIconOnly: itemShowIconOnly,
                          onPressed: () => onItemSelected(item),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
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
    showIconOnly = context.screenWidth <= 1024.h;
  }

  final ValueNotifier<NavItem> selectedItemNotifier = ValueNotifier(
    NavItem.dashboard,
  );

  bool showIconOnly = false;

  @override
  void dispose() {
    selectedItemNotifier.dispose();
    super.dispose();
  }

  void onItemSelected(NavItem item) {
    // if (item == selectedItemNotifier.value) return;
    widget.onNavItemChanged(item);
    selectedItemNotifier.value = item;
  }
}
