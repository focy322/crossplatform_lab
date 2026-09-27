import 'package:flutter/material.dart';

import 'router/router.dart';
import 'theme/theme.dart';

/// Корневой виджет: задаёт тему, название и навигацию приложения.
class CinemaShelfApp extends StatelessWidget {
  const CinemaShelfApp({super.key});

  @override
  Widget build(BuildContext context) {
    // MaterialApp.router передаёт обработку переходов объекту GoRouter.
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Кинотека',
      theme: AppTheme.lightTheme,
      routerConfig: appRouter,
    );
  }
}
