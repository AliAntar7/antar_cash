class UserModel {
  final String email;
  final String name;
  final String phone;
  final String password;
  final String uId;

  UserModel({
    required this.email,
    required this.name,
    required this.phone,
    required this.password,
    required this.uId,
  });

  factory UserModel.fromJson(Map<String, dynamic>jsonData) {
    return UserModel(
      email: jsonData['email'],
      name: jsonData['name'],
      password: jsonData['password'],
      phone: jsonData['phone'],
      uId: jsonData['uid'],
    );
  }
}