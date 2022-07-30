import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../services/color_gen.dart';

/// Class Note barisikan catatan yang mungkin akan dilihat kembali
/// di masa yang akan datang.
class Note extends Equatable {
  Note({
    String? id,
    required this.title,
    required this.noteBody,
    DateTime? createDate,
    DateTime? modifiedDate,
    this.isRemoved = false,
    Color? background,
  })  : _id = id ?? const Uuid().v1(),
        _background = (background ?? ColorGen.generate()) ?? Colors.white,
        _createDate = createDate ?? DateTime.now(),
        _modifiedDate = modifiedDate ?? DateTime.now();

  // Id unik
  final String _id;

  /// Getter untuk id note
  String get id => _id;

  /// Judul note
  final String title;

  /// Isi note
  final String noteBody;

  // Tanggal dibuat: ini akan otomatis dibuat
  final DateTime _createDate;

  // Tanggal pembaruan: ini akan otomatis diperbarui
  final DateTime _modifiedDate;

  /// Penanda apakah note sudah di-remove
  final bool isRemoved;

  /// Warna background pada note ketika ditampilkan
  final Color _background;

  /// Getter untuk mengambil info tanggal dibuat
  DateTime get createDate => _createDate;

  /// Getter untuk mengambil info tanggal terakhi diperbarui
  DateTime get modifiedDate => _modifiedDate;

  /// Getter untuk mengambil info warna latar belakang
  Color get background => _background;

  /// Membuat duplikasi note dengan perubahan parameter isian
  Note copyWith({
    String? id,
    String? title,
    String? noteBody,
    bool? isRemoved,
    DateTime? createDate,
    DateTime? modifiedDate,
    Color? background,
  }) {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      noteBody: noteBody ?? this.noteBody,
      isRemoved: isRemoved ?? this.isRemoved,
      createDate: createDate ?? this.createDate,
      modifiedDate: modifiedDate ?? this.modifiedDate,
      background: background ?? this.background,
    );
  }

  /// Import note dari bentuk Json atau Map
  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      id: json['id'],
      title: json['title'],
      noteBody: json['note_body'],
      isRemoved: json['is_removed'],
      createDate: DateTime.parse(json['create_date']),
      modifiedDate: DateTime.parse(json['modified_date']),
    );
  }

  /// Export note ke dalam bentuk Json atau Map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'note_body': noteBody,
      'is_removed': isRemoved,
      'create_date': createDate.toString(),
      'modified_date': modifiedDate.toString(),
    };
  }

  @override
  List<Object?> get props => [
        id,
        title,
        noteBody,
        _createDate,
        _modifiedDate,
        isRemoved,
      ];
}
