import 'package:flutter/material.dart';
class SignInScreenTablet extends StatefulWidget {
  const SignInScreenTablet({super.key});

  @override
  State<SignInScreenTablet> createState() => _SignInScreenTabletState();
}

class _SignInScreenTabletState extends State<SignInScreenTablet> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text("Tablet")
              ],
            ),
          ),
        ),
      ),
    );;
  }
}
