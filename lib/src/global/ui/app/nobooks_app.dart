import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nobook/src/global/global_barrel.dart';

part 'wrapper.dart';

class NoBooksApp extends StatelessWidget {
  const NoBooksApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    return NobooksWidgetInitializer(
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        builder: (context, child) => ScreenUtilInit(
          designSize: const Size(1366, 1024),
          builder: (context, child) {
            return child!;
          },
          child: child,
        ),
        routerDelegate: AppRouter.router.routerDelegate,
        routeInformationParser: AppRouter.router.routeInformationParser,
        routeInformationProvider: AppRouter.router.routeInformationProvider,
        theme: AppTheme.lightTheme.copyWith(
          textTheme: GoogleFonts.nunitoTextTheme(),
        ),
      ),
    );
  }
}
