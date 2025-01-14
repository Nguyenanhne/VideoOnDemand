
import 'package:du_an_cntt/helper/navigator.dart';
import 'package:du_an_cntt/test.dart';
import 'package:du_an_cntt/video.dart';
import 'package:du_an_cntt/view_models/comment_vm.dart';
import 'package:du_an_cntt/view_models/email_verification_link_vm.dart';
import 'package:du_an_cntt/view_models/film_detail_vm.dart';
import 'package:du_an_cntt/view_models/home_vm.dart';
import 'package:du_an_cntt/view_models/main_poster_vm.dart';
import 'package:du_an_cntt/view_models/my_list_film_vm.dart';
import 'package:du_an_cntt/view_models/search_vm.dart';
import 'package:du_an_cntt/view_models/up_coming_film_card_vm.dart';
import 'package:du_an_cntt/view_models/my_netflix_vm.dart';
import 'package:du_an_cntt/view_models/sign_in_vm.dart';
import 'package:du_an_cntt/view_models/signup_vm.dart';
import 'package:du_an_cntt/view_models/video_vm.dart';
import 'package:du_an_cntt/views/detailed%20film/detailed_film_screen.dart';
import 'package:du_an_cntt/views/welcome/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
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
        ChangeNotifierProvider(create: (_) => UpComingFilmsCardViewModel()),
        ChangeNotifierProvider(create: (_) => MyListFilmViewModel()),
        ChangeNotifierProvider(create: (_) => SearchViewModel()),
        ChangeNotifierProvider(create: (_) => CommentViewModel()),
        ChangeNotifierProvider(create: (_) => MainPosterViewModel())
      ],
      child: MyApp(),
    )
  );
}



class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  Future<User?> checkLoginState() async {
    return FirebaseAuth.instance.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (_,child){
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.black
          ),
          home: FutureBuilder(
            future: checkLoginState(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasData && snapshot.data != null) {
                return Test();
                return DetailedFilmScreen(filmID: "10iPJ4Jh5omsZofD2kXW");
                // return CommentScreen(filmID: "10iPJ4Jh5omsZofD2kXW");
              } else {
                return WelcomeScreen();
              }
            },
          ),          // initialRoute: "/",
          // routes: {
          //   "/SignInScreen": (context) => SignInScreen(),
          //   "/HomeScreen": (context) => HomeScreenMobile(),
          //   "/SignUpScreen": (context) => SignUpScreenMobile(),
          //   "/EmailVerificationLinkScreen": (context) => EmailVerificationLinkMobile(),
          //   "/ForgotPasswordScreen": (context) => ForgotPasswordMobile(),
          //   "/SplashScreen": (context) => SplashMobileScreen(),
          // }
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
          NavigatorHelper.navigateTo(context, DetailedFilmScreen(filmID: "10iPJ4Jh5omsZofD2kXW"));
        },
      ),
    );
  }
}

