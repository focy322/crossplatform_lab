import 'package:dio/dio.dart';

import '../../../data/endpoints.dart';
import 'film_repository_interface.dart';
import 'models/film.dart';

/// Получает каталог и подробности фильма, преобразуя JSON в модели.
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

  /// Выполняет отдельный запрос для второго экрана по заданию лабораторной № 5.
  /// Сейчас экран использует те же поля, которые уже получены в каталоге.
  @override
  Future<Film> getFilm(int id) async {
    // Без токена запрос не отправляется; BLoC покажет это сообщение на экране.
    if (!dio.options.headers.containsKey('Authorization')) {
      throw StateError('Не указан ключ доступа TMDB.');
    }

    // Общий Dio добавляет к адресу базовый URL, язык и заголовок авторизации.
    // await ожидает ответ сервера, после чего JSON преобразуется в модель Film.
    final response = await dio.get<Map<String, dynamic>>(
      Endpoints.filmDetails(id),
    );
    // Ответ подробностей содержит сам объект фильма, без массива results.
    return Film.fromJson(response.data!);
  }
}
