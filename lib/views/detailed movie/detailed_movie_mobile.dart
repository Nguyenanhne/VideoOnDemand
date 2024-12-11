import 'package:du_an_cntt/utils.dart';
import 'package:du_an_cntt/view_models/movie_detail_vm.dart';
import 'package:du_an_cntt/widgets/movie_detail/movie_detail_button.dart';
import 'package:du_an_cntt/widgets/movie_detail/movie_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';

import '../../widgets/movie_detail/text.dart';

class DetailedMovieScreenMobile extends StatefulWidget {
  const DetailedMovieScreenMobile({super.key});

  @override
  State<DetailedMovieScreenMobile> createState() => _DetailedMovieScreenMobileState();
}

class _DetailedMovieScreenMobileState extends State<DetailedMovieScreenMobile> {
  int activeEpisode = 0;

  final contentStyle = TextStyle(
      fontFamily: GoogleFonts.roboto().fontFamily,
      fontSize: 14.sp,
  );

  final String des = "Bộ phim là hành trình của Eren Jaeger và hai người bạn thân từ thuở nhỏ là Mikasa Ackerman và Armin Arlert. "
      "Cuộc đời của họ hoàn toàn bị thay đổi sau khi bức tường ngoài cùng của thành Maria bị sụp đổ và các Titan đổ bộ vào và ăn thịt người dân. "
      "Sau khi chứng kiến mẹ bị ăn thịt, Eren đã thề sẽ quét sạch lũ Titan";

  final String title = "Đại chiến Titan";

  final List<String> listActor = ["Nguyen Van A", "Nguyen Van B", "Nguyen Van C",
    "Nguyen Van A", "Nguyen Van B", "Nguyen Van C",
    "Nguyen Van A", "Nguyen Van B", "Nguyen Van C","Nguyen Van C","Nguyen Van C","Nguyen Van C"];

  late final TabController tabController;

  List likesList = [
    {"icon": Icons.add, "text": "Danh sách"},
    {"icon": Icons.thumb_up_alt_outlined, "text": "Đánh giá"},
    {"icon": Icons.send_outlined, "text": "Chia sẻ"},
    {"icon": Icons.comment, "text": "Bình luận"},
  ];
  List optionList = ["Các tập", "Trailer", "Nội dung tương tự"];

