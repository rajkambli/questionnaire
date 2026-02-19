class UserModel {
  final String? id;
  final String? createdAt;
  final String? name;
  final String? avatar;
  final String? phone;
  final String? password;

  UserModel({
    this.id,
    this.createdAt,
    this.name,
    this.avatar,
    this.phone,
    this.password,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      createdAt: json['createdAt'],
      name: json['name'],
      avatar: json['avatar'],
      phone: json['phone'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phone': phone,
      'password': password,
      'avatar': avatar,
    };
  }
}
