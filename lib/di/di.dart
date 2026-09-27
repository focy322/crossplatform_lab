import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

/// Единый контейнер зависимостей приложения.
final getIt = GetIt.instance;

/// Общий экземпляр логгера для ошибок и навигации.
final talker = TalkerFlutter.init();

/// Регистрирует сервисы, доступные из разных частей приложения.
Future<void> setupLocator() async {
  // Защита от повторной регистрации при повторном вызове функции.
  if (!getIt.isRegistered(instance: talker)) {
    getIt.registerSingleton(talker);
  }
}
