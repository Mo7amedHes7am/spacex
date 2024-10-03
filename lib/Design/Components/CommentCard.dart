import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:readmore/readmore.dart';
import 'package:spacex/Design/Colors/ColorsMethods.dart';
import 'package:spacex/Design/Main/Community.dart';
import 'package:spacex/Methods/GlobalMethods.dart';

Widget CommentCard({
  required BuildContext context,
  required List<dynamic> comment
}){
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(backgroundImage: NetworkImage(users.where((element) => element.id==comment[1],).toList()[0].imgurl),radius: 18.sp,),
              SizedBox(width: 10.sp,),
              Text(users.where((element) => element.id==comment[1],).toList()[0].fname + " " + users.where((element) => element.id==comment[1],).toList()[0].lname,
                style: TextStyle(
                  color: primary,
                  fontSize: 16.sp,
                  fontFamily: "ProtestGuerrilla",
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.start,
              ),
            ],
          ),
          Text(lastSeenMessage(comment[3]),
            style: TextStyle(
              color: primary,
              fontSize: 12.sp,
              fontFamily: "Fredoka",
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      Padding(
        padding: EdgeInsets.all(15.sp),
        child: ReadMoreText(
          comment[2],
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
          textAlign: TextAlign.start,
        ),
      ),
      SizedBox(height: 20.sp,)
    ],
  );
}