import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../services/color_gen.dart';

/// Class Note barisikan catatan yang mungkin akan dilihat kembali
/// di masa yang akan datang.
class Note extends Equatable {
  Note({
    required this.title,
    required this.noteBody,
    DateTime? createDate,
    DateTime? modifiedDate,
    Color? background,
  })  : _background = (background ?? ColorGen.generate()) ?? Colors.white,
        _createDate = createDate ?? DateTime.now(),
        _modifiedDate = modifiedDate ?? DateTime.now();

  /// Judul note
  final String title;

  /// Isi note
  final String noteBody;

  // Tanggal dibuat: ini akan otomatis dibuat
  final DateTime _createDate;

  // Tanggal pembaruan: ini akan otomatis diperbarui
  final DateTime _modifiedDate;

  /// Warna background pada note ketika ditampilkan
  final Color _background;

  /// Getter untuk mengambil info tanggal dibuat
  DateTime get createDate => _createDate;

  /// Getter untuk mengambil info tanggal terakhi diperbarui
  DateTime get modifiedDate => _modifiedDate;

  /// Getter untuk mengambil info warna latar belakang
  Color get background => _background;

  Note copyWith(String? title, String? noteBody) {
    return Note(
      title: title ?? this.title,
      noteBody: noteBody ?? this.noteBody,
      createDate: createDate,
      background: background,
    );
  }

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      title: json['title'],
      noteBody: json['note_body'],
      createDate: DateTime.parse(json['create_date']),
      modifiedDate: DateTime.parse(json['modified_date']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'note_body': noteBody,
      'create_date': createDate.toString(),
      'modified_date': modifiedDate.toString(),
    };
  }

  @override
  List<Object?> get props =>
      [title, noteBody, _createDate, _modifiedDate, _background];
}
