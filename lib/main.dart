import 'package:du_an_cntt/views/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
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
          home: const SplashScreen(),
        );
      },
    );
  }
}

