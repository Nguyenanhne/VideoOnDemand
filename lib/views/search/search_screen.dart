import 'package:du_an_cntt/responsive.dart';
import 'package:du_an_cntt/views/search/search_mobile.dart';
import 'package:du_an_cntt/views/search/search_tablet.dart';
import 'package:du_an_cntt/views/search/search_web.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../view_models/search_vm.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late Future<void> fetchTypes;
  late Future<void> fetchYears;

  @override
  void initState() {
    final searchViewModel = Provider.of<SearchViewModel>(context, listen: false);
    searchViewModel.reset();
    fetchTypes = searchViewModel.getAllTypes();
    fetchYears = searchViewModel.getYears();
    // searchingFilmController = ScrollController()..addListener(searchingFilmsOnScroll);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileLayout: SearchScreenMobile(fetchTypes: fetchTypes, fetchYears: fetchYears),
      tabletLayout: SearchScreenTablet(),
      webLayout: SearchScreenWeb()
    );
  }
}