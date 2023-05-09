part of '../record_page.dart';

class _ClassDropDown extends ConsumerStatefulWidget {
  final ValueChanged<Class> onChanged;

  const _ClassDropDown({
    required this.onChanged,
  });

  @override
  ConsumerState createState() => _ClassDropDownState();
}

class _ClassDropDownState extends ConsumerState<_ClassDropDown> {
  Class? currentClass;

  void onClassChanged(Class? class_) {
    if (class_ == null) return;
    setState(() {
      currentClass = class_;
    });
    widget.onChanged(class_);
  }

  @override
  Widget build(BuildContext context) {
    final List<Class> classes = ref.watch(
      RecordsNotifier.provider.select((value) => value.classes),
    );
    return Container(
      height: 30,
      width: 90,
      padding: const EdgeInsets.symmetric(horizontal: 7),
      decoration: BoxDecoration(
        color: AppColors.blue50,
        borderRadius: BorderRadius.circular(5),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<Class>(
          value: currentClass ?? classes.first,
          icon: const Icon(Icons.keyboard_arrow_down),
          items: classes.map<DropdownMenuItem<Class>>((Class class_) {
            return DropdownMenuItem<Class>(
              value: class_,
              child: Text(
                class_.name,
                style: TextStyles.subHeading.copyWith(
                  color: AppColors.neutral800,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            );
          }).toList(),
          onChanged: onClassChanged,
        ),
      ),
    );
  }
}
