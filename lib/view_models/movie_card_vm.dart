import 'package:du_an_cntt/helper/navigator.dart';
import 'package:du_an_cntt/views/detailed%20movie/detailed_movie_screen.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

class MovieCardViewModel extends ChangeNotifier{
  void onTap(BuildContext context){
    NavigatorHelper.navigateTo(context, DetailedMovieScreen());
  }
  final storage = FirebaseStorage.instance;

  Future<String> getImageUrl(String id) async {
    print(id);
    final ref = storage.ref().child('Poster/$id.jpg');

    return await ref.getDownloadURL();
  }
}