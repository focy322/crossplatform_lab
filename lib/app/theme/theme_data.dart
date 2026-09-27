import 'package:flutter/material.dart';

import 'theme_colors.dart';

/// Собирает настройки Material-темы приложения в одном месте.
abstract final class AppTheme {
  /// Светлая тема, передаваемая в MaterialApp.
  static ThemeData get lightTheme {
    // Цветовая схема строится из единого акцентного цвета.
    final colorScheme = ColorScheme.fromSeed(
      seedColor: ThemeColors.primary,
      brightness: Brightness.light,
      surface: ThemeColors.surface,
    );

    return ThemeData(
      // Используем актуальные компоненты Material 3.
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: ThemeColors.surface,
      // Общий внешний вид верхней панели всех экранов.
      appBarTheme: const AppBarTheme(
        backgroundColor: ThemeColors.ink,
        foregroundColor: Colors.white,
        centerTitle: false,
        elevation: 0,
        scrolledUnderElevation: 0,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
      ),
      // Стиль поля поиска на главном экране.
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        hintStyle: const TextStyle(color: ThemeColors.textMuted),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFFE8E5F0)),
        ),
      ),
    );
  }
}
