import 'package:du_an_cntt/utils.dart';
import 'package:du_an_cntt/view_models/search_vm.dart';
import 'package:du_an_cntt/widgets/flim_card_vertical.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../models/film_model.dart';
import '../../services/film_service.dart';
import '../../services/type_service.dart';class SearchScreenTablet extends StatefulWidget {
  const SearchScreenTablet({super.key});

  @override
  State<SearchScreenTablet> createState() => _SearchScreenTabletState();
}

class _SearchScreenTabletState extends State<SearchScreenTablet> {
  final TypeService typeService = TypeService();
  late Future<void> fetchTypes;
  late Future<void> fetchYears;

  late ScrollController searchingFilmController;

  @override
  void initState() {
    final searchViewModel = Provider.of<SearchViewModel>(context, listen: false);
    searchViewModel.reset();
    fetchTypes = searchViewModel.getAllTypes();
    fetchYears = searchViewModel.getYears();
    searchingFilmController = ScrollController()..addListener(searchingFilmsOnScroll);
    super.initState();
  }

  void searchingFilmsOnScroll() {
    final searchViewModel = Provider.of<SearchViewModel>(context, listen: false);
    if (searchingFilmController.position.pixels == searchingFilmController.position.maxScrollExtent && !searchViewModel.isLoading && searchViewModel.hasMore) {
      searchViewModel.searchMoreFilmsByTypeAndYear();
    }
  }
  @override
  Widget build(BuildContext context) {
    final heightBottomSheet = MediaQuery.of(context).size.height - AppBar().preferredSize.height;

    final widthScreen = MediaQuery.of(context).size.width;

    final heightScreen = MediaQuery.of(context).size.height
        - AppBar().preferredSize.height
        - MediaQuery.of(context).padding.top;

    final contentStyle = TextStyle(
        fontFamily: GoogleFonts.roboto().fontFamily,
        fontSize: 12.sp,
        color: Colors.white
    );

    final leadingTitle = TextStyle(
      fontSize: 16.sp,
      fontFamily: GoogleFonts.roboto().fontFamily,
      color: Colors.white
    );
    void showTypeBottomSheet(BuildContext context){
      final searchViewModel = Provider.of<SearchViewModel>(context, listen: false);
      final types = searchViewModel.types;

      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return Container(
            height: heightBottomSheet,
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16.0)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Thể loại",
                      style: contentStyle.copyWith(fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.close_outlined,
                        color: Colors.white,
                      ) ,
                    )
                  ],
                ),
                SizedBox(height: 20.h),
                Expanded(
                  child: ListView.separated(
                    separatorBuilder: (BuildContext context, int index) => SizedBox(
                      height: 10.h,
                    ),
                    itemCount: types.length,
                    itemBuilder: (BuildContext context, int index) => InkWell(
                      onTap: (){
                        final selectedType = types[index];
                        searchViewModel.searchFilmsByTypeAndYear(type: selectedType, year: searchViewModel.selectedYear);
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          types[index],
                          style: contentStyle.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    }
    void showYearBottomSheet(BuildContext context){
      final searchViewModel = Provider.of<SearchViewModel>(context, listen: false);
      final years = searchViewModel.years;

      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return Container(
            height: heightBottomSheet,
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16.0)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Năm",
                      style: contentStyle.copyWith(fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.close_outlined,
                        color: Colors.white,
                      ) ,
                    )
                  ],
                ),
                SizedBox(height: 20.h),
                Expanded(
                  child: ListView.separated(
                    separatorBuilder: (BuildContext context, int index) => const SizedBox(
                      height: 10,
                    ),
                    itemCount: years.length,
                    itemBuilder: (BuildContext context, int index) => InkWell(
                      onTap: (){
                        final selectedYear = years[index];
                        searchViewModel.searchFilmsByTypeAndYear(type: searchViewModel.selectedType, year: selectedYear);
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          years[index],
                          style: contentStyle.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 10.w,
        backgroundColor: Colors.black,
        title: Text("Tìm Kiếm", style: leadingTitle),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50.h),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 15.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.white,
                      width: 1.w
                    ),
                  ),
                  child: GestureDetector(
                    onTap: (){
                      showTypeBottomSheet(context);
                    },
                    child: Consumer<SearchViewModel>(
                      builder: (context, searchViewModel, child) {
                        return Text(
                          searchViewModel.selectedType ?? "Thể loại",
                          style: contentStyle,
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 15.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        color: Colors.white,
                        width: 1.w
                    ),
                  ),
                  child: GestureDetector(
                    onTap: (){
                      showYearBottomSheet(context);
                    },
                    child: Consumer<SearchViewModel>(
                      builder: (context, searchViewModel, child) {
                        return Text(
                          searchViewModel.selectedYear ?? "Năm",
                          style: contentStyle,
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.white, size: iconTabletSize),
            onPressed: () {
              showSearch(context: context, delegate: CustomSearchDelegate());
            },
          ),
        ],
      ),
      body: Consumer<SearchViewModel>(
        builder: (context, searchingViewModel, child) {
          if (searchingViewModel.isSearching) {
            return const Center(child: CircularProgressIndicator());
          } else if (searchingViewModel.films.isEmpty) {
            return Center(child: Text('Không tìm thấy phim', style: contentStyle,));
          }

          final films = searchingViewModel.films;
          return ListView.builder(
            controller: searchingFilmController,
            itemCount: films.length + (searchingViewModel.isLoading ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == films.length) {
                return Card(
                  color: Colors.transparent,
                  child: Row(
                    children: [
                      Container(
                        height: heightScreen * 0.25,
                        width: widthScreen*0.3,
                        color: Colors.grey[800],
                      ),
                      Expanded(child: CircularProgressIndicator())
                    ],
                  ),
                );
              }
              final film = films[index];
              return FilmCardVertical(
                height: heightScreen * 0.25,
                fontSize: 25,
                width: widthScreen*0.3,
                url: film.url,
                age: film.age,
                types: film.type.join(", "),
                name: film.name,
                des: film.description,
                ontap: (){
                  searchingViewModel.onTap(context, films[index]);
                },
              );
            },
          );
        },
      ),

    );
  }
}
class CustomSearchDelegate extends SearchDelegate {
  final FilmService filmService = FilmService();
  @override
  String get searchFieldLabel => "Tìm kiếm";

  CustomSearchDelegate() : super(
    searchFieldLabel: 'Tìm kiếm',
    searchFieldStyle: TextStyle(
      fontSize: 14.sp
    ),
  );

  final contentStyle = TextStyle(
      fontFamily: GoogleFonts.roboto().fontFamily,
      fontSize: 12.sp,
      color: Colors.white
  );

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear, size: iconTabletSize, color: Colors.black),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }
  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back, size: iconTabletSize, color: Colors.black),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return Center(child: Text('Vui lòng nhập tên', style: contentStyle,));
    }
    return FutureBuilder<List<FilmModel>>(
      future: filmService.searchFilmNamesByName(query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('Không có phim phù hợp', style: contentStyle));
        }
        final  searchVM = Provider.of<SearchViewModel>(context, listen: false);
        final films = snapshot.data!;
        return ListView.builder(
          itemCount: films.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(films[index].name, style: contentStyle),
              onTap: () {
                searchVM.onTap(context, films[index]);
                // query = films[index].name;
                // showResults(context);
              },
            );
          },
        );
      },
    );
  }
}
