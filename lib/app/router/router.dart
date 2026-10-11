import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:talker_flutter/talker_flutter.dart';

import '../../di/di.dart';
import '../features/film_details/film_details_screen.dart';
import '../features/home/home.dart';

/// Ключ корневого навигатора для управления стеком экранов.
final _rootNavigationKey = GlobalKey<NavigatorState>(debugLabel: 'root');

/// Маршруты приложения и наблюдатель, записывающий переходы в Talker.
final appRouter = GoRouter(
  navigatorKey: _rootNavigationKey,
  initialLocation: '/home',
  observers: [TalkerRouteObserver(talker)],
  routes: [
    // Главный экран остаётся в стеке при открытии подробностей.
    GoRoute(
      path: '/home',
      pageBuilder: (_, state) =>
          MaterialPage<void>(key: state.pageKey, child: const HomeScreen()),
      routes: [
        GoRoute(
          path: 'film/:index',
          // Некорректный адрес возвращает к каталогу вместо ошибки индекса.
          redirect: (_, state) {
            final index = int.tryParse(state.pathParameters['index'] ?? '');
            return index == null || index < 0 || index >= films.length
                ? '/home'
                : null;
          },
          pageBuilder: (_, state) => MaterialPage<void>(
            key: state.pageKey,
            child: FilmDetailsScreen(
              film: films[int.parse(state.pathParameters['index']!)],
            ),
          ),
        ),
      ],
    ),
  ],
);
