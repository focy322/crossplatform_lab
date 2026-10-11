// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'film.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Film _$FilmFromJson(Map<String, dynamic> json) => Film(
  id: (json['id'] as num).toInt(),
  title: json['title'] as String,
  overview: json['overview'] as String? ?? '',
  releaseDate: json['release_date'] as String? ?? '',
  posterPath: json['poster_path'] as String?,
);

Map<String, dynamic> _$FilmToJson(Film instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'overview': instance.overview,
  'release_date': instance.releaseDate,
  'poster_path': instance.posterPath,
};
