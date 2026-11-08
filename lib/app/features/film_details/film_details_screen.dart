import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../di/di.dart';
import '../../../domain/repositories/film/models/film.dart';
import '../../extensions/extensions.dart';
import '../../theme/theme.dart';
import '../../widgets/film_poster.dart';
import 'bloc/film_details_bloc.dart';

/// Второй экран самостоятельно загружает подробности выбранного фильма.
class FilmDetailsScreen extends StatelessWidget {
  const FilmDetailsScreen({required this.filmId, super.key});

  /// ID выбранного фильма из адреса /home/film/:id.
  final int filmId;

  @override
  Widget build(BuildContext context) {
    // BlocProvider предоставляет BLoC вложенным виджетам и закрывает его
    // при удалении экрана из дерева виджетов.
    return BlocProvider(
      // При смене ID ключ заставит создать BLoC для другого фильма.
      key: ValueKey(filmId),
      // Получаем новый BLoC из GetIt и сразу отправляем событие загрузки.
      create: (_) =>
          getIt<FilmDetailsBloc>()..add(FilmDetailsLoad(filmId: filmId)),
      child: Scaffold(
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
          // При изменении состояния BLoC перестраиваем содержимое экрана.
          child: BlocBuilder<FilmDetailsBloc, FilmDetailsState>(
            builder: (context, state) => switch (state) {
              FilmDetailsInitial() => const SizedBox.shrink(),
              FilmDetailsLoadInProgress() => const Center(
                child: CircularProgressIndicator(),
              ),
              FilmDetailsLoadSuccess() => _buildFilm(context, state.film),
              FilmDetailsLoadFailure() => Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(state.message, textAlign: TextAlign.center),
                      16.ph,
                      FilledButton(
                        // Повторяем запрос того же фильма через тот же BLoC.
                        onPressed: () => context.read<FilmDetailsBloc>().add(
                          FilmDetailsLoad(filmId: filmId),
                        ),
                        child: const Text('Повторить'),
                      ),
                    ],
                  ),
                ),
              ),
            },
          ),
        ),
      ),
    );
  }

  /// Показывает данные, полученные отдельным запросом второго экрана.
  Widget _buildFilm(BuildContext context, Film film) {
    final textTheme = Theme.of(context).textTheme;

    return Align(
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
    );
  }
}
