import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:readmore/readmore.dart';
import 'package:spacex/Design/Colors/ColorsMethods.dart';
import 'package:spacex/Methods/GlobalMethods.dart';
import 'package:spacex/Methods/Models/PostModel.dart';

Widget PostCard({
  required BuildContext context,
  required PostModel post
}){
  return Column(
    children: [
      Container(
        width: MediaQuery.sizeOf(context).width,
        padding: EdgeInsets.all(10.sp),
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(15.sp)
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment:MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage('assets/sun.jpg'),
                      radius: 20.sp,
                    ),
                    SizedBox(width: 12.sp,),
                    Text("Nasa Space Agency",
                      style: TextStyle(
                          color: primary,
                          fontSize: 12.sp,
                          fontFamily: "Fredoka",
                          fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Text(lastSeenMessage(1715374800000),
                  style: TextStyle(
                    color: primary,
                    fontSize: 12.sp,
                    fontFamily: "Fredoka",
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 25.sp,),
            Text("Mohamed Hesham Mohamed Hesham Mohamed Hesham Mohamed Hesham",
              style: TextStyle(
                color: primary,
                fontSize: 20.sp,
                fontFamily: "ProtestGuerrilla",
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.sp,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.sp),
              child: ReadMoreText(
                'Flutter is Google’s mobile UI open source framework to build high-quality native (super fast) interfaces for iOS and Android apps with the unified codebase.',
                trimMode: TrimMode.Line,
                trimLines: 3,
                style: TextStyle(
                  color: primary,
                  fontSize: 14.sp,
                  fontFamily: "Droid Arabic",
                ),
                lessStyle: TextStyle(
                  color: primary,
                  fontSize: 14.sp,
                  fontFamily: "Droid Arabic",
                  fontWeight: FontWeight.bold,
                ),
                colorClickableText: Colors.pink,
                trimCollapsedText: 'Show more',
                trimExpandedText: 'Show less',
                moreStyle: TextStyle(
                  color: primary,
                  fontSize: 14.sp,
                  fontFamily: "Droid Arabic",
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 10.sp,),
            InkWell(
              onTap: (){
                final imageProvider = Image.network(
                    "https://eoimages.gsfc.nasa.gov/images/imagerecords/152000/152815/auroraborealis_vir_20240511.jpg"
                ).image;
                showImageViewer(context, imageProvider, onViewerDismissed: () {
                  print("dismissed");
                });
              },
              child: Container(
                width: 350.sp,
                height: 200.sp,
                padding: EdgeInsets.all(0),
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                          "https://eoimages.gsfc.nasa.gov/images/imagerecords/152000/152815/auroraborealis_vir_20240511.jpg"
                      ),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(15.sp)
                ),
              ),
            ),
            SizedBox(height: 10.sp,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {

                        },
                        icon: Icon(FontAwesomeIcons.thumbsUp,size: 24.sp,)
                      ),
                      Text("20",
                        style: TextStyle(
                          color: primary,
                          fontSize: 16.sp,
                          fontFamily: "ProtestGuerrilla",
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {

                          },
                          icon: Icon(FontAwesomeIcons.comments,size: 24.sp,)
                      ),
                      Text("250",
                        style: TextStyle(
                          color: primary,
                          fontSize: 16.sp,
                          fontFamily: "ProtestGuerrilla",
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {

                          },
                          icon: Icon(FontAwesomeIcons.share,size: 24.sp,)
                      ),
                      Text("25",
                        style: TextStyle(
                          color: primary,
                          fontSize: 16.sp,
                          fontFamily: "ProtestGuerrilla",
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      SizedBox(height:20.sp)
    ],
  );
}