part of '../request_login_screen.dart';

class _SchoolDropdown extends ConsumerStatefulWidget {
  final ValueChanged<School> onChanged;

  const _SchoolDropdown({
    required this.onChanged,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _SchoolDropdownState();
}

class _SchoolDropdownState extends ConsumerState<_SchoolDropdown> {
  final TextEditingController controller = TextEditingController();
  final SingleValueDropDownController dropdownController =
      SingleValueDropDownController();

  @override
  void initState() {
    super.initState();
    controller.addListener(textFieldListener);
  }

  void onChanged(School? school) {
    if (school == null) return;
    widget.onChanged(school);
  }

  String searchQuery = '';

  bool searching = false;

  DateTime? lastTyped;

  final Duration typedCheckDelay = const Duration(milliseconds: 500);

  void textFieldListener() {
    checkShouldSearch();
    lastTyped = DateTime.now();
  }

  bool checkingShouldSearch = false;

  Future<void> checkShouldSearch() async {
    if (checkingShouldSearch) return;
// asdfajsd flasdlfj asdfj alsdfjlasdjf asdjfl asjdfaskjldf asjdfl asdfjlasd fasdlfj asdlfj asdlfjas ld
    checkingShouldSearch = true;
    await Future.delayed(typedCheckDelay);

    checkingShouldSearch = false;

    if (lastTyped == null) return;
    if (DateTime.now().difference(lastTyped!) >= typedCheckDelay) {
      searchSchools();
    }
  }

  void searchSchools() {
    if (searching) return;
  }

  @override
  void dispose() {
    controller.removeListener(textFieldListener);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<School> schools = FakeSchoolData.schools;
    return DropDownTextField(
      listTextStyle: TextStyles.paragraph2.copyWith(
        height: 1.5,
        fontSize: 16.spMax,
        color: AppColors.neutral200,
      ),
      textStyle: TextStyles.paragraph2.copyWith(
        height: 1.5,
        fontSize: 16.spMax,
        color: AppColors.neutral200,
      ),
      listSpace: 24.s,
      onChanged: (value) => onChanged(value as School?),
      searchDecoration: Ui.authFieldDecoration('Select your school').copyWith(
        contentPadding: EdgeInsets.symmetric(
          horizontal: 24.l,
          vertical: 12.l,
        ),
      ),
      textFieldDecoration:
          Ui.authFieldDecoration('Select your school').copyWith(
        contentPadding: EdgeInsets.symmetric(
          horizontal: 24.l,
          vertical: 12.l,
        ),
      ),
      controller: dropdownController,
      enableSearch: true,
      clearOption: false,
      dropDownIconProperty: IconProperty(
        icon: Icons.keyboard_arrow_down_outlined,
      ),
      dropDownList: schools.map((e) {
        return DropDownValueModel(
          name: e.name,
          value: e,
        );
      }).toList(),
    );
  }
}
