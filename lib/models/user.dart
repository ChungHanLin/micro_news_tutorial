class UserModel {
  final String name;
  final String email;
  final String avatar;
  final String description;

  UserModel({
    required this.name,
    required this.email,
    required this.avatar,
    required this.description,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      email: json['email'],
      avatar: json['avatar'],
      description: json['description'],
    );
  }
}
