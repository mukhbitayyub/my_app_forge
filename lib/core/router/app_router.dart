import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:my_app_forge/core/di/injection.dart';
import 'package:my_app_forge/core/router/app_routes.dart';
import 'package:my_app_forge/core/router/page_transitions.dart';
import 'package:my_app_forge/core/router/scaffold_with_nav_bar.dart';
import 'package:my_app_forge/presentation/pages/detail_page.dart';
import 'package:my_app_forge/presentation/pages/home_page.dart';
import 'package:my_app_forge/presentation/pages/not_found_page.dart';
import 'package:my_app_forge/presentation/pages/onboarding_page.dart';
import 'package:my_app_forge/presentation/pages/profile_page.dart';
import 'package:my_app_forge/presentation/pages/search_page.dart';
import 'package:my_app_forge/presentation/pages/settings_page.dart';
import 'package:my_app_forge/presentation/pages/splash_page.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

@lazySingleton
class AppRouter {
  AppRouter() {
    getIt.registerSingleton<GlobalKey<NavigatorState>>(rootNavigatorKey);
  }

  late final GoRouter router = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: AppRoutes.splashPath,
    errorBuilder: (context, state) => const NotFoundPage(),
    redirect: (context, state) {
      final authNotifier = getIt<ValueNotifier<bool>>();
      final isLoggedIn = authNotifier.value;
      final isSplash = state.matchedLocation == AppRoutes.splashPath;
      final isOnboarding = state.matchedLocation == AppRoutes.onboardingPath;

      if (!isLoggedIn && !isSplash && !isOnboarding) {
        return AppRoutes.onboardingPath;
      }
      if (isLoggedIn && (isSplash || isOnboarding)) {
        return AppRoutes.homePath;
      }
      return null;
    },
    routes: [
      GoRoute(
        path: AppRoutes.splashPath,
        name: AppRoutes.splashName,
        pageBuilder: (context, state) => buildCupertinoPage(
          child: const SplashPage(),
          state: state,
        ),
      ),
      GoRoute(
        path: AppRoutes.onboardingPath,
        name: AppRoutes.onboardingName,
        pageBuilder: (context, state) => buildCupertinoPage(
          child: const OnboardingPage(),
          state: state,
        ),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return ScaffoldWithNavBar(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            navigatorKey: GlobalKey<NavigatorState>(),
            routes: [
              GoRoute(
                path: AppRoutes.homePath,
                name: AppRoutes.homeName,
                pageBuilder: (context, state) => buildCupertinoPage(
                  child: const HomePage(),
                  state: state,
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: GlobalKey<NavigatorState>(),
            routes: [
              GoRoute(
                path: AppRoutes.searchPath,
                name: AppRoutes.searchName,
                pageBuilder: (context, state) => buildCupertinoPage(
                  child: const SearchPage(),
                  state: state,
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: GlobalKey<NavigatorState>(),
            routes: [
              GoRoute(
                path: AppRoutes.profilePath,
                name: AppRoutes.profileName,
                pageBuilder: (context, state) => buildCupertinoPage(
                  child: const ProfilePage(),
                  state: state,
                ),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: AppRoutes.detailPath,
        name: AppRoutes.detailName,
        pageBuilder: (context, state) => buildCupertinoPage(
          child: const DetailPage(),
          state: state,
        ),
      ),
      GoRoute(
        path: AppRoutes.settingsPath,
        name: AppRoutes.settingsName,
        pageBuilder: (context, state) => buildCupertinoPage(
          child: const SettingsPage(),
          state: state,
        ),
      ),
    ],
  );
}
