import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:my_app_forge/core/di/injection.dart';
import 'package:my_app_forge/core/theme/app_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MaterialApp.router(
        routerConfig: getIt<GoRouter>(),
        theme: AppTheme.light(),
        darkTheme: AppTheme.dark(),
        locale: const Locale('en'),
        debugShowCheckedModeBanner: false,
        title: 'My App',
      ),
    );
  }
}
