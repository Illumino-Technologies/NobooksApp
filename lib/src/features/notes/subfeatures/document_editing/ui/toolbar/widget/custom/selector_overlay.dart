part of '../toolbar_widget.dart';

class SelectorOverlay extends StatefulWidget {
  final WidgetBuilder builder;

  const SelectorOverlay({
    Key? key,
    required this.builder,
  }) : super(key: key);

  @override
  State<SelectorOverlay> createState() => _SelectorOverlayState();
}

class _SelectorOverlayState extends State<SelectorOverlay> {
  final ValueNotifier<Offset> _panOffset = ValueNotifier(Offset.zero);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Offset>(
      valueListenable: _panOffset,
      builder: (_, offset, __) {
        return Transform.translate(
          offset: offset,
          child: Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: EdgeInsets.only(top: 128.h, right: 128.w),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Material(
                  color: AppColors.white,
                  child: Column(
                    children: [
                      HandleBar(
                        onPanUpdate: (details) {
                          final Offset offset = Offset(
                            _panOffset.value.dx + details.dx,
                            _panOffset.value.dy + details.dy,
                          );
                          _panOffset.value = offset;
                        },
                        onPanEnd: () {},
                      ),
                      widget.builder(context),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class HandleBar extends StatelessWidget {
  final ValueChanged<Offset> onPanUpdate;
  final VoidCallback onPanEnd;

  const HandleBar({
    Key? key,
    required this.onPanUpdate,
    required this.onPanEnd,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.grab,
      child: GestureDetector(
        onPanUpdate: (details) {
          onPanUpdate(details.delta);
        },
        onPanEnd: (details) => onPanEnd(),
        child: Container(
          width: 150.w,
          color: AppColors.neutral100,
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [
              6.boxHeight,
              const Divider(
                height: 0.5,
                thickness: 0.5,
                color: AppColors.black,
              ),
              4.boxHeight,
              const Divider(
                height: 0.5,
                thickness: 0.5,
                color: AppColors.black,
              ),
              6.boxHeight,
            ],
          ),
        ),
      ),
    );
  }
}
