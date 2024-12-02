import 'package:flutter/material.dart';

class HomeViewModel extends ChangeNotifier{
  Color? _appBarColor = Colors.transparent;

  Color? get appBarColor => _appBarColor;

  void updateAppBarColor(double offset) {
    if (offset > 50) {
      _appBarColor = Color.fromRGBO(1,1,1, 0.8);
    } else {
      _appBarColor = Colors.transparent;
    }
    notifyListeners();
  }


  void onTapNavigateToScreen(BuildContext context, Widget targetScreen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => targetScreen),
    );
  }

}