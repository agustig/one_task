import 'package:flutter/material.dart';

/// Class yang berisikan rincian task
class Task {
  Task({
    required this.title,
    required this.detail,
    required this.place,
    required this.startTime,
    required this.endTime,
    this.isDone = false,
    this.background = Colors.white,
  });

  /// Judul dari task
  String title;

  /// Isi dari task
  String detail;

  /// Tempat dimana taks dikerjakan
  String place;

  /// Batas waktu awal task dikerjakan
  DateTime startTime;

  /// Batas waktu task berakhir
  DateTime endTime;

  /// Informasi apakah task sudah dikejakan
  bool isDone;

  /// Warna backgroud dari task
  Color? background;
}
