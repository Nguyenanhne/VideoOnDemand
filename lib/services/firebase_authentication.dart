import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:du_an_cntt/services/user_service.dart';
import 'package:du_an_cntt/utils/utils.dart';
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
    return null;
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
      return cred.user;
    } on FirebaseAuthException catch (e) {
      log("Tên đăng nhập hoặc mật khẩu không hợp lệ");
    }
    return null;
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

  Future<bool> sendTokenToServer() async {
    try {
      // Lấy Firebase ID Token
      User? user = FirebaseAuth.instance.currentUser;
      String? idToken = await user?.getIdToken();
      print("Tiến hành xác thực");
      print("ID Token : $idToken");
      if (idToken == null) {
        print("Không có token để gửi");
        return false;
      }

      // URL của API server (thay bằng URL của bạn)
      String url = urlVerifyToken1;

      // Gửi yêu cầu HTTP POST với token trong header Authorization
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $idToken',
        },
      );
      // Kiểm tra kết quả từ server
      if (response.statusCode == 200) {
        print('Token hợp lệ. Dữ liệu đã được gửi thành công!');
        return true;
      } else {
        print('Lỗi: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Có lỗi xảy ra: $e');
      return false;
    }
  }
}