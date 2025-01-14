import 'dart:developer';

import 'package:du_an_cntt/services/UserService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<String?> createUserWithEmailAndPassword({required String email, required String password, required fullName}) async {
    try {
       UserCredential userCredential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;
      String uid = user!.uid;

      if (user != null) {
        UserService userService = UserService();
        await userService.createUser(email, fullName, uid);

        // Gửi email xác thực sau khi người dùng đăng ký thành công
        await sendEmailVerificationLink();
        return 'Đăng ký thành công! Email xác thực đã được gửi đến ${user.email}.';
      } else {
        return 'Đăng ký thất bại! Không thể tạo người dùng.';
      }
      return "Success";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      } else {
        return e.message;
      }
    } catch (e) {
      return e.toString();
    }
  }


  Future<String?> sendEmailVerificationLink() async{

    try {
      // Gửi email xác thực
      await firebaseAuth.currentUser?.sendEmailVerification();
      print("Đã gửi email xác thực đến: ${firebaseAuth.currentUser?.email}");
    } catch (e) {
      // Xử lý lỗi nếu có
      print("Lỗi khi gửi email xác thực: $e");
    }
  }

  Future<bool> isEmailVerified() async{
    if(firebaseAuth.currentUser?.emailVerified == true){
      return true;
    }
    return false;
  }

  Future<User?> signInUserWithEmailAndPassword({required String email, required String password}) async {
    try {
      final cred = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('userId', cred.user!.uid);

      return cred.user;
    } on FirebaseAuthException catch (e) {
      log("Tên đăng nhập hoặc mật khẩu không hợp lệ");
    }
  }
  Future<void> signOut()async {
    try{
      await FirebaseAuth.instance.signOut();

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.clear();

      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        print("User logged out successfully.");
      } else {
        print("Logout failed. User is still logged in.");
      }
    }
    catch (e){
      print(e);
    }
  }
  Future<void> sendPasswordResetEmail(String email) async{
    try{
      await firebaseAuth.sendPasswordResetEmail(email: email);
      print("Đã gửi link reset password xác thực đến: ${email}");
    }
    catch (e){
      print(e);
    }
  }
  Future<String> getUserID() async {
    try {
      User? user = firebaseAuth.currentUser;
      if (user != null) {
        return user.uid;
      } else {
        throw Exception('User is not logged in');
      }
    } catch (e) {
      print("Error fetching user ID: $e");
      rethrow;
    }
  }
}