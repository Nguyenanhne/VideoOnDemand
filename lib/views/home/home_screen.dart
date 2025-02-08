import 'package:du_an_cntt/views/home/home_mobile.dart';
import 'package:du_an_cntt/views/home/home_tablet.dart';
import 'package:du_an_cntt/views/home/home_web.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../responsive.dart';
import '../../view_models/home_vm.dart';
import '../../view_models/main_poster_vm.dart';
import '../../view_models/showing_film_card_vm.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<void> fetchShowing;
  late Future<void> getAllTypes;
  late Future<void> fetchFilmsByType;
  late Future<void> fetchMainPoster;
  @override
  void initState() {
    super.initState();

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    final showingFilmsViewModel = Provider.of<ShowingFilmsCardViewModel>(context, listen: false);

    final mainPosterViewModel = Provider.of<MainPosterViewModel>(context, listen: false);

    final homeViewModel = Provider.of<HomeViewModel>(context, listen: false);

    fetchShowing = showingFilmsViewModel.fetchFilms();
    fetchMainPoster = mainPosterViewModel.fetchRandomFilm();
    getAllTypes = homeViewModel.getAllTypes();
    getAllTypes.then((_){
      fetchFilmsByType = homeViewModel.searchFilmsByAllTypes();
    });

  }
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
        mobileLayout: HomeScreenMobile(fetchShowing: fetchShowing, getAllTypes: getAllTypes, fetchMainPoster: fetchMainPoster),
        tabletLayout: HomeScreenTablet(fetchShowing: fetchShowing, getAllTypes: getAllTypes, fetchMainPoster: fetchMainPoster),
        webLayout: HomeScreenWeb(fetchShowing: fetchShowing, getAllTypes: getAllTypes, fetchMainPoster: fetchMainPoster)
    );
  }
}