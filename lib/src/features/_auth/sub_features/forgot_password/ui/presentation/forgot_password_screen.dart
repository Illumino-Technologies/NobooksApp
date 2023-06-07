import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router_flow/go_router_flow.dart';
import 'package:nobook/src/features/_auth/auth_feature_barrel.dart';

import '../../../../../../global/ui/ui_barrel.dart';
import '../../../../../../utils/utils_barrel.dart';

part 'custom/fields_column.dart';

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  @override
  void initState() {
    super.initState();
    ForgotPasswordStateNotifier.initProvider();
  }

  @override
  void dispose() {
    super.dispose();
    ForgotPasswordStateNotifier.disposeProvider();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundGrey,
      body: Center(
        child: FittedBox(
          child: Container(
            width: 592.l,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(24.r),
              boxShadow: const [
                BoxShadow(
                  color: AppColors.black5,
                  blurRadius: 5,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: const _FieldsColumn(),
          ),
        ),
      ),
    );
  }
}
