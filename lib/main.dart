
import 'package:du_an_cntt/view_models/email_verification_link_vm.dart';
import 'package:du_an_cntt/view_models/home_vm.dart';
import 'package:du_an_cntt/view_models/movie_card_vm.dart';
import 'package:du_an_cntt/view_models/movie_detail_vm.dart';
import 'package:du_an_cntt/view_models/my_netflix_vm.dart';
import 'package:du_an_cntt/view_models/sign_in_vm.dart';
import 'package:du_an_cntt/view_models/signup_vm.dart';
import 'package:du_an_cntt/view_models/video_vm.dart';
import 'package:du_an_cntt/views/detailed%20movie/detailed_movie_screen.dart';
import 'package:du_an_cntt/views/video.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
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

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (_,child){
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.black,
          ),
          home: VideoMobileScreen(),
          // initialRoute: "/",
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

