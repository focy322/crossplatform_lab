import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talker/talker.dart';

import '../../../../domain/repositories/film/film_repository_interface.dart';
import '../../../../domain/repositories/film/models/film.dart';

// События и состояния вынесены в файлы, но входят в одну библиотеку с BLoC.
part 'film_details_event.dart';
part 'film_details_state.dart';

/// Управляет отдельным запросом и состояниями экрана подробностей.
class FilmDetailsBloc extends Bloc<FilmDetailsEvent, FilmDetailsState> {
  FilmDetailsBloc({required this.filmRepository, required this.talker})
    : super(const FilmDetailsInitial()) {
    // Получив FilmDetailsLoad от экрана, BLoC запускает обработчик _loadFilm.
    on<FilmDetailsLoad>(_loadFilm);
  }

  final FilmRepositoryInterface filmRepository;
  final Talker talker;

  Future<void> _loadFilm(
    FilmDetailsLoad event,
    Emitter<FilmDetailsState> emit,
  ) async {
    // Повторное нажатие не должно создавать параллельный запрос.
    if (state is FilmDetailsLoadInProgress) return;

    // emit передаёт новое состояние интерфейсу: BlocBuilder покажет индикатор.
    emit(const FilmDetailsLoadInProgress());
    try {
      // Репозиторий делает запрос к API по ID, переданному в событии.
      final film = await filmRepository.getFilm(event.filmId);
      // Передаём полученный Film интерфейсу для отображения подробностей.
      emit(FilmDetailsLoadSuccess(film: film));
    } catch (exception, stackTrace) {
      // Технические подробности сохраняем в журнале, а на экран передаём
      // понятное сообщение. После ошибки пользователь может повторить запрос.
      talker.handle(exception, stackTrace);
      emit(FilmDetailsLoadFailure(message: _errorMessage(exception)));
    }
  }

  /// Преобразует исключения HTTP-клиента и обработки JSON в сообщения для UI.
  String _errorMessage(Object exception) {
    if (exception is StateError) return exception.message;
    if (exception is DioException) {
      if (exception.response?.statusCode == 401 ||
          exception.response?.statusCode == 403) {
        return 'TMDB отклонил ключ доступа.';
      }
      if (exception.response?.statusCode == 404) {
        return 'Фильм не найден.';
      }
      if (exception.type == DioExceptionType.connectionTimeout ||
          exception.type == DioExceptionType.receiveTimeout) {
        return 'Сервер не ответил вовремя. Повторите загрузку.';
      }
      return 'Не удалось загрузить фильм. Проверьте подключение к интернету.';
    }
    return 'Не удалось обработать данные фильма.';
  }

  /// Записывает в Talker ошибки, переданные механизму обработки ошибок BLoC.
  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    talker.handle(error, stackTrace);
  }
}
