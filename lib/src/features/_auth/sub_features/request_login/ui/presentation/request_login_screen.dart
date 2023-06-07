import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router_flow/go_router_flow.dart';
import 'package:nobook/src/features/_auth/auth_feature_barrel.dart';
import 'package:nobook/src/global/domain/domain_barrel.dart';
import 'package:nobook/src/global/ui/ui_barrel.dart';
import 'package:nobook/src/utils/utils_barrel.dart';

part 'custom/request_login_column.dart';

part 'custom/school_dropdown.dart';

class RequestLoginScreen extends ConsumerStatefulWidget {
  const RequestLoginScreen({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _RequestLoginScreenState();
}

class _RequestLoginScreenState extends ConsumerState<RequestLoginScreen> {
  @override
  void initState() {
    super.initState();
    RequestLoginStateNotifier.initProvider();
  }

  @override
  void dispose() {
    RequestLoginStateNotifier.disposeProvider();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchSchools();
  }

  void fetchSchools() {
    ref.read(RequestLoginStateNotifier.provider.notifier).fetchSchoolsByQuery(
          searchQuery: '',
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            child: const _RequestLoginColumn(),
          ),
        ),
      ),
    );
  }
}
