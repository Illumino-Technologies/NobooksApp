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
    this.height,
    required this.onVerticalDrag,
    required this.onVerticalDragStart,
    required this.active,
    required this.onVerticalDragEnd,
    required this.onTapDown,
    this.width,
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
        child: Container(
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
