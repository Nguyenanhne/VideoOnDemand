import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class MainPoster extends StatefulWidget {
  const MainPoster({super.key});

  @override
  State<MainPoster> createState() => _MainPosterState();
}

class _MainPosterState extends State<MainPoster> {
  List<String> listSub = ["Máu me", "Kinh dị", "Xác sống", "Hàn Quốc", "18+"];
  var style = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 14.sp,
    fontFamily: GoogleFonts.roboto().fontFamily
  );
  var borderRadius = 20.0;
  var blur = 1.0;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        side: BorderSide(color: Colors.white, width: 1),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset("assets/home_poster.jpg", fit: BoxFit.fill),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(20), bottomLeft: Radius.circular(20)),
                ),
                child: ClipRRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
                    child: Padding(
                      padding: EdgeInsets.only(left: 15, right: 15, bottom: 15, top: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: TextButton.icon(
                              onPressed: () {},
                              icon: const Icon(Icons.play_arrow, color: Colors.black),
                              label: Text(
                                "Phát",
                                style: style.copyWith(color: Colors.black),
                              ),
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(Colors.white),
                                foregroundColor: MaterialStateProperty.all(Colors.white),
                                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                )),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Expanded(
                            child: TextButton.icon(
                              onPressed: () {},
                              icon: const Icon(Icons.add, color: Colors.white),
                              label: Text(
                                "Danh sách",
                                style: style
                              ),
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(Colors.grey[600]),
                                foregroundColor: MaterialStateProperty.all(Colors.white),
                                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  ))
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
