import 'package:cached_network_image/cached_network_image.dart';
import 'package:du_an_cntt/view_models/home_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';
class FilmCardVertical extends StatelessWidget {
  final double width;
  final double height;
  final String url;
  final String name;
  final String types;
  final String age;
  final String des;
  final VoidCallback ontap;
  final double fontSize;
  FilmCardVertical({super.key, required this.url, required this.name, required this.types, required this.age, required this.ontap, required this.des, required this.width, required this.height, required this.fontSize});

  @override
  Widget build(BuildContext context) {

    final viewModel = Provider.of<HomeViewModel>(context, listen: false);
    final heightScreen = MediaQuery.of(context).size.height
        - AppBar().preferredSize.height
        - MediaQuery.of(context).padding.top;

    final style = TextStyle(
        fontFamily: GoogleFonts.roboto().fontFamily,
        color: Colors.grey,
        fontSize: fontSize
    );
    return Card(
      color: Colors.black,
      // margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: InkWell(
        onTap: ontap,
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: width,
                  height: height,
                  child: CachedNetworkImage(
                    imageUrl: url,
                    placeholder: (context, url) => Center(
                      child: Container(
                        color: Colors.grey[800],
                      ),
                    ),
                    errorWidget: (context, url, error) => const Icon(
                      Icons.error,
                      color: Colors.red,
                    ),
                    fit: BoxFit.fill,
                    width: double.infinity,
                  ),
                ),

                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: style.copyWith(color: Colors.white, fontWeight: FontWeight.bold, fontSize: fontSize + 2),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "$age +",
                          style: style,
                        ),
                        SizedBox(height: 5),
                        Text(
                          types,
                          style: style,
                        ),
                        SizedBox(height: 5),
                        Text(
                          des,
                          maxLines: 3,
                          style: style,
                          overflow: TextOverflow.ellipsis,
                        )
                      ],
                    ),
                  ),
                ),
                // Trailing Icon
              ],
            ), // Description
          ],
        ),
      ),
    );
  }
}
