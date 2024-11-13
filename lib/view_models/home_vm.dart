import 'package:flutter/material.dart';

class HomeViewModel extends ChangeNotifier{

  void onTapNavigateToScreen(BuildContext context, Widget targetScreen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => targetScreen),
    );
  }

}