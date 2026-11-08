part of 'film_details_bloc.dart';

/// Текущее состояние загрузки; по нему BlocBuilder выбирает содержимое экрана.
sealed class FilmDetailsState extends Equatable {
  const FilmDetailsState();

  @override
  List<Object> get props => [];
}

/// BLoC создан, но событие загрузки ещё не обработано.
final class FilmDetailsInitial extends FilmDetailsState {
  const FilmDetailsInitial();
}

/// Запрос выполняется: вместо сведений о фильме показывается индикатор.
final class FilmDetailsLoadInProgress extends FilmDetailsState {
  const FilmDetailsLoadInProgress();
}

/// Запрос завершился успешно; film содержит данные из ответа второго запроса.
final class FilmDetailsLoadSuccess extends FilmDetailsState {
  const FilmDetailsLoadSuccess({required this.film});

  final Film film;

  @override
  List<Object> get props => [film];
}

/// Загрузка завершилась ошибкой; message выводится рядом с кнопкой «Повторить».
final class FilmDetailsLoadFailure extends FilmDetailsState {
  const FilmDetailsLoadFailure({required this.message});

  final String message;

  @override
  List<Object> get props => [message];
}
