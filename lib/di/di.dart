import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_bloc_logger/talker_bloc_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';

import '../app/features/home/bloc/home_bloc.dart';
import '../data/dio/set_up.dart';
import '../domain/repositories/film/film_repository.dart';
import '../domain/repositories/film/film_repository_interface.dart';

/// Единый контейнер зависимостей приложения.
final getIt = GetIt.instance;

/// Общий экземпляр логгера для ошибок и навигации.
final talker = TalkerFlutter.init();

/// Один HTTP-клиент используется всеми запросами каталога.
final dio = Dio();

/// Регистрирует сервисы, доступные из разных частей приложения.
Future<void> setupLocator() async {
  // Защита от повторной регистрации при повторном вызове функции.
  if (!getIt.isRegistered(instance: talker)) {
    getIt.registerSingleton(talker);
  }

  if (!getIt.isRegistered<Dio>()) {
    setUpDio(dio: dio, talker: talker);
    getIt.registerSingleton<Dio>(dio, dispose: (client) => client.close());
  }

  // События и переходы BLoC записываются в тот же журнал, что и HTTP-запросы.
  Bloc.observer = TalkerBlocObserver(talker: talker);

  if (!getIt.isRegistered<FilmRepositoryInterface>()) {
    getIt.registerSingleton<FilmRepositoryInterface>(
      FilmRepository(dio: getIt<Dio>()),
    );
  }
  if (!getIt.isRegistered<HomeBloc>()) {
    getIt.registerSingleton<HomeBloc>(
      HomeBloc(
        filmRepository: getIt<FilmRepositoryInterface>(),
        talker: talker,
      ),
      dispose: (bloc) => bloc.close(),
    );
  }
}
