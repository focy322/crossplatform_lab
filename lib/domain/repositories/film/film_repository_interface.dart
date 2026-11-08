import 'models/film.dart';

/// Контракт загрузки каталога и подробностей выбранного фильма.
abstract interface class FilmRepositoryInterface {
  /// Возвращает список фильмов для каталога.
  Future<List<Film>> getFilms();

  /// Отдельно запрашивает выбранный фильм по его идентификатору TMDB.
  Future<Film> getFilm(int id);
}
