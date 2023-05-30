part of '../theory_stage_page.dart';

class AssessmentSelector extends StatefulWidget {
  final ValueChanged<int> onChanged;
  final int currentItem;
  final int length;

  const AssessmentSelector({
    Key? key,
    required this.onChanged,
    required this.length,
    required this.currentItem,
  }) : super(key: key);

  @override
  State<AssessmentSelector> createState() => _AssessmentSelectorState();
}

class _AssessmentSelectorState extends State<AssessmentSelector> {
  late final List<int> items = List.generate(widget.length, (index) => index);

  late int currentItem = widget.currentItem;

  List<int> changingList = [];

  @override
  void initState() {
    super.initState();
    setChangingList();
  }

  void setChangingList() {
    final List<int> someList = [];
    final int currentIndex = items.indexOf(currentItem);
    if (currentIndex == -1) {
      return;
    }

    final int loopStartValue = currentIndex -
        (currentIndex == items.lastIndex
            ? 2
            : currentIndex == 0
                ? 0
                : 1);

    final int loopEndValue = currentIndex +
        (currentIndex == items.lastIndex
            ? 0
            : currentIndex == 0
                ? 2
                : 1);

    changingList.clear();
    for (int i = loopStartValue; i <= loopEndValue; i++) {
      someList.add(items[i]);
    }
    changingList = someList;
  }

  void onChanged(int index) {
    currentItem = index;
    setState(() {
      setChangingList();
    });
    widget.onChanged(index);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: currentItem == 0 ? null : () => onChanged(currentItem - 1),
          icon: SvgPicture.asset(
            VectorAssets.thickArrowLeft,
            color:
                currentItem == 0 ? AppColors.neutral100 : AppColors.neutral500,
          ),
        ),
        ...changingList.map(
          (e) => Padding(
            padding: EdgeInsets.only(
              left: changingList.indexOf(e) == 0 ? 0 : 24.w,
            ),
            child: InkWell(
              onTap: currentItem == e ? null : () => onChanged(e),
              child: _SelectorItem(
                value: e + 1,
                selected: currentItem == e,
              ),
            ),
          ),
        ),
        IconButton(
          onPressed: currentItem == items.lastIndex
              ? null
              : () => onChanged(currentItem + 1),
          icon: SvgPicture.asset(
            VectorAssets.thickArrowRight,
            color: currentItem == items.lastIndex
                ? AppColors.neutral100
                : AppColors.neutral500,
          ),
        ),
      ],
    );
  }
}

class _SelectorItem extends StatelessWidget {
  final int value;
  final bool selected;

  const _SelectorItem({
    Key? key,
    required this.value,
    required this.selected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32.l,
      height: 32.l,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: Ui.allBorderRadius(4.l),
        color: selected ? AppColors.neutral500 : null,
        border: selected
            ? null
            : Border.all(
                color: AppColors.neutral100,
                width: 1,
              ),
      ),
      child: Text(
        '$value',
        style: TextStyles.subHeading.withColor(AppColors.neutral100),
      ),
    );
  }
}
