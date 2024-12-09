import 'package:du_an_cntt/views/email_verification_link/email_verification_link_mobile.dart';
import 'package:du_an_cntt/views/email_verification_link/email_verification_link_tablet.dart';
import 'package:flutter/material.dart';

class EmailVerificationLink extends StatelessWidget {
  EmailVerificationLink({super.key});
  final Widget mobileBody= EmailVerificationLinkMobile();
  final Widget tabletBody= EmailVerificationLinkScreenTablet();
  final Widget webBody = EmailVerificationLinkScreenTablet();

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