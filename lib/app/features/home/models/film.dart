import 'package:flutter/material.dart';

/// Неизменяемая модель одного фильма в каталоге.
class Film {
  const Film({
    required this.title,
    required this.year,
    required this.description,
    required this.color,
    required this.symbol,
  });

  /// Название фильма.
  final String title;

  /// Год выпуска, отображаемый на карточке.
  final String year;

  /// Краткое описание фильма.
  final String description;

  /// Акцентный цвет постера конкретного фильма.
  final Color color;

  /// Тематическая иконка поверх изображения постера.
  final IconData symbol;
}
