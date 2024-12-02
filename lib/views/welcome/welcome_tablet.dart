import 'package:flutter/material.dart';
class WelcomeScreenTablet extends StatefulWidget {
  const WelcomeScreenTablet({super.key});

  @override
  State<WelcomeScreenTablet> createState() => _WelcomeScreenTablet();
}

class _WelcomeScreenTablet extends State<WelcomeScreenTablet> {
  @override
  Widget build(BuildContext context) {
    return Text("tablet");
  }
}
