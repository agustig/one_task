import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../services/services.dart';

/// Class yang berisikan informasi pengguna
class User extends Equatable {
  User({
    String? id,
    required this.name,
    this.image,
    Color? background,
  })  :
        // Generate id
        _id = id ?? const Uuid().v1(),

        // Generate warna latar belakang jika argumen bakcground null
        _background =
            (background ?? ColorGen.generate(true)) ?? Colors.deepPurple;

  // ID
  final String _id;

  /// Getter untuk _id
  String get id => _id;

  /// Nama pengguna
  final String name;

  /// Photo profile pengguna
  final File? image;

  // Warna latar belakang
  final Color _background;

  /// Getter untuk _background
  Color get background => _background;

  /// Sample data user
  factory User.sampleUser() {
    return User(
      name: 'Guest',
    );
  }

  /// Membuat duplikasi pengguna dengan perubahan parameter isian
  User copyWith({String? id, String? name, File? image}) {
    if (this.image != null && image != null) {
      this.image!.deleteSync();
    }

    return User(
      id: id ?? _id,
      name: name ?? this.name,
      image: image ?? this.image,
      background: _background,
    );
  }

  /// Menghapus gambar pada user
  User removeImage() {
    image!.deleteSync();
    return User(
      id: _id,
      name: name,
      background: _background,
    );
  }

  /// Import data pengguna dari bentuk Json atau Map
  factory User.fromJson(Map<String, dynamic> json) {
    final String? imagePath = json['image'];
    return User(
      id: json['id'],
      name: json['name'],
      image: (imagePath != null) ? File(imagePath) : null,
    );
  }

  /// Export data pengguna ke dalam bentuk Json atau Map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': (image != null) ? image!.path : null,
    };
  }

  @override
  List<Object?> get props => [id, name, image];
}
