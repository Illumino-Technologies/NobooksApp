part of '../record_page.dart';

class _TermDropDown extends StatelessWidget {
  const _TermDropDown({
    super.key,
    required this.terms,
    required this.onTermChanged,
  });

  final ValueChanged<TermPeriod?> onTermChanged;

  final Iterable<TermPeriod> terms;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 33.h,
      width: 120.w,
      padding: const EdgeInsets.symmetric(horizontal: 7),
      decoration: BoxDecoration(
        color: AppColors.blue50,
        borderRadius: BorderRadius.circular(5),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<TermPeriod>(
          elevation: 0,
          borderRadius: BorderRadius.circular(10),
          icon: const Icon(
            Icons.expand_more,
            color: Colors.black,
          ),
          value: terms.first,
          items: terms
              .map(
                (term) => DropdownMenuItem<TermPeriod>(
                  value: term,
                  child: Text(
                    '${term.number.toOrdinal()} term',
                    style: TextStyles.paragraph1.copyWith(
                      color: AppColors.blue500,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              )
              .toList(),
          onChanged: onTermChanged,
        ),
      ),
    );
  }
}
