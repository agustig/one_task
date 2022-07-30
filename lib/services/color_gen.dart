import 'dart:math';
import 'package:flutter/material.dart';

/// Generate warna secara acak
class ColorGen {
  /// Generate warna
  static Color? generate() {
    final random = Random();

    return Colors.primaries[random.nextInt(Colors.primaries.length)]
        [(random.nextInt(5) * 100) + 100];
  }
}
