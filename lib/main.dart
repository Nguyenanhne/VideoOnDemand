
import 'package:du_an_cntt/test.dart';
import 'package:du_an_cntt/view_models/email_verification_link_vm.dart';
import 'package:du_an_cntt/view_models/home_vm.dart';
import 'package:du_an_cntt/view_models/movie_card_vm.dart';
import 'package:du_an_cntt/view_models/movie_detail_vm.dart';
import 'package:du_an_cntt/view_models/my_netflix_vm.dart';
import 'package:du_an_cntt/view_models/sign_in_vm.dart';
import 'package:du_an_cntt/view_models/signup_vm.dart';
import 'package:du_an_cntt/view_models/video_vm.dart';
import 'package:du_an_cntt/views/bottom_navbar.dart';
import 'package:du_an_cntt/views/splash/splash_mobile.dart';
import 'package:flutter/material.dart';
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

  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => MyNetflixViewModel()),
          ChangeNotifierProvider(create: (_) => DetailedMovieViewModel()),
          ChangeNotifierProvider(create: (_) => HomeViewModel()),
          ChangeNotifierProvider(create: (_) => VideoViewModel()),
          ChangeNotifierProvider(create: (_) => SignUpViewModel()),
          ChangeNotifierProvider(create: (_) => SignInViewModel()),
          ChangeNotifierProvider(create: (_) => EmailVerificationLinkViewModel()),
          ChangeNotifierProvider(create: (_) => MovieCardViewModel())
        ],
        child: MyApp()
        ,
      )
  );
  // SystemChrome.setPreferredOrientations(
  //   [
  //     DeviceOrientation.portraitUp,
  //   ]
  // ).then((_){
  //   runApp(
  //       MultiProvider(
  //         providers: [
  //           ChangeNotifierProvider(create: (_) => MyNetflixViewModel()),
  //           ChangeNotifierProvider(create: (_) => DetailedMovieViewModel()),
  //           ChangeNotifierProvider(create: (_) => HomeViewModel()),
  //           ChangeNotifierProvider(create: (_) => VideoViewModel()),
  //           ChangeNotifierProvider(create: (_) => SignUpViewModel()),
  //           ChangeNotifierProvider(create: (_) => SignInViewModel()),
  //           ChangeNotifierProvider(create: (_) => EmailVerificationLinkViewModel()),
  //           ChangeNotifierProvider(create: (_) => MovieCardViewModel())
  //         ],
  //         child: MyApp()
  //         ,
  //       )
  //   );
  // });
}



class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<String?> checkLoginState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.getString("userId"));
    return prefs.getString('userId');
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (_,child){
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.black,
          ),
          home: FutureBuilder<String?>(
            future: checkLoginState(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasData && snapshot.data != null) {
                return BottomNavBar();
              } else {
                return SplashMobileScreen();
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

