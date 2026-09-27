import 'package:flutter/widgets.dart';

import 'app/app.dart';
import 'di/di.dart';

/// Точка входа приложения: инициализирует сервисы, обработчик ошибок и UI.
Future<void> main() async {
  // Нужна до вызовов Flutter API до runApp.
  WidgetsFlutterBinding.ensureInitialized();

  // Регистрируем общие зависимости, например логгер.
  await setupLocator();

  // Отправляем необработанные ошибки Flutter в Talker.
  FlutterError.onError = (details) {
    talker.handle(details.exception, details.stack);
  };

  // Запускаем корневой виджет приложения.
  runApp(const CinemaShelfApp());
}
