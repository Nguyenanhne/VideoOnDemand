
import 'package:du_an_cntt/helper/navigator.dart';
import 'package:du_an_cntt/view_models/change_password_vm.dart';
import 'package:du_an_cntt/view_models/comment_vm.dart';
import 'package:du_an_cntt/view_models/email_verification_link_vm.dart';
import 'package:du_an_cntt/view_models/film_detail_vm.dart';
import 'package:du_an_cntt/view_models/film_watched_card_vm.dart';
import 'package:du_an_cntt/view_models/forgot_password_vm.dart';
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
import 'package:du_an_cntt/view_models/splash_vm.dart';
import 'package:du_an_cntt/view_models/video_vm.dart';
import 'package:du_an_cntt/views/splash/splash_screen.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'services/firebase_options.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,

  );
  FirebaseAuth.instance.setLanguageCode('vi');
  await FirebaseAppCheck.instance.activate(
    androidProvider: AndroidProvider.debug,
  );
  // SystemChrome.setPreferredOrientations([]);
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SplashViewModel()),
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
        ChangeNotifierProvider(create: (_) => ResumeViewModel()),
        ChangeNotifierProvider(create: (_) => ForgotPasswordViewModel()),
        ChangeNotifierProvider(create: (_) => CommentViewModel()),
        ChangeNotifierProvider(create: (_) => ChangePasswordViewModel())
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
  @override
  void initState() {
    super.initState();
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
          // home: HomeScreen(),
          home: SplashScreen()
        );
      },
    );
  }
}
