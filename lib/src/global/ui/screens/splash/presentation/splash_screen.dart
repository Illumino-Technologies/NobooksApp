import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router_flow/go_router_flow.dart';
import 'package:nobook/src/global/global_barrel.dart';
import 'package:nobook/src/global/ui/screens/splash/state/splash_state_notifier.dart';
import 'package:nobook/src/utils/constants/assets/assets.dart';
import 'package:nobook/src/utils/function/extensions/extensions.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    SplashStateNotifier.provider;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(SplashStateNotifier.provider.notifier).navigateToNext();
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(SplashStateNotifier.provider, (previous, next) {
      if (previous == next || !mounted) return;
      context.goNamed(next.name);
    });
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 0,
        backgroundColor: AppColors.blue300,
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      backgroundColor: AppColors.blue300,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SvgPicture.asset(
              VectorAssets.splashImage,
              width: 200.l,
            ),
          ],
        ),
      ),
    );
  }
}
