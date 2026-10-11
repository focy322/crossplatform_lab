import 'package:dio/dio.dart';

import '../../../data/endpoints.dart';
import 'film_repository_interface.dart';
import 'models/film.dart';

/// Получает первую страницу популярных фильмов и преобразует JSON в модели.
class FilmRepository implements FilmRepositoryInterface {
  FilmRepository({required this.dio});

  final Dio dio;

  @override
  Future<List<Film>> getFilms() async {
    if (!dio.options.headers.containsKey('Authorization')) {
      throw StateError('Не указан ключ доступа TMDB.');
    }

    final response = await dio.get<Map<String, dynamic>>(
      Endpoints.popularFilms,
    );
    final results = response.data?['results'] as List<dynamic>;
    return results
        .map((item) => Film.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}
