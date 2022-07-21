import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../services/color_gen.dart';

/// Class yang berisikan rincian task
class Task extends Equatable {
  Task({
    required this.title,
    required this.detail,
    required this.startTime,
    required this.endTime,
    this.isDone = false,
    Color? background,
  }) : _background = (background ?? ColorGen.generate()) ?? Colors.white;

  /// Judul dari task
  final String title;

  /// Isi dari task
  final String detail;

  /// Batas waktu awal task dikerjakan
  final DateTime startTime;

  /// Batas waktu task berakhir
  final DateTime endTime;

  /// Informasi apakah task sudah dikejakan
  final bool isDone;

  /// Warna backgroud dari task
  final Color _background;

  Color get background => _background;

  Task copyWith({
    String? title,
    String? detail,
    DateTime? startTime,
    DateTime? endTime,
    bool? isDone,
  }) {
    return Task(
      title: title ?? this.title,
      detail: detail ?? this.detail,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      isDone: isDone ?? this.isDone,
      background: background,
    );
  }

  @override
  List<Object?> get props => [
        title,
        detail,
        startTime,
        endTime,
        isDone,
        _background,
      ];

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      title: json['title'],
      detail: json['detail'],
      startTime: DateTime.parse(json['start_time']),
      endTime: DateTime.parse(json['end_time']),
      isDone: json['is_done'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'detail': detail,
      'start_time': startTime.toString(),
      'end_time': endTime.toString(),
      'is_done': isDone,
    };
  }
}
