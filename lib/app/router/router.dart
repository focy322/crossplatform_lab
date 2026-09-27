import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:talker_flutter/talker_flutter.dart';

import '../../di/di.dart';
import '../features/home/home.dart';

/// Ключ корневого навигатора для управления стеком экранов.
final _rootNavigationKey = GlobalKey<NavigatorState>(debugLabel: 'root');

/// Маршруты приложения и наблюдатель, записывающий переходы в Talker.
final appRouter = GoRouter(
  navigatorKey: _rootNavigationKey,
  initialLocation: '/home',
  observers: [TalkerRouteObserver(talker)],
  routes: [
    // Единственный экран первой части лабораторной работы.
    GoRoute(
      path: '/home',
      pageBuilder: (_, state) =>
          MaterialPage<void>(key: state.pageKey, child: const HomeScreen()),
    ),
  ],
);
