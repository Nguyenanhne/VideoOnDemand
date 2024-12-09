import 'package:flutter/material.dart';

import '../services/firebase_authentication.dart';

class SignUpViewModel extends ChangeNotifier{
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  late String? _message;
  String? get message => _message;
  final Auth firebaseAuth = Auth();

  void loading(bool status) {
    _isLoading = status;
    notifyListeners();
  }

  Future<String?> signUp(String email, String password, String fullName) async{
    _message = await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password, fullName: fullName);
    loading(true);
    return _message;
  }
}