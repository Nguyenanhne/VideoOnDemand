import 'dart:async';
import 'package:du_an_cntt/views/welcome/welcome_mobile.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../bottom_navbar.dart';
class SplashMobileScreen extends StatefulWidget {
  const SplashMobileScreen({super.key});

  @override
  State<SplashMobileScreen> createState() => _SplashMobileScreenState();
}

class _SplashMobileScreenState extends State<SplashMobileScreen> {
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
