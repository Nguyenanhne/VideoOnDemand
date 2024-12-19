// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// import '../view_models/detailed_movie_view_model.dart';
//
// class EpisodeList extends StatelessWidget {
//   final List<String> optionList;
//
//   const EpisodeList({Key? key, required this.optionList}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return SliverToBoxAdapter(
//       child: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
//         child: SizedBox(
//           height: 50.h,
//           child: Consumer<DetailedMovieViewModel>(
//             builder: (context, viewModel, child) {
//               return ListView.builder(
//                 scrollDirection: Axis.horizontal,
//                 itemCount: optionList.length,
//                 itemBuilder: (BuildContext context, int index) {
//                   final isActive = viewModel.activeEpisode == index;
//                   return InkWell(
//                     onTap: () {
//                       viewModel.setActiveEpisode(index);
//                     },
//                     child: Container(
//                       padding: EdgeInsets.symmetric(horizontal: 20.w),
//                       decoration: BoxDecoration(
//                         border: Border(
//                           top: BorderSide(
//                             width: 4.h,
//                             color: isActive
//                                 ? Colors.red.withOpacity(0.8)
//                                 : Colors.transparent,
//                           ),
//                         ),
//                       ),
//                       child: Center(
//                         child: Text(
//                           optionList[index],
//                           style: TextStyle(
//                             fontSize: 15.sp,
//                             color: isActive
//                                 ? Colors.white.withOpacity(0.9)
//                                 : Colors.white.withOpacity(0.5),
//                           ),
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
// body: FutureBuilder(
//     future: viewModel.getFilmDetails(filmID),
//     builder: (context, snapshot){
//       if (snapshot.connectionState == ConnectionState.waiting) {
//         return Center(child: CircularProgressIndicator());
//       }
//       else{
//         final film = snapshot.data;
//         return CustomScrollView(
//           slivers: [
//             SliverToBoxAdapter (
//               child: Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 10.w),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Padding(
//                       padding: EdgeInsets.symmetric(vertical: 10.h),
//                       child: Text(
//                           film!.name,
//                           style: contentStyle.copyWith(fontSize: 23.sp, fontWeight: FontWeight.bold)
//                       ),
//                     ),
//                     Row(
//                       children: [
//                         Text(
//                           film.year.toString(),
//                           style: contentStyle.copyWith(color: Colors.grey),
//                         ),
//                         Padding(
//                           padding: EdgeInsets.symmetric(horizontal: 10.w),
//                           child: Container(
//                             padding: EdgeInsets.symmetric(horizontal: 5.w),
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(2.r),
//                               color: Colors.grey[800],
//                             ),
//                             child: Text(
//                               ("${film.age.toString()}+"),
//                               style: contentStyle.copyWith(color: Colors.grey),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     ListTile(
//                       leading: Image(
//                         image: AssetImage("assets/top10.png"),
//                         width: 20.w,
//                         height: 20.w,
//                         fit: BoxFit.fitWidth,
//                       ),
//                       title: Text(
//                         "#1 Dẫn đầu BHX trong tháng này",
//                         style: contentStyle.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
//                       ),
//                       contentPadding: EdgeInsets.zero,
//                     ),
//                     Padding(
//                       padding: EdgeInsets.symmetric(vertical: 10.w),
//                       child: SizedBox(
//                         width: double.maxFinite,
//                         height: 35.h,
//                         child: const DetailedMovieButton(
//                           bgColor: Colors.white,
//                           icon: Icons.play_arrow,
//                           text: 'Phát',
//                           textColor: Colors.black,
//                           iconColor: Colors.black,),
//                       ),
//                     ),
//                     SizedBox(
//                       width: double.maxFinite,
//                       height: 35.h,
//                       child: DetailedMovieButton(
//                         bgColor: Colors.grey[900],
//                         icon: LineAwesomeIcons.download_solid,
//                         text: 'Tải xuống',
//                         textColor: Colors.white,
//                         iconColor: Colors.white,
//                       ),
//                     ),
//                     Padding(
//                       padding: EdgeInsets.symmetric(vertical: 5.h),
//                       child: Text(
//                         "Mô tả",
//                         style: contentStyle.copyWith(fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                     GestureDetector(
//                       child: Text(
//                         film.description,
//                         style: contentStyle.copyWith(fontSize: 13.sp),
//                         overflow: TextOverflow.ellipsis,
//                         maxLines: 3,
//                       ),
//                       onTap: () => showDesBottomSheet(context, film.name, film.description),
//                     ),
//                     Padding(
//                       padding: EdgeInsets.symmetric(vertical: 5.h),
//                       child: GestureDetector(
//                         onTap: (){
//                           showActorBottomSheet(context, film.name, film.actors);
//                         },
//                         child: Row(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               "Diễn viên:",
//                               style: contentStyle.copyWith(fontWeight: FontWeight.bold, color: Colors.grey),
//                             ),
//                             Expanded(
//                               child: Padding(
//                                 padding: EdgeInsets.only(left: 10.w),
//                                 child: Text(
//                                   film.actors.join(", "),
//                                   maxLines: 2,
//                                   style: contentStyle.copyWith(fontSize: 13.sp),
//                                   overflow: TextOverflow.ellipsis,
//                                 ),
//                               ),
//                             )
//                           ],
//                         ),
//                       ),
//                     ),
//                     GestureDetector(
//                       onTap: (){
//                         // showActorBottomSheet(context, film.name, film.actors);
//                       },
//                       child: Row(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             "Đạo diễn: ",
//                             style: contentStyle.copyWith(fontWeight: FontWeight.bold, color: Colors.grey),
//                           ),
//                           Expanded(
//                             child: Padding(
//                               padding: EdgeInsets.only(left: 10.w),
//                               child: Text(
//                                 film.director,
//                                 style: contentStyle.copyWith(fontSize: 13.sp, overflow: TextOverflow.ellipsis),
//                                 overflow: TextOverflow.ellipsis,
//                                 maxLines: 1,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Padding(
//                       padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: List.generate(likesList.length, (index) {
//                           return GestureDetector(
//                             onTap: (){
//                               viewModel.likeListOntap(context, index);
//                             },
//                             child: Column(
//                               children: [
//                                 Icon(
//                                   likesList[index]['icon'],
//                                   size: 25.sp,
//                                   color: Colors.white.withOpacity(0.9),
//                                 ),
//                                 SizedBox(
//                                   height: 5.h,
//                                 ),
//                                 Text(likesList[index]['text'],
//                                     style: contentStyle.copyWith(fontSize: 13.sp, color: Colors.grey)
//                                 )
//                               ],
//                             ),
//                           );
//                         }),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             // SliverToBoxAdapter(
//             //   child: Padding(
//             //     padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
//             //     child: SizedBox(
//             //       height: 50,
//             //       child: ListView.builder(
//             //           scrollDirection: Axis.horizontal,
//             //           itemBuilder: (BuildContext context, int index){
//             //             final isActive = viewModel.activeEpisode == index;
//             //             return InkWell(
//             //               onTap: (){
//             //                 viewModel.setActiveEpisode(index);
//             //               },
//             //               child: Container(
//             //                 padding: EdgeInsets.symmetric(horizontal: 20.w),
//             //                 decoration: BoxDecoration(
//             //                     border: Border(
//             //                         top: BorderSide(
//             //                             width: 4.h,
//             //                             color: isActive
//             //                                 ? Colors.red
//             //                                 .withOpacity(0.8)
//             //                                 : Colors.transparent
//             //                         )
//             //                     )
//             //                 ),
//             //                 child: Center(
//             //                   child: Text(
//             //                     optionList[index],
//             //                     style: contentStyle.copyWith(fontSize: 15.sp,
//             //                         color: isActive
//             //                             ? Colors.white.withOpacity(0.9)
//             //                             : Colors.white.withOpacity(0.5)
//             //                     ),
//             //                   ),
//             //                 ),
//             //               ),
//             //             );
//             //           },
//             //           itemCount: optionList.length),
//             //     ),
//             //   ),
//             // ),
//             SliverToBoxAdapter(
//               child: Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
//                 child: SizedBox(
//                   height: 50.h,
//                   child: Consumer<DetailedMovieViewModel>(
//                     builder: (context, viewModel, child) {
//                       return ListView.builder(
//                         scrollDirection: Axis.horizontal,
//                         itemCount: optionList.length,
//                         itemBuilder: (BuildContext context, int index) {
//                           final isActive = viewModel.activeEpisode == index;
//                           return InkWell(
//                             onTap: () {
//                               viewModel.setActiveEpisode(index);
//                             },
//                             child: Container(
//                               padding: EdgeInsets.symmetric(horizontal: 20.w),
//                               decoration: BoxDecoration(
//                                 border: Border(
//                                   top: BorderSide(
//                                     width: 4.h,
//                                     color: isActive
//                                         ? Colors.red.withOpacity(0.8)
//                                         : Colors.transparent,
//                                   ),
//                                 ),
//                               ),
//                               child: Center(
//                                 child: Text(
//                                   optionList[index],
//                                   style: TextStyle(
//                                     fontSize: 15.sp,
//                                     color: isActive
//                                         ? Colors.white.withOpacity(0.9)
//                                         : Colors.white.withOpacity(0.5),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           );
//                         },
//                       );
//                     },
//                   ),
//                 ),
//               ),
//             )
//             // SliverList(
//             //   delegate: SliverChildBuilderDelegate(
//             //         (BuildContext context, int index) {
//             //       return MovieAlbum();
//             //     },
//             //     childCount: 50,
//             //   ),
//             // ),
//           ],
//         );
//       }
//     }
// ),
