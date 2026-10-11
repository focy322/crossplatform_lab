import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/repositories/film/models/film.dart';
import '../../extensions/extensions.dart';
import '../../theme/theme.dart';
import '../../widgets/film_poster.dart';

/// Второй экран с подробной информацией о выбранном фильме.
class FilmDetailsScreen extends StatelessWidget {
  const FilmDetailsScreen({required this.film, super.key});

  /// Фильм, выбранный на главном экране.
  final Film film;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('О фильме'),
        leading: IconButton(
          tooltip: 'Назад',
          icon: const Icon(Icons.arrow_back_rounded),
          // Возвращаемся к списку, сохраняя введённый запрос поиска.
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: Align(
          alignment: Alignment.topCenter,
          // На широком экране текст остаётся удобным для чтения.
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            // Прокрутка позволяет прочитать описание на небольшом экране.
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 28),
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: ColoredBox(
                      color: ThemeColors.ink,
                      child: FilmPoster(film: film, fit: BoxFit.contain),
                    ),
                  ),
                ),
                20.ph,
                Text(
                  film.title,
                  style: textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: ThemeColors.ink,
                  ),
                ),
                8.ph,
                Text(
                  'Год выпуска: ${film.year}',
                  style: textTheme.bodyLarge?.copyWith(
                    color: ThemeColors.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                24.ph,
                Text(
                  film.description,
                  style: textTheme.bodyLarge?.copyWith(
                    color: ThemeColors.ink,
                    height: 1.6,
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
