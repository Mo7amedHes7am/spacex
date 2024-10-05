import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:readmore/readmore.dart';
import 'package:spacex/Design/Colors/ColorsMethods.dart';
import 'package:spacex/Design/Components/CommentCard.dart';
import 'package:spacex/Methods/Models/PostModel.dart';
import 'package:uuid/uuid.dart';

import '../../NewDesign/NavigationBar/NnavBar.dart';

late PostModel post;
TextEditingController _controller = TextEditingController();
Timer? _timer;

class PostComments extends StatefulWidget {
  PostComments({required PostModel Post}){
    post = Post;
  }

  @override
  State<PostComments> createState() => _PostCommentsState();
}

class _PostCommentsState extends State<PostComments> {

  @override
  void initState() {
    startTimer();
    _controller.text = "";
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

  GetUserData(BuildContext context){
    return StreamBuilder(
        stream:  FirebaseFirestore.instance.collection('posts').doc(post.id).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            post = PostModel.fromMap(snapshot.data!.data()!);
            return DataScreen(context);
          }
          else{
            return Scaffold(body: Center(child: CircularProgressIndicator(color: background,),),);
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return GetUserData(context);
  }

  DataScreen(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Comments (${post.comments.length.toString()})",
            style: TextStyle(
              color: background,
              fontSize: 20.sp,
              fontFamily: "ProtestGuerrilla",
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.start,
          ),
          backgroundColor: Colors.transparent,
          leading: BackButton(color: background,),
          surfaceTintColor: Colors.transparent,
          foregroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
        backgroundColor: primary,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(20.sp),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                        padding:EdgeInsets.only(right:15.sp),
                        child: CircleAvatar(radius: 24.sp,backgroundImage: NetworkImage(user.imgurl),)
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal:8.sp),
                        decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(45.sp)
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal:8.sp),
                          child: TextFormField(
                            controller: _controller,
                            decoration: InputDecoration(
                              labelText: 'Enter Comment...',
                            ),
                            validator: (value) {
                              if (value!.trim().isEmpty) {
                                return 'Please enter A Comment.';
                              }
                              return null;
                            },

                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:EdgeInsets.only(left:15.sp),
                      child: IconButton(
                          onPressed: () async {
                            Map<String, List<dynamic>> comments = post.comments;
                            var uuid = Uuid();
                            var id = uuid.v1().toString().replaceAll('-', '');
                            comments[id] = [id,FirebaseAuth.instance.currentUser!.uid.toString(),_controller.text.toString(),DateTime.now().millisecondsSinceEpoch];
                            await FirebaseFirestore.instance.collection("posts").doc(post.id).update(
                                {
                                  'comments':comments
                                }
                            );
                            _controller.clear();
                          },
                          icon: Icon(FontAwesomeIcons.solidPaperPlane,color: background,size: 24.sp,)
                      ),
                    )
                  ],
                ),
              ),
              ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 20.sp),
                itemCount: post.comments.keys.toList().reversed.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final comment = post.comments[post.comments.keys.toList().reversed.toList()[index]]!;
                  return CommentCard(context: context, comment: comment);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
