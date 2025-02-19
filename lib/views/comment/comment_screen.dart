import 'package:du_an_cntt/views/responsive.dart';
import 'package:du_an_cntt/view_models/comment_vm.dart';
import 'package:du_an_cntt/views/comment/comment_web.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../view_models/rating_vm.dart';
import 'comment_mobile.dart';
import 'comment_tablet.dart';

class CommentScreen extends StatefulWidget {
  final String filmID;
  CommentScreen({super.key, required this.filmID});

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  late String filmID;
  late Future<void> loadLikes;
  late Future<void> loadDisLikes;
  late Future<void> loadTotalView;
  late Future<void> loadMyComment;
  late Future<void> loadListComments;

  @override
  void initState() {
    super.initState();
    final ratingViewModel = Provider.of<RatingViewModel>(context, listen: false);
    final commentViewModel = Provider.of<CommentViewModel>(context, listen: false);

    commentViewModel.reset();

    filmID = widget.filmID;
    commentViewModel.filmID = widget.filmID;

    loadMyComment = commentViewModel.fetchMyComment();
    loadListComments = commentViewModel.fetchListComments();
    loadLikes = ratingViewModel.fetchTotalLikes(filmID);
    loadDisLikes = ratingViewModel.fetchTotalDislikes(filmID);
    loadTotalView = ratingViewModel.fetchTotalView(filmID);
  }
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
        mobileLayout: CommentScreenMobile(filmID: widget.filmID, loadLikes: loadLikes, loadDisLikes: loadDisLikes, loadTotalView: loadTotalView, loadMyComment: loadMyComment, loadListComments: loadListComments),
        tabletLayout: CommentScreenTablet(filmID: widget.filmID, loadLikes: loadLikes, loadDisLikes: loadDisLikes, loadTotalView: loadTotalView, loadMyComment: loadMyComment, loadListComments: loadListComments),
        webLayout: CommentScreenWeb(filmID: widget.filmID, loadLikes: loadLikes, loadDisLikes: loadDisLikes, loadTotalView: loadTotalView, loadMyComment: loadMyComment, loadListComments: loadListComments)
    );
  }
}