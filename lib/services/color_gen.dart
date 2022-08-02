import 'dart:math';
import 'package:flutter/material.dart';

/// Generate warna secara acak
class ColorGen {
  /// Generate warna
  static Color? generate([bool isDark = false]) {
    final random = Random();

    return Colors.primaries[random.nextInt(Colors.primaries.length)]
        [(random.nextInt(4) * 100) + (isDark ? 600 : 100)];
  }
}
