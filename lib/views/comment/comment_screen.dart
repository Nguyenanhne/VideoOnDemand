import 'package:du_an_cntt/responsive.dart';
import 'package:du_an_cntt/views/comment/comment_screen_mobile.dart';
import 'package:flutter/material.dart';

import 'comment_screen_tablet.dart';

class CommentScreen extends StatelessWidget {
  final String filmID;
  CommentScreen({super.key, required this.filmID});
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(mobileLayout: CommentScreenMobile(filmID: filmID), tabletLayout: CommentScreenTablet(filmID: filmID), webLayout: CommentScreenTablet(filmID: filmID));
  }
}