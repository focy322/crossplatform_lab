import 'package:flutter/material.dart';

import '../features/home/models/film.dart';
import '../theme/theme.dart';

/// Повторно используемая карточка фильма для списка каталога.
class ContentCard extends StatelessWidget {
  const ContentCard({required this.film, super.key});

  /// Данные, которые карточка отображает.
  final Film film;

  @override
  Widget build(BuildContext context) {
    // Semantics помогает экранным дикторам озвучить карточку как кнопку.
    return Semantics(
      button: true,
      label: '${film.title}, ${film.year}',
      child: Material(
        color: ThemeColors.card,
        borderRadius: BorderRadius.circular(20),
        // InkWell добавляет визуальную реакцию на нажатие.
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () => _showFilmInfo(context),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Левая часть карточки — локальное изображение-постер.
                _FilmCover(film: film),
                const SizedBox(width: 14),
                Expanded(
                  child: SizedBox(
                    height: 104,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          film.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(
                                fontWeight: FontWeight.w700,
                                color: ThemeColors.ink,
                              ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          film.year,
                          style: Theme.of(context).textTheme.labelLarge
                              ?.copyWith(
                                color: ThemeColors.primary,
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                        const Spacer(),
                        Text(
                          film.description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                color: ThemeColors.textMuted,
                                height: 1.25,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 4),
                const Padding(
                  padding: EdgeInsets.only(top: 4),
                  child: Icon(
                    Icons.chevron_right_rounded,
                    color: ThemeColors.textMuted,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showFilmInfo(BuildContext context) {
    // В первой части работы детали фильма ещё не реализованы,
    // поэтому нажатие подтверждается коротким сообщением.
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Вы выбрали фильм «${film.title}»')));
  }
}

/// Оформляет миниатюру постера для конкретного фильма.
class _FilmCover extends StatelessWidget {
  const _FilmCover({required this.film});

  /// Данные, задающие цвет, иконку и год на постере.
  final Film film;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 76,
      height: 104,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: film.color.withValues(alpha: 0.28),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      // Обрезаем изображение по тем же скруглённым углам, что и контейнер.
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Локальный asset выполняет требование задания об изображении.
            Image.asset(
              'assets/images/cinema_poster.png',
              fit: BoxFit.cover,
              color: film.color.withValues(alpha: 0.38),
              colorBlendMode: BlendMode.srcATop,
            ),
            // Цветовая заливка делает один постер визуально разным для фильмов.
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    film.color.withValues(alpha: 0.82),
                  ],
                ),
              ),
            ),
            // Полупрозрачная иконка создаёт декоративный фон.
            Positioned(
              right: -14,
              top: -10,
              child: Icon(
                film.symbol,
                size: 76,
                color: Colors.white.withValues(alpha: 0.18),
              ),
            ),
            // Центральная иконка показывает тему фильма.
            Center(child: Icon(film.symbol, color: Colors.white, size: 34)),
            Positioned(
              left: 9,
              bottom: 8,
              child: Text(
                film.year,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 11,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
