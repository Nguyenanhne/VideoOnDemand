import 'package:flutter/material.dart';
import '../../responsive.dart';
import 'email_verification_link_mobile.dart';
import 'email_verification_link_tablet.dart';

class EmailVerificationLink extends StatelessWidget {
  const EmailVerificationLink({super.key});
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileLayout: EmailVerificationLinkMobile(),
      tabletLayout: EmailVerificationLinkScreenTablet(),
      webLayout: EmailVerificationLinkScreenTablet()
    );
  }
}