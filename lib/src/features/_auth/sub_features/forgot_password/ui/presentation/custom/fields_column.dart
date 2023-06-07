part of '../forgot_password_screen.dart';

class _FieldsColumn extends ConsumerStatefulWidget {
  const _FieldsColumn({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _FieldsColumnState();
}

class _FieldsColumnState extends ConsumerState<_FieldsColumn> {
  @override
  Widget build(BuildContext context) {
    ref.listen(ForgotPasswordStateNotifier.provider.select((value) {
      return value.success;
    }), (_, successful) {
      if (successful) context.goNamed(AppRoute.dashboard.name);
    });
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 48.l),
        SvgPicture.asset(
          VectorAssets.logo,
        ),
        SizedBox(height: 44.l),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 130.l),
          child: Text(
            'Change your password for account security',
            textAlign: TextAlign.center,
            style: TextStyles.headline4.asNormal.copyWith(
              height: 1.36,
              fontSize: 32.spMax,
              color: AppColors.neutral500,
            ),
          ),
        ),
        SizedBox(height: 32.l),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 96.l),
          child: PasswordAuthField(
            hintText: 'Enter password',
            onChanged: onPasswordChanged,
          ),
        ),
        SizedBox(height: 24.l),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 96.l),
          child: PasswordAuthField(
            hintText: 'Enter password again',
            onChanged: onConfirmPasswordChanged,
            validator: (String? value) {
              if (value.isNullOrEmpty) {
                return 'Field cannot be empty';
              }
              if (value != password) {
                return 'Passwords do not match';
              }
              return null;
            },
          ),
        ),
        SizedBox(height: 32.l),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 96.l),
          child: ValueListenableBuilder<bool>(
            valueListenable: formsFilledNotifier,
            builder: (_, formsFilled, __) {
              return Consumer(
                builder: (_, ref, __) {
                  final bool loading = ref.watch(
                    ForgotPasswordStateNotifier.provider.select(
                      (value) => value.loading,
                    ),
                  );
                  return MaterialButton(
                    height: 48.l,
                    elevation: 0,
                    highlightElevation: 0,
                    minWidth: double.infinity,
                    color: AppColors.neutral200,
                    onPressed: formsFilled ? requestLoginDetails : null,
                    disabledColor: AppColors.neutral100,
                    child: loading
                        ? const CircularProgressIndicator(
                            color: AppColors.white,
                          )
                        : Text(
                            'Finish up',
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
        SizedBox(height: 48.l),
      ],
    );
  }

  final ValueNotifier<bool> formsFilledNotifier = ValueNotifier<bool>(false);

  void updateFormsFilled() {
    final bool formsValidated = password.isNotEmpty &&
        confirmPassword.isNotEmpty &&
        password == confirmPassword;
    if (formsFilledNotifier.value != formsValidated) {
      formsFilledNotifier.value = formsValidated;
    }
  }

  String password = '';
  String confirmPassword = '';

  void onPasswordChanged(String value) {
    password = value;
    updateFormsFilled();
  }

  void onConfirmPasswordChanged(String value) {
    confirmPassword = value;
    updateFormsFilled();
  }

  Future<void> requestLoginDetails() async {
    FocusScope.of(context).unfocus();
    await ref.read(ForgotPasswordStateNotifier.provider.notifier).resetPassword(
          password: password,
        );
  }

  @override
  void dispose() {
    formsFilledNotifier.dispose();
    super.dispose();
  }
}