  @override
  Widget build(BuildContext context) {
    final heightScreen = MediaQuery.of(context).size.height
        - AppBar().preferredSize.height
        - MediaQuery.of(context).padding.top;
    final widthScreen = MediaQuery.of(context).size.width;
    final viewModel = Provider.of<DetailedMovieViewModel>(context);
    final heightBottomSheet = MediaQuery.of(context).size.height - AppBar().preferredSize.height;
    void showDesBottomSheet(BuildContext context) {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return Container(
            height: heightBottomSheet,
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Mô tả: $title',
                      style: contentStyle.copyWith(fontSize: 18.sp, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(
                        Icons.close_outlined,
                        color: Colors.white,
                      ) ,
                    )
                  ],
                ),
                SizedBox(height: 20.h),
                Text(
                  des,
                  style: contentStyle.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          );
        },
      );
    };
    void showActorBottomSheet(BuildContext context) {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return Container(
            height: heightBottomSheet,
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16.0)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Diễn viên: $title',
                      style: contentStyle.copyWith(fontSize: 18.sp, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.close_outlined,
                        color: Colors.white,
                      ) ,
                    )
                  ],
                ),
                SizedBox(height: 20.h),
                Expanded(
                  child: ListView.separated(
                    separatorBuilder: (BuildContext context, int index) => const SizedBox(
                      height: 10,
                    ),
                    itemCount: listActor.length,
                    itemBuilder: (BuildContext context, int index) => Text(
                      listActor[index],
                      style: contentStyle.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    }
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        backgroundColor: Colors.black,
        leading: Icon(
          Icons.arrow_back,
          color: Color(colorAppbarIcon),
        ),
        actions: [
          InkWell(
              onTap: (){},
              child: const Icon(
                LineAwesomeIcons.download_solid,
                size: 30,
                color: Colors.white,
              )
          ),
          SizedBox(width: 15.w),
          InkWell(
              onTap: (){},
              child: const Icon(
                Icons.search,
                size: 30,
                color: Colors.white,
              )
          ),
          SizedBox(width: 20.w)
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter (
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: heightScreen*0.25,
                    decoration: BoxDecoration(
                        image: DecorationImage(image: AssetImage("assets/welcome_bg1.jpg"),
                            fit: BoxFit.cover
                        )
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    child: Text(
                      "Đại chiến Titan",
                      style: TextStyle(
                          fontFamily: GoogleFonts.roboto().fontFamily,
                          fontSize: 23.sp,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "2023",
                        style: contentStyle.copyWith(color: Colors.grey),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 5.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2.r),
                            color: Colors.grey[800],
                          ),
                          child: Text(
                            "T18",
                            style: contentStyle.copyWith(color: Colors.grey),
                          ),
                        ),
                      ),
                    ],
                  ),
                  ListTile(
                    leading: Image(
                      image: AssetImage("assets/top10.png"),
                      width: 20.w,
                      height: 20.w,
                      fit: BoxFit.fitWidth,
                    ),
                    title: Text(
                      "#1 Dẫn đầu BHX trong tháng này",
                      style: contentStyle.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    contentPadding: EdgeInsets.zero,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.w),
                    child: SizedBox(
                      width: double.maxFinite,
                      height: 35.h,
                      child: const DetailedMovieButton(
                        bgColor: Colors.white,
                        icon: Icons.play_arrow,
                        text: 'Phát',
                        textColor: Colors.black,
                        iconColor: Colors.black,),
                    ),
                  ),
                  SizedBox(
                    width: double.maxFinite,
                    height: 35.h,
                    child: DetailedMovieButton(
                      bgColor: Colors.grey[900],
                      icon: LineAwesomeIcons.download_solid,
                      text: 'Tải xuống',
                      textColor: Colors.white,
                      iconColor: Colors.white,),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 5.h),
                    child: Text(
                      "Mô tả",
                      style: contentStyle.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  GestureDetector(
                    child: Text(
                      des,
                      style: contentStyle.copyWith(fontSize: 13.sp),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                    ),
                      onTap: () => showDesBottomSheet(context),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 5.h),
                    child: GestureDetector(
                      onTap: (){
                        showActorBottomSheet(context);
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Diễn viên:",
                            style: contentStyle.copyWith(fontWeight: FontWeight.bold, color: Colors.grey),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(left: 10.w),
                              child: Text(
                                listActor.join(", "),
                                maxLines: 2,
                                style: contentStyle.copyWith(fontSize: 13.sp),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      showActorBottomSheet(context);
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Đạo diễn: ",
                          style: contentStyle.copyWith(fontWeight: FontWeight.bold, color: Colors.grey),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: 10.w),
                            child: Text(
                              listActor.join(", "),
                              style: contentStyle.copyWith(fontSize: 13.sp, overflow: TextOverflow.ellipsis),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(likesList.length, (index) {
                        return GestureDetector(
                          onTap: (){
                            viewModel.likeListOntap(context, index);
                          },
                          child: Column(
                            children: [
                              Icon(
                                likesList[index]['icon'],
                                size: 25.sp,
                                color: Colors.white.withOpacity(0.9),
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              Text(likesList[index]['text'],
                                style: contentStyle.copyWith(fontSize: 13.sp, color: Colors.grey)
                              )
                            ],
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
              child: SizedBox(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index){
                    return InkWell(
                      onTap: (){
                        setState(() {
                          activeEpisode = index;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        decoration: BoxDecoration(
                            border: Border(
                                top: BorderSide(
                                    width: 4.h,
                                    color: activeEpisode == index
                                        ? Colors.red
                                        .withOpacity(0.8)
                                        : Colors.transparent
                                )
                            )
                        ),
                        child: Center(
                          child: Text(
                            optionList[index],
                            style: contentStyle.copyWith(fontSize: 15.sp,                                             color: activeEpisode == index
                                ? Colors.white.withOpacity(0.9)
                                : Colors.white.withOpacity(0.5)
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: optionList.length),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                return MovieAlbum();
              },
              childCount: 50,
            ),
          ),
        ],
      ),
    );
  }
}
