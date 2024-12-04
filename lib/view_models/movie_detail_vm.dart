import 'package:du_an_cntt/helper/navigator.dart';
import 'package:du_an_cntt/views/comment/comment_screen_mobile.dart';
import 'package:du_an_cntt/views/comment/comment_screen_tablet.dart';
import 'package:flutter/material.dart';

import '../views/comment/comment_screen.dart';

class DetailedMovieViewModel extends ChangeNotifier {

  void likeListOntap(BuildContext context, int index){
    switch (index){
      case 0:
        print("Danh sach");
      case 1:
        print("Danh gia");
      case 2:
        print("Chia se");
      case 3:
        NavigatorHelper.navigateTo(context, CommentScreen());
    }
  }
}