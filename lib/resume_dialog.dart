import 'package:du_an_cntt/views/video.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ResumeDialogPage extends StatefulWidget {
  const ResumeDialogPage({Key? key}) : super(key: key);

  @override
  State<ResumeDialogPage> createState() => _ResumeDialogPageState();
}

class _ResumeDialogPageState extends State<ResumeDialogPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  }
  void dispose(){
    super.dispose();
  }
  Future<int> _getLastVideoPosition() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('last_video_position') ?? 0;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<int>(
          future: _getLastVideoPosition(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }

            if (snapshot.hasError) {
              return Text("Lỗi: ${snapshot.error}");
            }

            final lastPosition = snapshot.data ?? 0;

            return AlertDialog(
              title: Text("Tiếp tục xem?"),
              content: Text("Bạn có muốn tiếp tục từ vị trí đã lưu không? $lastPosition"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => VideoPlayerPage(startPosition: 0),
                      ),
                    );
                  },
                  child: Text("Từ đầu"),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => VideoPlayerPage(startPosition: lastPosition),
                      ),
                    );
                  },
                  child: Text("Tiếp tục"),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
