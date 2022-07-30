import 'package:equatable/equatable.dart';

/// Class yang berisikan informasi pengguna
class User extends Equatable {
  const User({required this.name, required this.image});

  /// Nama pengguna
  final String name;

  /// Photo profile pengguna
  final String image;

  factory User.sampleUser() {
    return const User(
      name: 'Agusti Gunawan',
      image: 'images/20210125_182525.jpg',
    );
  }

  /// Membuat duplikasi pengguna dengan perubahan parameter isian
  User copyWith({String? name, String? image}) {
    return User(
      name: name ?? this.name,
      image: image ?? this.image,
    );
  }

  /// Import data pengguna dari bentuk Json atau Map
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      image: json['image'],
    );
  }

  /// Export data pengguna ke dalam bentuk Json atau Map
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'image': image,
    };
  }

  @override
  List<Object?> get props => [name, image];
}
