import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';
import 'package:share_plus/share_plus.dart';
import 'package:spacex/Design/Colors/ColorsMethods.dart';
import 'package:spacex/Design/Pages/PostComments.dart';
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
                      backgroundImage: NetworkImage(post.sender[0]),
                      radius: 20.sp,
                    ),
                    SizedBox(width: 12.sp,),
                    Text(post.sender[1],
                      style: TextStyle(
                          color: primary,
                          fontSize: 12.sp,
                          fontFamily: "Fredoka",
                          fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Text(lastSeenMessage(post.submittedat),
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
            Text(post.title,
              style: TextStyle(
                color: primary,
                fontSize: 20.sp,
                fontFamily: "Calibri",
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.sp,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.sp),
              child: ReadMoreText(
                post.content,
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
            post.imgurl=="noimg"?SizedBox(height: 0,):SizedBox(height: 10.sp,),
            post.imgurl=="noimg"?SizedBox(height: 0,):InkWell(
              onTap: (){
                final imageProvider = Image.network(
                    post.imgurl
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
                          post.imgurl
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
                        onPressed: () async {
                          if (post.likes.contains(FirebaseAuth.instance.currentUser!.uid)) {
                            var likes = post.likes;
                            await likes.remove(FirebaseAuth.instance.currentUser!.uid);
                            FirebaseFirestore.instance.collection("posts").doc(post.id).update({
                              'likes':likes
                            });
                          }else{
                            var likes = post.likes;
                            likes.add(FirebaseAuth.instance.currentUser!.uid);
                            await FirebaseFirestore.instance.collection("posts").doc(post.id).update({
                              'likes':likes
                            });
                          }
                        },
                        icon: Icon(post.likes.contains(FirebaseAuth.instance.currentUser!.uid)?
                        FontAwesomeIcons.solidThumbsUp:FontAwesomeIcons.thumbsUp,size: 24.sp,)
                      ),
                      Text(post.likes.length.toString(),
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
                            Get.to(PostComments(Post: post));
                          },
                          icon: Icon(FontAwesomeIcons.comments,size: 24.sp,)
                      ),
                      Text(post.comments.length.toString(),
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
                            Share.share('from *Nasa*\n${post.title}\n${post.content}');
                            int shares = post.shares;
                            FirebaseFirestore.instance.collection("posts").doc(post.id).update({
                              'shares':post.shares+1
                            });
                          },
                          icon: Icon(FontAwesomeIcons.share,size: 24.sp,)
                      ),
                      Text(post.shares.toString(),
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