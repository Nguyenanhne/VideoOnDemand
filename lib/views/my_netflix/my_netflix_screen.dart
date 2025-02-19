import 'package:du_an_cntt/views/responsive.dart';
import 'package:du_an_cntt/views/my_netflix/my_netflix_web.dart';
import 'package:du_an_cntt/views/sign_up/sign_up_mobile.dart';
import 'package:du_an_cntt/views/sign_up/sign_up_tablet.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../view_models/film_watched_card_vm.dart';
import '../../view_models/my_list_film_vm.dart';
import 'my_netflix_mobile.dart';
import 'my_netflix_tablet.dart';

class MyNetflixScreen extends StatefulWidget {
  const MyNetflixScreen({super.key});

  @override
  State<MyNetflixScreen> createState() => _MyNetflixScreenState();
}

class _MyNetflixScreenState extends State<MyNetflixScreen> {
  late Future<void> fetchMyList;
  late Future<void> fetchFilmWatched;
  @override
  void initState() {
    super.initState();
      final myListFilmsViewModel = Provider.of<MyListFilmViewModel>(context, listen: false);
      final myFilmWatched = Provider.of<FilmWatchedCardViewModel>(context, listen: false);

      fetchMyList = myListFilmsViewModel.fetchMyList();
      fetchFilmWatched = myFilmWatched.fetchMyListFilmWatched();
  }
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileLayout: MyNetflixScreenMobile(fetchMyList: fetchMyList, fetchFilmWatched: fetchFilmWatched),
      webLayout: MyNetflixScreenWeb(fetchMyList: fetchMyList, fetchFilmWatched: fetchFilmWatched),
      tabletLayout: MyNetflixScreenTablet(fetchMyList: fetchMyList, fetchFilmWatched: fetchFilmWatched)
    );
  }
}