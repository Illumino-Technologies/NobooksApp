part of '../nobooks_scaffold.dart';

class TopBarField extends StatelessWidget {
  final ValueChanged<String>? onChanged;
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
        onChanged: onChanged,
        enabled: onChanged != null,
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
