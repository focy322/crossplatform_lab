import 'package:flutter/material.dart';

import '../../domain/repositories/film/models/film.dart';
import '../theme/theme.dart';

/// Загружает постер TMDB; при отсутствии или ошибке оставляет локальное изображение.
class FilmPoster extends StatelessWidget {
  const FilmPoster({required this.film, this.fit = BoxFit.cover, super.key});

  final Film film;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    final url = film.posterUrl;
    if (url == null) return _placeholder();

    return Image.network(
      url,
      fit: fit,
      semanticLabel: 'Постер фильма «${film.title}»',
      errorBuilder: (_, error, stackTrace) => _placeholder(),
    );
  }

  Widget _placeholder() => Image.asset(
    'assets/images/cinema_poster.png',
    fit: BoxFit.cover,
    color: ThemeColors.primary.withValues(alpha: 0.25),
    colorBlendMode: BlendMode.srcATop,
    semanticLabel: 'Изображение для фильма «${film.title}»',
  );
}
