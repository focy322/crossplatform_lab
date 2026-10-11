import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'film.g.dart';

/// Поля фильма из ответа TMDB, необходимые двум экранам приложения.
@JsonSerializable(fieldRename: FieldRename.snake)
class Film extends Equatable {
  const Film({
    required this.id,
    required this.title,
    this.overview = '',
    this.releaseDate = '',
    this.posterPath,
  });

  final int id;
  final String title;

  @JsonKey(defaultValue: '')
  final String overview;

  @JsonKey(defaultValue: '')
  final String releaseDate;

  final String? posterPath;

  factory Film.fromJson(Map<String, dynamic> json) => _$FilmFromJson(json);

  Map<String, dynamic> toJson() => _$FilmToJson(this);

  /// Дата в API имеет формат YYYY-MM-DD; в карточке нужен только год.
  String get year =>
      releaseDate.length >= 4 ? releaseDate.substring(0, 4) : 'Год неизвестен';

  String get description =>
      overview.trim().isEmpty ? 'Описание отсутствует.' : overview;

  /// TMDB возвращает путь постера, а не полный адрес изображения.
  String? get posterUrl => posterPath == null || posterPath!.isEmpty
      ? null
      : 'https://image.tmdb.org/t/p/w500$posterPath';

  @override
  List<Object?> get props => [id, title, overview, releaseDate, posterPath];
}
