import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spacex/Design/Auth/forgot_screen.dart';
import 'package:spacex/Design/Colors/ColorsMethods.dart';
import 'package:spacex/Design/Components/PostCard.dart';
import 'package:spacex/Design/NavigationBar/NavBar.dart';
import 'package:spacex/Methods/Models/PostModel.dart';
import 'package:spacex/Methods/Models/UserModel.dart';

List<PostModel> posts = [];
List<UserModel> users = [];
Timer? _timer;

class CommunityPage extends StatefulWidget {
  const CommunityPage({super.key});

  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  @override
  Widget build(BuildContext context) {
    return GetPosts(context);
  }
  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
      });
    });
  }

  GetPosts(BuildContext context){
    return StreamBuilder(
        stream:  FirebaseFirestore.instance.collection('posts').orderBy('submittedat',descending: true).snapshots(),
        builder: (context, snapshot) {
          posts.clear();
          if (snapshot.hasData) {
            for(var data in snapshot.data!.docs){
              posts.add(PostModel.fromMap(data.data()));
            }
            return GetUsers(context);
          }
          else if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(body: Center(child: CircularProgressIndicator(color: primary,),),);
          }
          else{
            return GetUsers(context);
          }
        });
  }

  GetUsers(BuildContext context){
    return StreamBuilder(
        stream:  FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          users.clear();
          if (snapshot.hasData) {
            for(var data in snapshot.data!.docs){
              users.add(UserModel.fromMap(data.data()));
            }
            return DataScreen(context);
          }
          else if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(body: Center(child: CircularProgressIndicator(color: primary,),),);
          }
          else{
            return DataScreen(context);
          }
        });
  }

  DataScreen(BuildContext context){
    return Scaffold(
      backgroundColor: primary,
      appBar: AppBar(
        title: Row(
          children: [
            Text("Discover",
              style: TextStyle(
                  color: background,
                  fontSize: 24.sp,
                  fontFamily: "Senmoly Caligan",
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2
              ),
            ),
            SizedBox(width: 10.sp,),
            Image.network(
              "https://firebasestorage.googleapis.com/v0/b/exa-spacex.appspot.com/o/nasa-logo.png?alt=media&token=1118961f-ca8c-457a-b469-cf16aaf38127",
              width: 30.sp,
            ),
          ],
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        foregroundColor: Colors.transparent,
        actions: [
          CircleAvatar(radius: 20.sp,backgroundImage: NetworkImage(user.imgurl)),
          SizedBox(width: 20.sp,)
        ],
      ),
      body: ListView.builder(
        itemCount: posts.length,
        padding: EdgeInsets.only(left: 20.sp,top: 15.sp,right: 20.sp,bottom: 80.sp),
        itemBuilder: (context, index) {
          final post = posts[index];
          return PostCard(context: context, post: post);
        },
      ),
    );
  }

}
