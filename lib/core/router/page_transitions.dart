import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

CupertinoPage<T> buildCupertinoPage<T>({
  required Widget child,
  required GoRouterState state,
}) {
  return CupertinoPage<T>(
    key: state.pageKey,
    name: state.name ?? state.path,
    child: child,
  );
}

CustomTransitionPage<T> buildSlideTransitionPage<T>({
  required Widget child,
  required GoRouterState state,
}) {
  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return SlideTransition(
        position: animation.drive(
          Tween<Offset>(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).chain(CurveTween(curve: Curves.easeInOut)),
        ),
        child: child,
      );
    },
  );
}

CustomTransitionPage<T> buildFadeTransitionPage<T>({
  required Widget child,
  required GoRouterState state,
}) {
  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    },
    transitionDuration: const Duration(milliseconds: 200),
  );
}
