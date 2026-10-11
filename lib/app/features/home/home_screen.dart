import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../di/di.dart';
import '../../../domain/repositories/film/models/film.dart';
import '../../extensions/extensions.dart';
import '../../theme/theme.dart';
import '../../widgets/widgets.dart';
import 'bloc/home_bloc.dart';

/// Главный экран с каталогом фильмов и строкой поиска.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

/// Хранит текущий текст поиска, поэтому экран является StatefulWidget.
class _HomeScreenState extends State<HomeScreen> {
  final _home = getIt<HomeBloc>();

  /// Строка, по которой фильтруются карточки.
  String _query = '';

  @override
  void initState() {
    super.initState();
    if (_home.state is! HomeLoadSuccess) _loadHome();
  }

  void _loadHome() => _home.add(const HomeLoad());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Кинотека'),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: Icon(Icons.movie_filter_outlined),
          ),
        ],
      ),
      // SafeArea не даёт содержимому попасть под вырезы и системные панели.
      body: SafeArea(
        child: BlocBuilder<HomeBloc, HomeState>(
          bloc: _home,
          builder: (context, state) => switch (state) {
            HomeInitial() => const SizedBox.shrink(),
            HomeLoadInProgress() => const Center(
              child: CircularProgressIndicator(),
            ),
            HomeLoadSuccess() => _buildCatalog(state.films),
            HomeLoadFailure() => Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(state.message, textAlign: TextAlign.center),
                    16.ph,
                    FilledButton(
                      onPressed: _loadHome,
                      child: const Text('Повторить'),
                    ),
                  ],
                ),
              ),
            ),
          },
        ),
      ),
    );
  }

  Widget _buildCatalog(List<Film> films) {
    // Поиск фильтрует уже загруженную страницу, дополнительных запросов нет.
    final visibleFilms = films.where(_matchesQuery).toList();

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 28),
      children: [
        Text(
          'Фильмы на вечер',
          style: Theme.of(context).textTheme.headlineMedium
              ?.copyWith(fontWeight: FontWeight.w800, color: ThemeColors.ink),
        ),
        6.ph,
        Text(
          'Популярные фильмы TMDB: ${films.length}',
          style: Theme.of(context).textTheme.bodyLarge
              ?.copyWith(color: ThemeColors.textMuted),
        ),
        20.ph,
        // Поле сразу обновляет состояние и перерисовывает список.
        TextField(
          onChanged: (value) => setState(() => _query = value.trim()),
          decoration: const InputDecoration(
            hintText: 'Найти фильм',
            prefixIcon: Icon(Icons.search_rounded),
          ),
        ),
        20.ph,
        // Вместо пустого списка показываем понятное сообщение.
        if (visibleFilms.isEmpty)
          const _EmptySearch()
        else
          ...visibleFilms.map(
            (film) => Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: ContentCard(
                film: film,
                // Передаём загруженный фильм без запроса для второго экрана.
                onTap: () => context.push('/home/film/${film.id}', extra: film),
              ),
            ),
          ),
      ],
    );
  }

  bool _matchesQuery(Film film) {
    // Пустая строка должна показывать весь каталог.
    if (_query.isEmpty) {
      return true;
    }

    // Сравнение без учёта регистра делает поиск удобнее.
    final normalizedQuery = _query.toLowerCase();
    return film.title.toLowerCase().contains(normalizedQuery) ||
        film.description.toLowerCase().contains(normalizedQuery);
  }
}

/// Заглушка, отображаемая, когда поиск не нашёл ни одного фильма.
class _EmptySearch extends StatelessWidget {
  const _EmptySearch();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 64),
      child: Column(
        children: [
          const Icon(
            Icons.search_off_rounded,
            size: 48,
            color: ThemeColors.textMuted,
          ),
          12.ph,
          Text(
            'Ничего не найдено',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}
