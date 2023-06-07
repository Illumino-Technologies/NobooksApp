part of '../request_login_screen.dart';

class _RequestLoginColumn extends ConsumerStatefulWidget {
  const _RequestLoginColumn({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _LoginColumnState();
}

class _LoginColumnState extends ConsumerState<_RequestLoginColumn> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 48.l),
        SvgPicture.asset(
          VectorAssets.logo,
        ),
        SizedBox(height: 40.l),
        Text(
          'Request login details',
          style: TextStyles.headline4.asNormal.copyWith(
            height: 1.32,
            fontSize: 32.spMax,
            color: AppColors.neutral500,
          ),
        ),
        SizedBox(height: 32.l),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 96.l),
          child: _SchoolDropdown(
            onChanged: onSchoolChanged,
          ),
        ),
        SizedBox(height: 24.l),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 96.l),
          child: TextFormField(
            onChanged: onPersonalIDChanged,
            style: TextStyles.paragraph2.copyWith(
              fontSize: 16.spMax,
              height: 1.5,
            ),
            decoration: Ui.authFieldDecoration('Full name').copyWith(
              contentPadding: EdgeInsets.symmetric(
                horizontal: 24.l,
                vertical: 12.l,
              ),
            ),
          ),
        ),
        SizedBox(height: 24.l),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 96.l),
          child: TextFormField(
            onChanged: onPersonalIDChanged,
            style: TextStyles.paragraph2.copyWith(
              fontSize: 16.spMax,
              height: 1.5,
            ),
            decoration: Ui.authFieldDecoration('Email Address').copyWith(
              contentPadding: EdgeInsets.symmetric(
                horizontal: 24.l,
                vertical: 12.l,
              ),
            ),
          ),
        ),
        SizedBox(height: 8.l),
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.symmetric(horizontal: 96.l),
          child: Text(
            'We will send your login details to this email address.',
            style: TextStyles.paragraph2.copyWith(
              color: AppColors.neutral500,
              fontSize: 12.spMax,
              height: 1.33,
            ),
          ),
        ),
        SizedBox(height: 32.l),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 96.l),
          child: ValueListenableBuilder<bool>(
            valueListenable: formsFilledNotifier,
            builder: (_, formsFilled, __) {
              return MaterialButton(
                height: 48.l,
                elevation: 0,
                highlightElevation: 0,
                minWidth: double.infinity,
                color: AppColors.neutral200,
                onPressed: formsFilled ? requestLoginDetails : null,
                disabledColor: AppColors.neutral100,
                child: Text(
                  'Login',
                  style: TextStyles.paragraph2.copyWith(
                    color: AppColors.white,
                    fontSize: 18.spMax,
                    height: 1.5,
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(height: 16.l),
        InkWell(
          onTap: () => context.pop(),
          child: RichText(
            text: TextSpan(
              text: 'Already have login details?',
              style: TextStyles.paragraph2.copyWith(
                color: AppColors.neutral500,
                fontSize: 16.spMax,
                height: 1.5,
              ),
              children: [
                TextSpan(
                  text: ' Login now',
                  style: TextStyles.paragraph2.copyWith(
                    color: AppColors.blue500,
                    fontWeight: FontWeight.w700,
                    fontSize: 16.spMax,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 48.l),
      ],
    );
  }

  void searchForSchool(String value) {
    ref
        .read(RequestLoginStateNotifier.provider.notifier)
        .fetchSchoolsByQuery(searchQuery: value);
  }

  School? school;

  void onSchoolChanged(School? value) {
    if (value == null) return;
    school = value;
  }

  final ValueNotifier<bool> formsFilledNotifier = ValueNotifier<bool>(false);

  void updateFormsFilled() {
    formsFilledNotifier.value = fullName.isNotEmpty && emailAddress.isNotEmpty;
  }

  String fullName = '';
  String emailAddress = '';

  void onPersonalIDChanged(String value) {
    fullName = value;
    updateFormsFilled();
  }

  void onPasswordChanged(String value) {
    emailAddress = value;
    updateFormsFilled();
  }

  Future<void> requestLoginDetails() async {}

  @override
  void dispose() {
    formsFilledNotifier.dispose();
    super.dispose();
  }
}
