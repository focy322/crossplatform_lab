import 'package:dio/dio.dart';
import 'package:talker/talker.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';

/// Настраивает общий HTTP-клиент для TMDB API v3.
void setUpDio({required Dio dio, required Talker talker}) {
  const accessToken = String.fromEnvironment('TMDB_ACCESS_TOKEN');

  dio.options = BaseOptions(
    baseUrl: 'https://api.themoviedb.org/3',
    queryParameters: {'language': 'ru-RU', 'page': 1},
    headers: {
      'accept': 'application/json',
      if (accessToken.isNotEmpty) 'Authorization': 'Bearer $accessToken',
    },
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 5),
  );

  dio.interceptors.add(
    TalkerDioLogger(
      talker: talker,
      // Заголовок Authorization содержит ключ и не должен попадать в логи.
      settings: const TalkerDioLoggerSettings(
        printRequestData: true,
        printRequestHeaders: false,
        printResponseHeaders: false,
      ),
    ),
  );
}
