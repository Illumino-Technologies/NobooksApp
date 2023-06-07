part of '../login_screen.dart';

class _LoginColumn extends ConsumerStatefulWidget {
  const _LoginColumn({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _LoginColumnState();
}

class _LoginColumnState extends ConsumerState<_LoginColumn> {
  @override
  Widget build(BuildContext context) {
    ref.listen(LoginStateNotifier.provider.select((value) => value.success),
        (_, successful) {
      if (successful) {
        context.goNamed(AppRoute.dashboard.name);
      }
    });
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
          'Login to your account',
          style: TextStyles.headline4.asNormal.copyWith(
            height: 1.32,
            color: AppColors.neutral500,
          ),
        ),
        SizedBox(height: 32.l),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 96.l),
          child: TextFormField(
            onChanged: onPersonalIDChanged,
            style: TextStyles.paragraph2.copyWith(
              fontSize: 16.spMax,
              height: 1.5,
            ),
            decoration: Ui.authFieldDecoration('Personal ID').copyWith(
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
          child: PasswordAuthField(
            onChanged: onPasswordChanged,
          ),
        ),
        SizedBox(height: 32.l),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 96.l),
          child: Consumer(
            builder: (_, consumerRef, __) {
              final bool loading = consumerRef.watch(
                LoginStateNotifier.provider.select((value) => value.loading),
              );
              return ValueListenableBuilder<bool>(
                valueListenable: formsFilledNotifier,
                builder: (_, formsFilled, __) {
                  return MaterialButton(
                    height: 48.l,
                    elevation: 0,
                    highlightElevation: 0,
                    minWidth: double.infinity,
                    color: AppColors.neutral200,
                    onPressed: formsFilled ? login : null,
                    disabledColor: AppColors.neutral100,
                    child: loading
                        ? const CircularProgressIndicator(
                            color: AppColors.white,
                          )
                        : Text(
                            'Login',
                            style: TextStyles.paragraph2.copyWith(
                              color: AppColors.white,
                              fontSize: 18.spMax,
                              height: 1.5,
                            ),
                          ),
                  );
                },
              );
            },
          ),
        ),
        SizedBox(height: 16.l),
        InkWell(
          onTap: () {
            context.goNamed(AppRoute.changePassword.name);
          },
          child: RichText(
            text: TextSpan(
              text: 'Forgotten or don’t have login details?',
              style: TextStyles.paragraph2.copyWith(
                color: AppColors.neutral500,
                fontSize: 16.spMax,
                height: 1.5,
              ),
              children: [
                TextSpan(
                  text: ' Request now',
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

  final ValueNotifier<bool> formsFilledNotifier = ValueNotifier<bool>(false);

  void updateFormsFilled() {
    formsFilledNotifier.value = personalID.isNotEmpty && password.isNotEmpty;
  }

  String personalID = '';
  String password = '';

  void onPersonalIDChanged(String value) {
    personalID = value;
    updateFormsFilled();
  }

  void onPasswordChanged(String value) {
    password = value;
    updateFormsFilled();
  }

  Future<void> login() async {
    FocusScope.of(context).unfocus();
    await ref.read(LoginStateNotifier.provider.notifier).login(
          personalID: personalID,
          password: password,
        );
  }

  @override
  void dispose() {
    formsFilledNotifier.dispose();
    super.dispose();
  }
}
