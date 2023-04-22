part of '../nobooks_scaffold.dart';

class TopBar extends ConsumerStatefulWidget {
  final ValueChanged<String>? onSearchFieldChanged;

  const TopBar({
    this.onSearchFieldChanged,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _TopBarState();
}

class _TopBarState extends ConsumerState<TopBar> {
  @override
  Widget build(BuildContext context) {
    final User? user = ref.watch(StudentNotifier.provider);
    return Container(
      color: AppColors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
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
                  onChanged: widget.onSearchFieldChanged,
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
