import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
class RatingProgressIndicator extends StatelessWidget {
  RatingProgressIndicator({
    super.key, required this.rating, required this.realValue,
  });
  final String rating;
  final double realValue;
  final TextStyle contentStyle = TextStyle(
    fontFamily: GoogleFonts.roboto().fontFamily,
    color: Colors.black
  );

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Text(
            rating,
            style: contentStyle.copyWith(fontSize: 13.sp),
          ),
        ),
        Expanded(
          child: SizedBox(
            child: LinearProgressIndicator(
              value: realValue,
              minHeight: 11,
              borderRadius: BorderRadius.circular(10),
              backgroundColor: Colors.grey,
              color: Colors.blueAccent,
            ),
          ),
        ),
      ],
    );
  }
}
