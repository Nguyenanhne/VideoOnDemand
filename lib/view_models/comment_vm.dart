import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:du_an_cntt/helper/navigator.dart';
import 'package:du_an_cntt/models/comment_model.dart';
import 'package:du_an_cntt/models/film_model.dart';
import 'package:du_an_cntt/services/comment_service.dart';
import 'package:du_an_cntt/services/user_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../services/firebase_authentication.dart';

class CommentViewModel extends ChangeNotifier{

  final CommentService _commentService = CommentService();
  final Auth _auth = Auth();
  final UserService _userService = UserService();

  bool _isLoading = false;
  String? _filmID;
  CommentModel? _myComment;
  List<CommentModel> _listComments = [];
  DocumentSnapshot? _lastDocument;
  bool _hasMore = true;

  CommentModel? get myComment => _myComment;
  List<CommentModel> get listComments => _listComments;
  String? get filmID => _filmID;
  bool get isLoading => _isLoading;
  bool get hasMore => _hasMore;

  set filmID(String? id) {
    _filmID = id;
  }

  TextEditingController contentController = TextEditingController();
  ScrollController commentsController = ScrollController();

  // CommentViewModel(){
  //   commentsController.addListener((){
  //     _onScroll();
  //   });
  // }

  Future<void> addComment(BuildContext context) async{
    if (contentController.text.trim().isEmpty) {
      print("Không có gì để thêm");
      return; // Không gửi nếu nội dung trống
    }
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );
    final userID = await _auth.getUserID();
    final email = await _userService.getEmailByUID(userID);
    try {
      CommentModel? newComment = await _commentService.addComment(
        filmID: _filmID!,
        userID: userID,
        content: contentController.text.trim(),
        email: email!,
      );
      if (newComment != null) {
        _myComment = newComment;
        contentController.clear();
      }
    } catch (e) {
      print("Lỗi khi thêm comment: $e");
    }
    if(context.mounted){
      NavigatorHelper.goBack(context);
    }
    notifyListeners();
  }

  Future<void> fetchMyComment() async{
    if(_filmID == null){
      return;
    }
    final userID = await Auth().getUserID();
    _myComment = await _commentService.getCommentsByUserAndFilm(userID: userID, filmID: _filmID!);
  }

  Future<void> fetchListComments({int limit = 8}) async{
    _listComments = [];
    if(_filmID == null){
      return;
    }
    try {
      final result = await _commentService.fetchListComments(limit: limit, lastDocument: null, filmID: _filmID!);

      if(result.isEmpty){
        return;
      }

      final List<CommentModel> comments = result['comments'] as List<CommentModel>;

      final DocumentSnapshot? lastDocument = result['lastDocument'] as DocumentSnapshot?;

      _listComments.addAll(comments);

      _lastDocument = lastDocument;

      _hasMore = comments.length == limit;

      commentsController = ScrollController()..addListener(_onScroll);
    } catch (e) {
      print('Failed to load comments: $e');
    }
  }

  Future<void> fetchMoreListComments({int limit = 5}) async{
    print("fetch more");
    if (_isLoading || !_hasMore) return;
    _isLoading = true;
    notifyListeners();
    await Future.delayed(Duration(seconds: 5));
    try {
      final result = await _commentService.fetchListComments(
        limit: limit,
        lastDocument: _lastDocument,
        filmID: _filmID!,
      );
      final List<CommentModel> comments = result['comments'] as List<CommentModel>;
      final DocumentSnapshot? lastDocument = result['lastDocument'] as DocumentSnapshot?;

      if (comments.isNotEmpty) {
        _listComments.addAll(comments);

        _lastDocument = lastDocument;

        if (comments.length < limit) {
          _hasMore = false;
        }
      } else {
        _hasMore = false;
      }
    } catch (e) {
      print( 'Failed to load comments: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  void reset(){
    _listComments = [];
    _myComment = null;
    contentController.clear();
    _isLoading = false;
    _hasMore = true;
  }

  void _onScroll() {
    if (commentsController.position.pixels == commentsController.position.maxScrollExtent && !isLoading && hasMore) {
      fetchMoreListComments();
    }
  }
  @override
  void dispose() {
    contentController.dispose();
    commentsController.dispose();
    super.dispose();
  }
}