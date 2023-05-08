part of '../record_page.dart';

class _ClassDropDown extends StatelessWidget {
  const _ClassDropDown({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: 90,
      padding: const EdgeInsets.symmetric(horizontal: 7),
      decoration: BoxDecoration(
        color: AppColors.blue50,
        borderRadius: BorderRadius.circular(5),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          value: '',
          icon: const Icon(Icons.keyboard_arrow_down),
          items: [
            'SS 1',
            'SS 2',
            'SS 3',
          ].map((String items) {
            return DropdownMenuItem(
              value: items,
              child: Text(
                items,
                style: TextStyles.subHeading.copyWith(
                  color: AppColors.neutral800,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            );
          }).toList(),
          onChanged: (String? newValue) {},
        ),
      ),
    );
  }
}
