import 'package:du_an_cntt/views/comment/comment_screen_mobile.dart';
import 'package:flutter/material.dart';

import 'comment_screen_tablet.dart';

class CommentScreen extends StatelessWidget {
  CommentScreen({super.key});
  final Widget mobileBody = CommentScreenMobile();
  final Widget tabletBody = CommentScreenTablet();
  final Widget webBody = CommentScreenTablet() ;

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