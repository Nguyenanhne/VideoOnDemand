import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
class DetailedMovieButton extends StatefulWidget {
  const DetailedMovieButton({super.key, required this.bgColor, required this.icon, required this.text, required this.textColor, required this.iconColor});
  final Color? bgColor;
  final IconData icon;
  final String text;
  final Color textColor;
  final Color iconColor;
  @override
  State<DetailedMovieButton> createState() => _DetailedMovieButtonState();
}

class _DetailedMovieButtonState extends State<DetailedMovieButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {  },
      icon: Icon(
        widget.icon,
        color: widget.iconColor,
        size: 25.sp,
      ),
      label: Text(
        widget.text,
        style: TextStyle(
          color: widget.textColor,
          fontFamily: GoogleFonts.roboto().fontFamily,
          fontSize: 14.sp,
          fontWeight: FontWeight.bold
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: widget.bgColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))
      ),
    );
  }
}
