import 'package:du_an_cntt/view_models/comment_vm.dart';
import 'package:du_an_cntt/view_models/rating_vm.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../helper/navigator.dart';
import '../../utils/utils.dart';

class CommentScreenMobile extends StatefulWidget {
  CommentScreenMobile({super.key, required this.filmID, required this.loadLikes, required this.loadDisLikes, required this.loadTotalView, required this.loadMyComment, required this.loadListComments});

  final String filmID;
  final Future<void> loadLikes;
  final Future<void> loadDisLikes;
  final Future<void> loadTotalView;
  final Future<void> loadMyComment;
  final Future<void> loadListComments;

  @override
  State<CommentScreenMobile> createState() => _CommentScreenMobileState();
}

class _CommentScreenMobileState extends State<CommentScreenMobile> {

  var sizeIcon = 50.0;
  @override
  Widget build(BuildContext context) {
    final contentStyle = TextStyle(
        fontFamily: GoogleFonts.roboto().fontFamily,
        color: Colors.black,
        fontSize: 14.sp
    );
    final commentViewModel = Provider.of<CommentViewModel>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        titleSpacing: 0,
        elevation: 0,
        title: Text(
          "Đánh giá phim",
          style: contentStyle.copyWith(color: Colors.white, fontSize: 18),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(colorAppbarIcon)),
          onPressed: () {
            NavigatorHelper.goBack(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Consumer<RatingViewModel>(
                    builder: (context, viewModel, child){
                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Icon(Icons.play_circle, size: sizeIcon),
                        title: FutureBuilder(
                            future: widget.loadTotalView,
                            builder: (context, snapshot){
                              if (snapshot.connectionState == ConnectionState.waiting){
                                return CupertinoActivityIndicator();
                              }else if(snapshot.hasError){
                                return Text("error", style: contentStyle,);
                              }else{
                                return Consumer<RatingViewModel>(
                                    builder: (context, ratingVM, child) {
                                      return Text("${ratingVM.viewTotal}", style: contentStyle);
                                    }
                                );
                              }
                            }
                        ),
                      );
                    },
                  ),
                ),
                Expanded(
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(Icons.thumb_up, size: sizeIcon, color: Colors.blue),
                    title: FutureBuilder(
                        future: widget.loadLikes,
                        builder: (context, snapshot){
                          if (snapshot.connectionState == ConnectionState.waiting){
                            return CupertinoActivityIndicator();
                          }else if(snapshot.hasError){
                            return Text("error", style: contentStyle,);
                          }else{
                            return Consumer<RatingViewModel>(
                              builder: (context, ratingVM, child) {
                                return Text("${ratingVM.totalLikes}", style: contentStyle,);
                              }
                            );
                          }
                        }
                    ),
                  ),
                ),
                Expanded(
                  child: Consumer<RatingViewModel>(
                    builder: (context, viewModel, child){
                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Icon(Icons.thumb_down, size: sizeIcon, color: Colors.red),
                        title: FutureBuilder(
                          future: widget.loadDisLikes,
                          builder: (context, snapshot){
                            if (snapshot.connectionState == ConnectionState.waiting){
                              return CupertinoActivityIndicator();
                            }else if(snapshot.hasError){
                              return Text("error", style: contentStyle,);
                            }else{
                              return Consumer<RatingViewModel>(
                                builder: (context, ratingVM, child) {
                                  return Text("${ratingVM.totalDislikes}", style: contentStyle,);
                                }
                              );
                            }
                          }
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            Text("Bình luận của bạn", style: contentStyle.copyWith(fontWeight: FontWeight.bold)),
            FutureBuilder(
              future: widget.loadMyComment,
              builder: (context, snapshot) {
                if(snapshot.connectionState == ConnectionState.waiting){
                  return Center(child: CircularProgressIndicator());
                }
                return Consumer<CommentViewModel>(
                  builder: (context, commentVM, child) {
                    return (commentVM.myComment != null) ?  ListTile(
                      title: Text(
                        commentVM.myComment!.email,
                        softWrap: true,
                        style: contentStyle.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      leading: Image.asset(
                        "assets/user.jpg",
                        fit: BoxFit.fitWidth,
                      ),
                      subtitle: Text(
                        commentVM.myComment!.content,
                        softWrap: true,
                        style: contentStyle.copyWith(
                        ),
                      ),
                    ): Center(
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        child: Text(
                          "Bạn chưa có bình luận", style: contentStyle
                        )
                      )
                    );
                  }
                );
              }
            ),
            Text("Bình luận khác", style: contentStyle.copyWith(fontWeight: FontWeight.bold)),
            SizedBox(height: 10.h),
            Expanded(
              flex: 8,
              child: FutureBuilder(
                future: widget.loadListComments,
                builder: (context, snapshot) {
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return ListView(
                      children:  [
                         Center(child: CircularProgressIndicator())
                      ]
                    );
                  }
                  else if(snapshot.hasError){
                    return ListView(
                      children: [
                        Center(child: Text("Đã có lỗi trong việc tải bình luận", style: contentStyle)),
                      ],
                    );
                  }
                  return Consumer<CommentViewModel>(
                    builder: (context, commentVM, child) {
                      return (commentVM.listComments.isNotEmpty) ? ListView.separated(
                        controller: commentVM.commentsController,
                        separatorBuilder: (context, index) => Divider(
                          height: 20.h,
                          color: Colors.grey,
                          thickness: 0.3,
                        ),
                        itemCount: commentVM.listComments.length + (commentVM.isLoading ? 1 : 0),
                        itemBuilder: (context, index){
                          if (index == commentVM.listComments.length) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Center(
                                child: CupertinoActivityIndicator(),
                              )
                            );
                          }
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListTile(
                                title: Text(
                                  commentViewModel.listComments[index].email,
                                  softWrap: true,
                                  style: contentStyle.copyWith(
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                leading: Image.asset(
                                  "assets/user.jpg",
                                  fit: BoxFit.fitWidth,
                                ),
                                subtitle: Text(
                                  commentViewModel.listComments[index].content,
                                  softWrap: true,
                                  style: contentStyle.copyWith(
                                    fontSize: 13.sp,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ): Center(child: Text("Chưa có bình luận nào, hãy để lại bình luận", style: contentStyle));
                    }
                  );
                }
              )
            ),
            Divider(height: 20.h),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: commentViewModel.contentController,
                    maxLines: null,
                    autofocus: true,
                    decoration: InputDecoration(
                      hintText: "Chia sẻ cảm nghĩ của bạn",
                      hintStyle: contentStyle,
                      border: OutlineInputBorder(
                      )
                    ),
                  )
                ),
                IconButton(
                  onPressed: (){
                    commentViewModel.addComment(context);
                  },
                  icon: Icon(Icons.send, color: Colors.blue)
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

