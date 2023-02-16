part of '../nobooks_scaffold.dart';

class NavItemWidget extends StatelessWidget {
  final NavItem item;
  final bool selected;
  final VoidCallback onPressed;
  final bool showIconOnly;

  const NavItemWidget({
    Key? key,
    required this.item,
    required this.selected,
    required this.onPressed,
    required this.showIconOnly,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (showIconOnly) {
      return Padding(
        padding: EdgeInsets.only(bottom: 40.h),
        child: MaterialButton(
          onPressed: onPressed,
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 9,
          ),
          minWidth: 48.w,
          color: selected ? AppColors.blue500 : null,
          shape: RoundedRectangleBorder(
            borderRadius: Ui.allBorderRadius(4),
          ),
          elevation: 0,
          child: SvgPicture.asset(
            item.vectorAsset,
            color: selected ? AppColors.white : AppColors.neutral200,
          ),
        ),
      );
    }
    return Padding(
      padding: EdgeInsets.only(bottom: 40.h),
      child: MaterialButton(
        color: selected ? AppColors.blue500 : null,
        shape: RoundedRectangleBorder(
          borderRadius: Ui.allBorderRadius(4),
        ),
        elevation: 0,
        padding: EdgeInsets.symmetric(
          vertical: selected ? 9 : 8,
          horizontal: selected ? 16 : 0,
        ),
        onPressed: onPressed,
        child: Row(
          children: [
            SvgPicture.asset(
              item.vectorAsset,
              color: selected ? AppColors.white : AppColors.neutral200,
            ),
            if (!showIconOnly) ...[
              19.boxWidth,
              Flexible(
                child: Text(
                  item.text,
                  style: TextStyles.paragraph3.asSemibold.copyWith(
                    color: selected ? AppColors.white : AppColors.neutral200,
                  ),
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
