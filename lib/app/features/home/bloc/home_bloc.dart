import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talker/talker.dart';

import '../../../../domain/repositories/film/film_repository_interface.dart';
import '../../../../domain/repositories/film/models/film.dart';

part 'home_event.dart';
part 'home_state.dart';

/// Связывает загрузку из репозитория с состояниями главного экрана.
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({required this.filmRepository, required this.talker})
    : super(const HomeInitial()) {
    on<HomeLoad>(_loadFilms);
  }

  final FilmRepositoryInterface filmRepository;
  final Talker talker;

  Future<void> _loadFilms(HomeLoad event, Emitter<HomeState> emit) async {
    // Не отправляем второй запрос, пока предыдущий ещё выполняется.
    if (state is HomeLoadInProgress) return;

    emit(const HomeLoadInProgress());
    try {
      final films = await filmRepository.getFilms();
      emit(HomeLoadSuccess(films: films));
    } catch (exception, stackTrace) {
      talker.handle(exception, stackTrace);
      emit(HomeLoadFailure(message: _errorMessage(exception)));
    }
  }

  String _errorMessage(Object exception) {
    if (exception is StateError) return exception.message;
    if (exception is DioException) {
      if (exception.response?.statusCode == 401 ||
          exception.response?.statusCode == 403) {
        return 'TMDB отклонил ключ доступа.';
      }
      if (exception.type == DioExceptionType.connectionTimeout ||
          exception.type == DioExceptionType.receiveTimeout) {
        return 'Сервер не ответил вовремя. Повторите загрузку.';
      }
      return 'Не удалось загрузить фильмы. Проверьте подключение к интернету.';
    }
    return 'Не удалось обработать данные фильмов.';
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    talker.handle(error, stackTrace);
  }
}
