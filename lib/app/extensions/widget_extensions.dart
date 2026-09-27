import 'package:flutter/widgets.dart';

/// Короткие записи для пустых отступов по высоте и ширине.
extension EmptyPadding on num {
  /// Вертикальный отступ: например, `16.ph`.
  SizedBox get ph => SizedBox(height: toDouble());

  /// Горизонтальный отступ: например, `12.pw`.
  SizedBox get pw => SizedBox(width: toDouble());
}
