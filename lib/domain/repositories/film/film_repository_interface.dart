import 'models/film.dart';

/// Контракт загрузки списка для главного экрана.
abstract interface class FilmRepositoryInterface {
  Future<List<Film>> getFilms();
}
