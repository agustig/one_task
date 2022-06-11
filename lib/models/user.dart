/// Class yang berisikan informasi pengguna
class User {
  User({required this.name, required this.image});

  /// Nama pengguna
  String name;

  /// Photo profile pengguna
  String image;
}

final agusti = User(
  name: 'Agusti Gunawan',
  image: 'images/20210125_182525.jpg',
);
