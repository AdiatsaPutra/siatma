class User {
  final int id;
  final String name;
  final String password;
  final String createdAt;

  User({
    required this.id,
    required this.name,
    required this.password,
    required this.createdAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      password: json['password'],
      createdAt: json['createdAt'],
    );
  }
}
