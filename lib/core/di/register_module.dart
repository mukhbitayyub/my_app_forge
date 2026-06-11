import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:my_app_forge/core/di/injection.dart';
import 'package:my_app_forge/core/router/app_router.dart';

@module
abstract class RegisterModule {
  @lazySingleton
  Dio get dio => Dio();

  @lazySingleton
  Connectivity get connectivity => Connectivity();



  @singleton
  ValueNotifier<bool> get authNotifier => ValueNotifier<bool>(false);

  @lazySingleton
  GoRouter get goRouter => getIt<AppRouter>().router;
}
