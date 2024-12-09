import 'package:du_an_cntt/view_models/email_verification_link_vm.dart';
import 'package:du_an_cntt/view_models/home_vm.dart';
import 'package:du_an_cntt/view_models/movie_card_vm.dart';
import 'package:du_an_cntt/view_models/movie_detail_vm.dart';
import 'package:du_an_cntt/view_models/sign_in_vm.dart';
import 'package:du_an_cntt/view_models/signup_vm.dart';
import 'package:du_an_cntt/view_models/video_vm.dart';
import 'package:du_an_cntt/views/bottom_navbar.dart';
import 'package:du_an_cntt/views/email_verification_link/email_verification_link_screen.dart';
import 'package:du_an_cntt/views/login/sign_in_screen.dart';
import 'package:du_an_cntt/views/sign_up/sign_up_screen.dart';
import 'package:du_an_cntt/views/splash/splash_mobile.dart';
import 'package:du_an_cntt/views/splash/splash_screen.dart';
import 'package:du_an_cntt/views/video.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp
    ]
  ).then((_){
    runApp(
        MultiProvider(
          providers: [
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
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (_,child){
        return MaterialApp(
          title: 'Du An CNTT',
          debugShowCheckedModeBanner: false,
          themeMode: ThemeMode.dark,
          theme: ThemeData(
            textTheme: const TextTheme(
              bodyLarge: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
              bodyMedium: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            fontFamily: GoogleFonts.ptSans().fontFamily,
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)
                .copyWith(background: Colors.black),
          ),
          home: BottomNavBar(),
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

