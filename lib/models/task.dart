import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../services/color_gen.dart';

/// Class yang berisikan rincian task
class Task extends Equatable {
  Task({
    String? id,
    required this.title,
    required this.detail,
    required this.startTime,
    required this.endTime,
    this.isDone = false,
    Color? background,
  })  : _id = id ?? const Uuid().v1(),
        _background = (background ?? ColorGen.generate()) ?? Colors.white;

  // Id unik
  final String _id;

  /// Getter untuk id task
  String get id => _id;

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

  // Warna backgroud dari task
  final Color _background;

  /// Getter latar belakang
  Color get background => _background;

  /// Membuat duplikasi task dengan perubahan parameter isian
  Task copyWith({
    String? id,
    String? title,
    String? detail,
    DateTime? startTime,
    DateTime? endTime,
    bool? isDone,
    bool? isRemoved,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      detail: detail ?? this.detail,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      isDone: isDone ?? this.isDone,
      background: background,
    );
  }

  /// Import task dari bentuk Json atau Map
  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      title: json['title'],
      detail: json['detail'],
      startTime: DateTime.parse(json['start_time']),
      endTime: DateTime.parse(json['end_time']),
      isDone: json['is_done'],
    );
  }

  /// Export task ke dalam bentuk Json atau Map
  Map<String, dynamic> toJson() {
    return {
      'id': _id,
      'title': title,
      'detail': detail,
      'start_time': startTime.toString(),
      'end_time': endTime.toString(),
      'is_done': isDone,
    };
  }

  @override
  List<Object?> get props => [
        _id,
        title,
        detail,
        startTime,
        endTime,
        isDone,
        _background,
      ];
}
