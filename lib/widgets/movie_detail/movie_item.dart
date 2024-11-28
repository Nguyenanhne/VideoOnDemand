import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class MovieAlbum extends StatefulWidget {
  const MovieAlbum({super.key});

  @override
  State<MovieAlbum> createState() => _MovieAlbumState();
}

class _MovieAlbumState extends State<MovieAlbum> {

  final style = TextStyle(
    fontFamily: GoogleFonts.roboto().fontFamily
  );
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.black,
      // elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Thumbnail
              Container(
                width: 100,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: AssetImage("assets/top10.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              // Title and Subtitle
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "1. Bóng ma đường Baker",
                        style: style.copyWith(fontSize: 14.sp, color: Colors.white, fontWeight: FontWeight.bold),                      ),
                      SizedBox(height: 4.h),
                      Text(
                        "5 phút",
                        style: style.copyWith(fontSize: 13.sp, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),
              // Trailing Icon
              Icon(
                LineAwesomeIcons.download_solid,
                size: 30.sp,
                color: Colors.white,
              ),
            ],
          ),
          const SizedBox(height: 8),
          // Description
          Text(
            "Kẻ thù tấn công nhà chính trước phút 30, vui lòng trở về nhà trước 5h chiều.",
            style: style.copyWith(fontSize: 13.sp, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
