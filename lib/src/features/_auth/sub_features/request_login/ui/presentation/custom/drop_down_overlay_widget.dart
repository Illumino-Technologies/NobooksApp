part of '../request_login_screen.dart';

class _DropdownOverlayWidget extends ConsumerStatefulWidget {
  final Offset fieldOffset;
  final ValueChanged<School?> onSelected;

  const _DropdownOverlayWidget({
    required this.fieldOffset,
    required this.onSelected,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _DropdownOverlayState();
}

class _DropdownOverlayState extends ConsumerState<_DropdownOverlayWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () => widget.onSelected(null),
          child: Container(color: AppColors.transparent),
        ),
        Positioned(
          top: widget.fieldOffset.dy,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 444.w),
            child: Dialog(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: Ui.allBorderRadius(4.l),
                side: const BorderSide(
                  color: AppColors.neutral200,
                  width: 1,
                ),
              ),
              child: Container(
                height: 400.l,
                width: 400.l,
                child: Consumer(
                  builder: (_, ref, __) {
                    final List<School> schools = ref.watch(
                      RequestLoginStateNotifier.provider.select(
                        (value) => value.schools,
                      ),
                    );

                    return ListView.builder(
                      itemCount: schools.length,
                      itemBuilder: (context, index) {
                        return Container(
                          child: Text(
                            '',
                            style: TextStyles.paragraph2.copyWith(
                              height: 1.5,
                              color: AppColors.neutral200,
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
