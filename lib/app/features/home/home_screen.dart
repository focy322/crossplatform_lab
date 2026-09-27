import 'package:flutter/material.dart';

import '../../extensions/extensions.dart';
import '../../theme/theme.dart';
import '../../widgets/widgets.dart';
import 'data/film_data.dart';
import 'models/film.dart';

/// Главный экран с каталогом фильмов и строкой поиска.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

/// Хранит текущий текст поиска, поэтому экран является StatefulWidget.
class _HomeScreenState extends State<HomeScreen> {
  /// Строка, по которой фильтруются карточки.
  String _query = '';

  @override
  Widget build(BuildContext context) {
    // При каждом изменении строки поиска выбираем подходящие фильмы.
    final visibleFilms = films.where(_matchesQuery).toList();

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
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 28),
          children: [
            Text(
              'Фильмы на вечер',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w800,
                color: ThemeColors.ink,
              ),
            ),
            6.ph,
            Text(
              'Подборка из ${films.length} классических фильмов',
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
                  child: ContentCard(film: film),
                ),
              ),
          ],
        ),
      ),
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
