
import 'package:du_an_cntt/helper/navigator.dart';
import 'package:du_an_cntt/view_models/email_verification_link_vm.dart';
import 'package:du_an_cntt/view_models/film_detail_vm.dart';
import 'package:du_an_cntt/view_models/film_watched_card_vm.dart';
import 'package:du_an_cntt/view_models/home_vm.dart';
import 'package:du_an_cntt/view_models/main_poster_vm.dart';
import 'package:du_an_cntt/view_models/my_list_film_vm.dart';
import 'package:du_an_cntt/view_models/rating_vm.dart';
import 'package:du_an_cntt/view_models/resume_vm.dart';
import 'package:du_an_cntt/view_models/search_vm.dart';
import 'package:du_an_cntt/view_models/showing_film_card_vm.dart';
import 'package:du_an_cntt/view_models/my_netflix_vm.dart';
import 'package:du_an_cntt/view_models/sign_in_vm.dart';
import 'package:du_an_cntt/view_models/signup_vm.dart';
import 'package:du_an_cntt/view_models/video_vm.dart';
import 'package:du_an_cntt/views/bottom_navbar.dart';
import 'package:du_an_cntt/views/detailed%20film/detailed_film_screen.dart';
import 'package:du_an_cntt/views/home/home_screen.dart';
import 'package:du_an_cntt/views/splash/splash_mobile.dart';
import 'package:du_an_cntt/views/splash/splash_screen.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseAppCheck.instance.activate(
    androidProvider: AndroidProvider.debug,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MyNetflixViewModel()),
        ChangeNotifierProvider(create: (_) => DetailedFilmViewModel()),
        ChangeNotifierProvider(create: (_) => HomeViewModel()),
        ChangeNotifierProvider(create: (_) => VideoViewModel()),
        ChangeNotifierProvider(create: (_) => SignUpViewModel()),
        ChangeNotifierProvider(create: (_) => SignInViewModel()),
        ChangeNotifierProvider(create: (_) => EmailVerificationLinkViewModel()),
        ChangeNotifierProvider(create: (_) => ShowingFilmsCardViewModel()),
        ChangeNotifierProvider(create: (_) => MyListFilmViewModel()),
        ChangeNotifierProvider(create: (_) => SearchViewModel()),
        ChangeNotifierProvider(create: (_) => RatingViewModel()),
        ChangeNotifierProvider(create: (_) => MainPosterViewModel()),
        ChangeNotifierProvider(create: (_) => FilmWatchedCardViewModel()),
        ChangeNotifierProvider(create: (_) => ResumeViewModel())
      ],
      builder: (context, child){
        return MyApp();
      }
    )
  );
}



class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<User?> checkLogin;
  Future<User?> checkLoginState() async {
    return FirebaseAuth.instance.currentUser;
  }
  @override
  void initState() {
    checkLogin = checkLoginState();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (_,child){
        // Lấy kích thước màn hình và kiểm tra chế độ
        // final size = MediaQuery.of(context).size;
        // final isTablet = size.shortestSide >= 600;
        // if (!isTablet) {
        //   SystemChrome.setPreferredOrientations([
        //     DeviceOrientation.portraitUp,
        //   ]);
        // } else {
        //   SystemChrome.setPreferredOrientations([
        //     DeviceOrientation.portraitUp,
        //     DeviceOrientation.landscapeLeft,
        //     DeviceOrientation.landscapeRight,
        //   ]);
        // }
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.black
          ),
          // home: HomeScreen(),
          home: FutureBuilder(
            future: checkLogin,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasData && snapshot.data != null) {
                return BottomNavBar();
                // return DetailedFilmScreen(filmID: "10iPJ4Jh5omsZofD2kXW");
              } else {
                return SplashMobileScreen();
              }
            },
          ),
        );
      },
    );
  }
}

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        child: Container(
          color: Colors.red,
          height: 100,
        ),
        onTap: (){
          // NavigatorHelper.navigateTo(context, DetailedFilmScreen(filmID: "10iPJ4Jh5omsZofD2kXW"));
        },
      ),
    );
  }
}

