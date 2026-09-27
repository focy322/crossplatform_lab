import 'package:flutter/material.dart';

/// Палитра, используемая во всех компонентах приложения.
abstract final class ThemeColors {
  /// Тёмный цвет шапки и основного текста.
  static const ink = Color(0xFF171A23);

  /// Фон экранов.
  static const surface = Color(0xFFF8F7FC);

  /// Светлый декоративный оттенок.
  static const lavender = Color(0xFFECE8FF);

  /// Основной акцентный цвет.
  static const primary = Color(0xFF6554C0);

  /// Приглушённый цвет второстепенного текста.
  static const textMuted = Color(0xFF666878);

  /// Фон карточек каталога.
  static const card = Colors.white;
}
