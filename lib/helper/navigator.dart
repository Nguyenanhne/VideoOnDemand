import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavigatorHelper {
  // Navigate to a new screen
  static Future<void> navigateTo(BuildContext context, Widget screen) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  // Replace the current screen with a new screen
  static Future<void> replaceWith(BuildContext context, Widget screen) async {
    await Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  // Pop the current screen and go back to the previous one
  static void goBack(BuildContext context)  {
     Navigator.pop(context);
  }

  // Navigate to a new screen and remove all previous screens
  static Future<void> navigateAndRemoveUntil(BuildContext context, Widget screen) async {
    await Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => screen),
          (Route<dynamic> route) => false, // Remove all previous screens
    );
  }
}
