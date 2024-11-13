import 'dart:async';
import 'package:du_an_cntt/views/welcome/welcome_mobile.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../widgets/bottom_navbar.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 3), (){
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => WelcomeScreenMobile()));
      }
    );
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset(
        "assets/netflix.json",
      ),
    );
  }
}
