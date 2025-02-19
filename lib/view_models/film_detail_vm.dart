import 'package:better_player_enhanced/better_player.dart';
import 'package:du_an_cntt/helper/navigator.dart';
import 'package:du_an_cntt/models/film_rating.dart';
import 'package:du_an_cntt/views/comment/comment_screen.dart';
import 'package:du_an_cntt/views/resume/resume_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../models/film_model.dart';
import '../services/film_service.dart';
import '../services/firebase_authentication.dart';
import '../services/my_list_service.dart';
import '../services/rating_service.dart';

class DetailedFilmViewModel extends ChangeNotifier {
  final myListService = MyListService();
  final ratingService = RatingService();
  final auth = Auth();
  final filmService = FilmService();

  BetterPlayerController? _betterPlayerController;
  BetterPlayerDataSource? _betterPlayerDataSource;

  bool _hasLiked = false;

  bool _hasDisliked = false;

  int _activeEpisode = 0;

  bool _hasInMyList = false;

  FilmModel? _film;

  String? _trailerURL;

  bool _verifyToken = false;

  bool  get verifyToken => _verifyToken;

  String? get trailerURL => _trailerURL;

  int get activeEpisode => _activeEpisode;

  FilmModel? get film => _film;

  bool get hasInMyList => _hasInMyList;

  bool get hasLiked => _hasLiked;

  bool get hasDisliked => _hasDisliked;

  BetterPlayerController? get betterPlayerController => _betterPlayerController;
  @override
  void dispose() {
    _betterPlayerController?.dispose();
    super.dispose();
  }
  void setActiveEpisode(int index) {
    _activeEpisode = index;
    notifyListeners();
  }

  void playVideoOnTap(BuildContext context, String filmID){
    NavigatorHelper.navigateTo(context, MyResumeScreen(filmID:  filmID));

  }

  void ratingOnTap(BuildContext context, String filmID ){
    NavigatorHelper.navigateTo(context, CommentScreen(filmID: filmID));
  }

  Future<void> toggleHasInMyList(String filmID) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      print('User is not logged in');
      return;
    }
    String userID = user.uid;
    _hasInMyList = !_hasInMyList;

    if (_hasInMyList) {
      await myListService.addFilmToMyList(userID, filmID);
    } else {
      await myListService.removeFilmFromMyList(userID, filmID);
    }
    notifyListeners();
  }

  Future<void> getAddToListStatus(String filmID) async{
    final userID = await Auth().getUserID();
    _hasInMyList = await MyListService().isFilmInMyList(userID, filmID);
    // notifyListeners();
  }

  Future<void> getRating(String filmID) async {
    final userID = await Auth().getUserID();
    try {
      bool? ratingStatus = await ratingService.getRatingStatus(filmID, userID);

      if (ratingStatus != null) {
        if (ratingStatus) {
          _hasLiked = true;
          _hasDisliked = false;
        } else {
          _hasDisliked = true;
          _hasLiked = false;
        }
      } else {
        _hasLiked = false;
        _hasDisliked = false;
      }
      notifyListeners();
    } catch (e) {
      print("Error getting rating: $e");
    }
  }

  Future<void> toggleLike(String filmID) async {
    final userID = await Auth().getUserID();
    if (_hasLiked) {
      _hasLiked = false;
      await ratingService.deleteRating(filmID, userID);
    } else {
      _hasLiked = true;
      _hasDisliked = false;
      await ratingService.saveOrUpdateRating(RatingModel(id: '', filmID: filmID, userID: userID, rating: true));
      notifyListeners();
    }
  }

  Future<void> toggleDislike(String filmID) async {

    final userID = await Auth().getUserID();
    if (_hasDisliked) {
      _hasDisliked = false;
      await ratingService.deleteRating(filmID, userID);
    } else {
      _hasDisliked = true;
      _hasLiked = false;
      await ratingService.saveOrUpdateRating(RatingModel(id: '', filmID: filmID, userID: userID, rating: false));
    }
    notifyListeners();
  }

  Future<FilmModel?> getFilmDetails(String filmID) async {
    FilmModel? film = await FilmService().fetchFilmByID(filmID);
    if (film != null) {
        return film;
    }
    print('Film not found!');
    return null;
  }

  Future<void> updateViewTotal(String filmID) async{
    await filmService.updateTotalView(filmID);
  }

  Future<String?> getTrailerURL(filmID) async {
    _verifyToken = await auth.sendTokenToServer();
    if(_verifyToken){
      return await filmService.getTrailerUrl(filmID);
    }
    _verifyToken = false;
    return null;
  }

  Future<void> initializeVideoPlayer({required String filmID}) async{
    _trailerURL = await getTrailerURL(filmID);
    print("trailer: $_trailerURL");
    if (_trailerURL == null){
      return;
    }
    BetterPlayerConfiguration betterPlayerConfiguration = BetterPlayerConfiguration(
        aspectRatio: 16 / 9,
        fit: BoxFit.contain,
        autoPlay: true,
        looping: true,
        fullScreenByDefault: false,
        autoDispose: false,
        controlsConfiguration: BetterPlayerControlsConfiguration(
          showControls: false,
          enableProgressBar: false,
          enableFullscreen: false,
          enableOverflowMenu: false
        )
    );
    _betterPlayerDataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
      _trailerURL!,
      cacheConfiguration: BetterPlayerCacheConfiguration(
        useCache: false,
        maxCacheSize: 100 * 1024 * 1024, // 100 MB
        maxCacheFileSize: 10 * 1024 * 1024, // 10 MB
        preCacheSize: 5 * 1024 * 1024, // 5 MB preload
      ),
      bufferingConfiguration: BetterPlayerBufferingConfiguration(
        minBufferMs: 2000,
        maxBufferMs: 10000,
        bufferForPlaybackMs: 1000,
        bufferForPlaybackAfterRebufferMs: 2000,
      ),
    );
    _betterPlayerController = BetterPlayerController(betterPlayerConfiguration);
    _betterPlayerController!.setupDataSource(_betterPlayerDataSource!);
  }

}