import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:du_an_cntt/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/film_model.dart';
class UserService{
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<String?> createUser(String email, String fullName, uid) async {
    UserModel user = UserModel(fullName: fullName, email: email, id: uid);
    try{
      await firestore.collection("User").doc(uid).set(user.toMap());
      return ("Thêm vô database User thành công với id: $uid");
    }
    catch(e){
      print("Lỗi đăng ký: $e");
      return null;
    }
  }
}