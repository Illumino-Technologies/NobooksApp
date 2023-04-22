part of '../custom_scrollbar.dart';

class _Track extends StatelessWidget {
  final double? width;
  final double? height;
  final bool active;
  final GestureTapUpCallback onTap;

  const _Track({
    Key? key,
    this.width,
    this.height,
    required this.active,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapUp: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: height?.h ?? double.infinity,
        width: width?.w ?? 16.w,
        decoration: BoxDecoration(
          color: AppColors.grey100.withOpacity(active ? 1 : 0.5),
          borderRadius: Ui.allBorderRadius(100.r),
        ),
      ),
    );
  }
}
