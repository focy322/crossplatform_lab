import 'package:flutter/material.dart';

import '../models/film.dart';

/// Тестовые данные, из которых строится каталог на главном экране.
const films = <Film>[
  Film(
    title: 'Солярис',
    year: '1972',
    description: 'Психологическая фантастика Андрея Тарковского.',
    color: Color(0xFF25435C),
    symbol: Icons.public_rounded,
  ),
  Film(
    title: 'Сталкер',
    year: '1979',
    description: 'Путешествие проводника и его спутников в загадочную Зону.',
    color: Color(0xFF5E6B3D),
    symbol: Icons.explore_rounded,
  ),
  Film(
    title: 'Девчата',
    year: '1961',
    description: 'Лёгкая комедия о новой жизни в таёжном посёлке.',
    color: Color(0xFFAB5962),
    symbol: Icons.local_florist_rounded,
  ),
  Film(
    title: 'Кин дза дза',
    year: '1986',
    description:
        'Сатирическая фантастика о случайном межпланетном путешествии.',
    color: Color(0xFFC48139),
    symbol: Icons.rocket_launch_rounded,
  ),
  Film(
    title: 'Человек амфибия',
    year: '1961',
    description: 'Приключенческая история о герое, способном жить под водой.',
    color: Color(0xFF287C92),
    symbol: Icons.water_rounded,
  ),
];
