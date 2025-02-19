import 'package:du_an_cntt/utils/utils.dart';
import 'package:du_an_cntt/view_models/video_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:better_player_enhanced/better_player.dart';

class VideoPlayer extends StatefulWidget {
  final String filmID;
  final int position;
  const VideoPlayer({super.key, required this.filmID, required this.position});

  @override
  State<VideoPlayer> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  late Future<void> getFilmURL;
  @override
  void initState() {
    SystemChrome.setPreferredOrientations([]);
    final videoViewModel = Provider.of<VideoViewModel>(context, listen: false);
    getFilmURL = videoViewModel.initializeVideoPlayer(filmID: widget.filmID, position: widget.position);
    super.initState();
  }
  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(colorAppbarIcon), size: 30),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body:  PopScope(
        canPop: false,
        child: Consumer<VideoViewModel>(
          builder: (context, videoViewModel, child) {
            return BetterPlayer(controller: videoViewModel.betterPlayerController!);
          }
        )
      )
      // body: FutureBuilder(
      //   future: getFilmURL,
      //   builder: (context, snapshot){
      //     if(snapshot.connectionState == ConnectionState.waiting){
      //       return Center(child: CircularProgressIndicator());
      //     }
      //     return (videoViewModel.verifyToken)
      //       ? (videoViewModel.videoURL != null)
      //       ? PopScope(canPop: false, child: Consumer<VideoViewModel>(builder: (context, videoViewModel, child) {return BetterPlayer(controller: videoViewModel.betterPlayerController!);}))
      //       : Center(child: Text("Lỗi phim!", style: contentStyle))
      //       : Center(child: Text("Lỗi xác thực!", style: contentStyle));
      //   }
      // )
      //   body: (videoViewModel.verifyToken)
      //       ? PopScope(canPop: false, child: Consumer<VideoViewModel>(builder: (context, videoViewModel, child) {return BetterPlayer(controller: videoViewModel.betterPlayerController);}))
      //       : Center(child: Text("Lỗi xác thực!", style: contentStyle))
    );
  }
}
