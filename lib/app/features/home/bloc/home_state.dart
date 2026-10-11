part of 'home_bloc.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class HomeInitial extends HomeState {
  const HomeInitial();
}

final class HomeLoadInProgress extends HomeState {
  const HomeLoadInProgress();
}

final class HomeLoadSuccess extends HomeState {
  const HomeLoadSuccess({required this.films});

  final List<Film> films;

  @override
  List<Object> get props => [films];
}

final class HomeLoadFailure extends HomeState {
  const HomeLoadFailure({required this.message});

  final String message;

  @override
  List<Object> get props => [message];
}
