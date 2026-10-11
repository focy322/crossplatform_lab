import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:talker_flutter/talker_flutter.dart';

import '../../di/di.dart';
import '../../domain/repositories/film/models/film.dart';
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
          path: 'film/:id',
          // Подробности открываются только для переданного из каталога фильма.
          redirect: (_, state) {
            final id = int.tryParse(state.pathParameters['id'] ?? '');
            final film = state.extra;
            return film is! Film || film.id != id ? '/home' : null;
          },
          pageBuilder: (_, state) => MaterialPage<void>(
            key: state.pageKey,
            child: FilmDetailsScreen(film: state.extra as Film),
          ),
        ),
      ],
    ),
  ],
);
