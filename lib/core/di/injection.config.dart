// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:connectivity_plus/connectivity_plus.dart' as _i895;
import 'package:dio/dio.dart' as _i361;
import 'package:flutter/foundation.dart' as _i971;
import 'package:get_it/get_it.dart' as _i174;
import 'package:go_router/go_router.dart' as _i583;
import 'package:injectable/injectable.dart' as _i526;
import 'package:my_app_forge/core/di/register_module.dart' as _i322;
import 'package:my_app_forge/core/network/api_client.dart' as _i113;
import 'package:my_app_forge/core/network/auth_interceptor.dart' as _i16;
import 'package:my_app_forge/core/network/logging_interceptor.dart' as _i1066;
import 'package:my_app_forge/core/network/network_info.dart' as _i576;
import 'package:my_app_forge/core/permissions/permission_bloc/permission_bloc.dart'
    as _i1073;
import 'package:my_app_forge/core/permissions/permission_service.dart' as _i988;
import 'package:my_app_forge/core/permissions/permission_service_impl.dart'
    as _i695;
import 'package:my_app_forge/core/router/app_router.dart' as _i1041;
import 'package:my_app_forge/core/storage/local_datasource.dart' as _i144;
import 'package:my_app_forge/core/storage/local_datasource_impl.dart' as _i265;
import 'package:my_app_forge/features/home/data/datasources/home_local_datasource.dart'
    as _i660;
import 'package:my_app_forge/features/home/data/datasources/home_local_datasource_impl.dart'
    as _i916;
import 'package:my_app_forge/features/home/data/datasources/home_remote_datasource.dart'
    as _i44;
import 'package:my_app_forge/features/home/data/datasources/home_remote_datasource_impl.dart'
    as _i21;
import 'package:my_app_forge/features/home/data/repositories/home_repository_impl.dart'
    as _i671;
import 'package:my_app_forge/features/home/domain/repositories/home_repository.dart'
    as _i363;
import 'package:my_app_forge/features/home/domain/usecases/bookmark_item_usecase.dart'
    as _i214;
import 'package:my_app_forge/features/home/domain/usecases/get_cached_items_usecase.dart'
    as _i910;
import 'package:my_app_forge/features/home/domain/usecases/get_home_items_usecase.dart'
    as _i352;
import 'package:my_app_forge/features/home/presentation/bloc/home_bloc.dart'
    as _i435;
import 'package:my_app_forge/features/home/presentation/cubit/home_cubit.dart'
    as _i847;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    gh.singleton<_i971.ValueNotifier<bool>>(() => registerModule.authNotifier);
    gh.lazySingleton<_i361.Dio>(() => registerModule.dio);
    gh.lazySingleton<_i895.Connectivity>(() => registerModule.connectivity);
    gh.lazySingleton<_i583.GoRouter>(() => registerModule.goRouter);
    gh.lazySingleton<_i1066.LoggingInterceptor>(
      () => _i1066.LoggingInterceptor(),
    );
    gh.lazySingleton<_i1041.AppRouter>(() => _i1041.AppRouter());
    gh.lazySingleton<_i44.HomeRemoteDataSource>(
      () => _i21.HomeRemoteDataSourceImpl(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i988.PermissionService>(
      () => _i695.PermissionServiceImpl(),
    );
    gh.lazySingleton<_i576.NetworkInfo>(
      () => _i576.NetworkInfoImpl(gh<_i895.Connectivity>()),
    );
    gh.lazySingleton<_i144.LocalDataSource>(
      () => _i265.LocalDataSourceImpl(gh<_i460.SharedPreferences>()),
    );
    gh.factory<_i1073.PermissionBloc>(
      () => _i1073.PermissionBloc(gh<_i988.PermissionService>()),
    );
    gh.lazySingleton<_i660.HomeLocalDataSource>(
      () => _i916.HomeLocalDataSourceImpl(gh<_i144.LocalDataSource>()),
    );
    gh.lazySingleton<_i16.AuthInterceptor>(
      () => _i16.AuthInterceptor(
        gh<_i144.LocalDataSource>(),
        gh<_i1041.AppRouter>(),
      ),
    );
    gh.lazySingleton<_i363.HomeRepository>(
      () => _i671.HomeRepositoryImpl(
        gh<_i44.HomeRemoteDataSource>(),
        gh<_i660.HomeLocalDataSource>(),
        gh<_i576.NetworkInfo>(),
      ),
    );
    gh.lazySingleton<_i113.ApiClient>(
      () => _i113.ApiClient(
        gh<_i361.Dio>(),
        gh<_i16.AuthInterceptor>(),
        gh<_i1066.LoggingInterceptor>(),
      ),
    );
    gh.factory<_i214.BookmarkItemUseCase>(
      () => _i214.BookmarkItemUseCase(gh<_i363.HomeRepository>()),
    );
    gh.factory<_i910.GetCachedItemsUseCase>(
      () => _i910.GetCachedItemsUseCase(gh<_i363.HomeRepository>()),
    );
    gh.factory<_i352.GetHomeItemsUseCase>(
      () => _i352.GetHomeItemsUseCase(gh<_i363.HomeRepository>()),
    );
    gh.factory<_i435.HomeBloc>(
      () => _i435.HomeBloc(
        gh<_i352.GetHomeItemsUseCase>(),
        gh<_i910.GetCachedItemsUseCase>(),
        gh<_i214.BookmarkItemUseCase>(),
      ),
    );
    gh.factory<_i847.HomeCubit>(
      () => _i847.HomeCubit(
        gh<_i352.GetHomeItemsUseCase>(),
        gh<_i910.GetCachedItemsUseCase>(),
        gh<_i214.BookmarkItemUseCase>(),
      ),
    );
    return this;
  }
}

class _$RegisterModule extends _i322.RegisterModule {}
