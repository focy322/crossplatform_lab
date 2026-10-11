import 'package:flutter/material.dart';

import '../../domain/repositories/film/models/film.dart';
import '../theme/theme.dart';
import 'film_poster.dart';

/// Повторно используемая карточка фильма для списка каталога.
class ContentCard extends StatelessWidget {
  const ContentCard({required this.film, required this.onTap, super.key});

  /// Данные, которые карточка отображает.
  final Film film;

  /// Открывает подробности выбранного фильма.
  final VoidCallback onTap;

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
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Левая часть карточки — постер из TMDB.
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
}

/// Оформляет миниатюру постера для конкретного фильма.
class _FilmCover extends StatelessWidget {
  const _FilmCover({required this.film});

  /// Данные с адресом постера.
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
            color: ThemeColors.primary.withValues(alpha: 0.28),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      // Обрезаем изображение по тем же скруглённым углам, что и контейнер.
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: FilmPoster(film: film),
      ),
    );
  }
}
