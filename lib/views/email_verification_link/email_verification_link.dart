import 'package:flutter/material.dart';

class EmailVerificationLink extends StatelessWidget {
  const EmailVerificationLink({super.key, required this.mobileBody, required this.tabletBody, required this.webBody});
  final Widget mobileBody;
  final Widget tabletBody;
  final Widget webBody;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 500) {
            return mobileBody;
          } else if (constraints.maxWidth < 1100) {
            return tabletBody;
          } else {
            return webBody;
          }
        }
    );
  }
}