class UserModel{
  String id;
  String fullName;
  String email;
  String role;
  UserModel({this.id = '', this.role = 'user', required this.fullName, required this.email});

  Map<String, dynamic> toMap() {
    return {
      'name': fullName,
      'email': email,
      'role': role
    };
  }
}