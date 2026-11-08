part of 'film_details_bloc.dart';

/// События, которыми экран сообщает BLoC о действиях пользователя.
sealed class FilmDetailsEvent extends Equatable {
  const FilmDetailsEvent();

  @override
  List<Object> get props => [];
}

/// Загрузка выбранного фильма при открытии экрана или повторной попытке.
final class FilmDetailsLoad extends FilmDetailsEvent {
  const FilmDetailsLoad({required this.filmId});

  /// ID определяет, какой фильм репозиторий должен запросить у TMDB.
  final int filmId;

  // Equatable учитывает ID при сравнении двух событий загрузки.
  @override
  List<Object> get props => [filmId];
}
