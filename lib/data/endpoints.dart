/// Адреса запросов, используемых приложением.
class Endpoints {
  Endpoints._();

  /// Запрос списка популярных фильмов для главного экрана.
  static const String popularFilms = '/movie/popular';

  /// Адрес запроса одного фильма: например, для ID 687163 — /movie/687163.
  static String filmDetails(int id) => '/movie/$id';
}
