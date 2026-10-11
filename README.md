# Кинотека

Учебное приложение Flutter. Главный экран загружает первую страницу популярных
фильмов TMDB через Dio и BLoC. Поиск работает по названию и описанию загруженных
фильмов. Подробности открываются с данными выбранной карточки.

В `config/tmdb.local.json` указывается **API Read Access Token** TMDB в поле
`TMDB_ACCESS_TOKEN` (без префикса `Bearer`). Этот локальный файл исключён из Git.
Для другого компьютера скопируйте `config/tmdb.example.json` в
`config/tmdb.local.json` и заполните токен.

Запуск из папки проекта:

```powershell
flutter pub get
flutter run -d windows --dart-define-from-file=config/tmdb.local.json
```

Для Android укажите идентификатор устройства вместо `windows`.
Если модель JSON меняется, обновите сгенерированный код:

```powershell
dart run build_runner build
```
