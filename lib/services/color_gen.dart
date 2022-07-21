import 'dart:math';
import 'package:flutter/material.dart';

class ColorGen {
  static Color? generate() {
    final random = Random();

    return Colors.primaries[random.nextInt(Colors.primaries.length)]
        [(random.nextInt(5) * 100) + 100];
  }
}
