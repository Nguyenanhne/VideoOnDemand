import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../helper/navigator.dart';
import '../../utils/utils.dart';
import '../../view_models/comment_vm.dart';
import '../../view_models/rating_vm.dart';

class CommentScreenWeb extends StatefulWidget {
  const CommentScreenWeb({super.key, required this.filmID, required this.loadLikes, required this.loadDisLikes, required this.loadTotalView, required this.loadMyComment, required this.loadListComments});
  final String filmID;
  final Future<void> loadLikes;
  final Future<void> loadDisLikes;
  final Future<void> loadTotalView;
  final Future<void> loadMyComment;
  final Future<void> loadListComments;
  @override
  State<CommentScreenWeb> createState() => _CommentScreenWebState();
}

class _CommentScreenWebState extends State<CommentScreenWeb> {


  @override
  Widget build(BuildContext context) {
    var sizeIcon = 40.0;

    final contentStyle = TextStyle(
        fontFamily: GoogleFonts.roboto().fontFamily,
        color: Colors.black,
        fontSize: 20
    );
    final heightScreen = MediaQuery.of(context).size.height
        - AppBar().preferredSize.height
        - MediaQuery.of(context).padding.top;
    final widthScreen = MediaQuery.of(context).size.width;

    final commentViewModel = Provider.of<CommentViewModel>(context, listen: false);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 70.h,
        backgroundColor: Colors.black,
        titleSpacing: 0,
        elevation: 0,
        title: Text(
          "Đánh giá phim",
          style: contentStyle.copyWith(color: Colors.white, fontSize: 25),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(colorAppbarIcon), size: iconTabletSize,),
          onPressed: () {
            NavigatorHelper.goBack(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: FutureBuilder<void>(
                      future: widget.loadTotalView,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: Icon(Icons.play_circle, size: sizeIcon, color: Colors.blue),
                            title: CupertinoActivityIndicator(),
                          );
                        } else if (snapshot.hasError) {
                          return ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: Icon(Icons.play_circle, size: sizeIcon, color: Colors.blue),
                            title: Text("error", style: contentStyle,),
                          );
                        } else {
                          return Consumer<RatingViewModel>(
                            builder: (context, viewModel, child){
                              return ListTile(
                                contentPadding: EdgeInsets.zero,
                                leading: Icon(Icons.play_circle, size: sizeIcon, color: Colors.blue),
                                title: Text("${viewModel.viewTotal}", style: contentStyle),
                              );
                            },
                          );
                        }
                        return ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: Icon(Icons.thumb_up, color: Colors.grey,),
                          title: Text("500"),
                        );
                      }
                  ),
                ),
                Expanded(
                  child: FutureBuilder<void>(
                      future: widget.loadLikes,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: Icon(Icons.thumb_up, size: sizeIcon, color: Colors.blue),
                            title: CupertinoActivityIndicator(),
                          );
                        } else if (snapshot.hasError) {
                          return ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: Icon(Icons.thumb_up, size: sizeIcon, color: Colors.blue),
                            title: Text("error", style: contentStyle),
                          );
                        } else {
                          return Consumer<RatingViewModel>(
                            builder: (context, viewModel, child){
                              return ListTile(
                                contentPadding: EdgeInsets.zero,
                                leading: Icon(Icons.thumb_up, size: sizeIcon, color: Colors.blue),
                                title: Text("${viewModel.totalLikes}", style: contentStyle),
                              );
                            },
                          );
                        }
                      }
                  ),
                ),
                Expanded(
                  child: FutureBuilder<void>(
                      future: widget.loadDisLikes,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: Icon(Icons.thumb_down, size: sizeIcon, color: Colors.red),
                            title: CupertinoActivityIndicator(),
                          );
                        } else if (snapshot.hasError) {
                          return ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: Icon(Icons.thumb_down, size: sizeIcon, color: Colors.red),
                            title: Text("error", style: contentStyle),
                          );
                        } else {
                          return Consumer<RatingViewModel>(
                            builder: (context, viewModel, child){
                              return ListTile(
                                contentPadding: EdgeInsets.zero,
                                leading: Icon(Icons.thumb_down, size: sizeIcon, color: Colors.red),
                                title: Text("${viewModel.totalDislikes}",style: contentStyle),
                              );
                            },
                          );
                        }
                        return ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: Icon(Icons.thumb_up, color: Colors.grey,),
                          title: Text("500"),
                        );
                      }
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
                        return Center(child: CircularProgressIndicator());
                      }
                      else if(snapshot.hasError){
                        return Center(child: Text("Đã có lỗi trong việc tải bình luận", style: contentStyle));
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
                                        commentVM.listComments[index].email,
                                        softWrap: true,
                                        style: contentStyle
                                      ),
                                      leading: Image.asset(
                                        "assets/user.jpg",
                                        fit: BoxFit.fitWidth,
                                      ),
                                      subtitle: Text(
                                        commentVM.listComments[index].content,
                                        softWrap: true,
                                        style: contentStyle
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
                    icon: Icon(Icons.send, color: Colors.blue, size: sizeIcon)
                )
              ],
            )
        ],
      ),
      ),
    );
  }

}
