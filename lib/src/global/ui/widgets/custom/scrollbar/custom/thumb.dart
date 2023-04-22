part of '../custom_scrollbar.dart';

class _Thumb extends StatelessWidget {
  final double? width;
  final double? height;
  final GestureDragUpdateCallback onVerticalDrag;
  final GestureDragStartCallback onVerticalDragStart;
  final GestureDragEndCallback onVerticalDragEnd;
  final GestureTapDownCallback onTapDown;
  final bool active;

  const _Thumb({
    Key? key,
    this.width,
    this.height,
    required this.onVerticalDrag,
    required this.onVerticalDragStart,
    required this.active,
    required this.onVerticalDragEnd,
    required this.onTapDown,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 161.h,
      width: width ?? 16.w,
      child: GestureDetector(
        onVerticalDragUpdate: onVerticalDrag,
        onVerticalDragStart: onVerticalDragStart,
        onVerticalDragEnd: onVerticalDragEnd,
        onTapDown: onTapDown,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: height ?? 161.h,
          width: width ?? 16.w,
          decoration: BoxDecoration(
            color: AppColors.grey.withOpacity(active ? 1 : 0.2),
            borderRadius: Ui.allBorderRadius(100.r),
          ),
        ),
      ),
    );
  }
}
