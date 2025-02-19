import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../video.dart';
import '../../view_models/resume_vm.dart';
class MyResumeScreenTablet extends StatefulWidget {
  final String filmID;
  final Future<void> getLastVideoPosition;
  const MyResumeScreenTablet({super.key, required this.filmID, required this.getLastVideoPosition});
  @override
  State<MyResumeScreenTablet> createState() => _MyResumeScreenTabletState();
}

class _MyResumeScreenTabletState extends State<MyResumeScreenTablet> {
  final contentStyle = TextStyle(
    fontFamily: GoogleFonts.roboto().fontFamily,
    fontSize: 14.sp,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<void>(
          future: widget.getLastVideoPosition,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            if (snapshot.hasError) {
              return Text("Lỗi: ${snapshot.error}");
            }
            return Consumer<ResumeViewModel>(
                builder: (context, resumeVM, child) {
                  return AlertDialog(
                    title: Text("Tiếp tục xem?", style: contentStyle),
                    content: Text(
                      "Bạn có muốn tiếp tục từ vị trí đã lưu: ${resumeVM.formatPosition(resumeVM.position)} không?",
                      textAlign: TextAlign.center,
                      style: contentStyle,
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => VideoPlayer(filmID: widget.filmID, position: 0),
                            ),
                          );
                        },
                        child: Text("Từ đầu", style: contentStyle),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => VideoPlayer(filmID: widget.filmID, position: resumeVM.position),
                            ),
                          );
                        },
                        child: Text("Tiếp tục", style: contentStyle,),
                      ),
                    ],
                  );
                }
            );
          },
        ),
      ),
    );
  }
}
