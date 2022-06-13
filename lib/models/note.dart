import 'package:flutter/material.dart';

/// Class Note barisikan catatan yang mungkin akan dilihat kembali
/// di masa yang akan datang.
class Note {
  Note({
    required this.title,
    required this.noteBody,
    this.background = Colors.white,
  })  : _createDate = DateTime.now(),
        _modifiedDate = DateTime.now();

  /// Judul note
  String title;

  /// Isi note
  String noteBody;

  // Tanggal dibuat: ini akan otomatis dibuat
  final DateTime _createDate;

  // Tanggal pembaruan: ini akan otomatis diperbarui
  DateTime _modifiedDate;

  /// Warna background pada note ketika ditampilkan
  Color? background;

  /// Getter untuk mengambil info tanggal dibuat
  DateTime get createDate => _createDate;

  /// Getter untuk mengambil info tanggal terakhi diperbarui
  DateTime get modifiedDate => _modifiedDate;

  /// Funsi atau method untuk memperbarui note
  void updateNote({
    String? newTitle,
    String? newNoteBody,
    Color? newBackground,
  }) {
    if (newTitle != null) {
      title = newTitle;
      _modifiedDate = DateTime.now();
    }
    if (newNoteBody != null) {
      noteBody = newNoteBody;
      _modifiedDate = DateTime.now();
    }
    if (newBackground != null) {
      background = newBackground;
      _modifiedDate = DateTime.now();
    }
  }
}
