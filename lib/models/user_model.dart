class UserModel{
  String id;
  String fullName;
  String email;
  UserModel({this.id = '', required this.fullName, required this.email});

  Map<String, dynamic> toMap() {
    return {
      'name': fullName,
      'email': email,
    };
  }
  factory UserModel.fromMap(Map<String, dynamic> map, String id) {
    return UserModel(
      id: id,
      fullName: map['fullName'],
      email: map['email'],
    );
  }
}