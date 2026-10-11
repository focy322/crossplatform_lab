part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

/// Загрузка каталога при открытии экрана или повторная попытка после ошибки.
final class HomeLoad extends HomeEvent {
  const HomeLoad();
}
