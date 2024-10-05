import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:spacex/Design/Colors/ColorsMethods.dart';
import 'package:spacex/Methods/Models/ExploreModel.dart';
import 'package:spacex/NewDesign/NavigationBar/NnavBar.dart';
import 'package:spacex/NewDesign/Pages/ARPage.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

late ExploreModel vid;
int i = 0;
late YoutubePlayerController _controller;

class May2024 extends StatefulWidget {
  const May2024({super.key});

  @override
  State<May2024> createState() => _May2024State();
}

class _May2024State extends State<May2024> {

  @override
  void deactivate() {
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    vid = ExploreModel(
        id: "LhqKGKHdnYxofsQeKwjh",
        datatype: "video",
        imgurl: NetworkImage("https://firebasestorage.googleapis.com/v0/b/exa-spacex.appspot.com/o/mq2.webp?alt=media&token=84efe837-856b-4da4-bf3b-f9ca3571dce6"),
        source: "Storm-X Youtube",
        sourcelink: "https://youtu.be/S1PgEgjX3JM",
        subtitle: "Video Explantion",
        title: "Global geomagnetic storm and aurora activity",
        type: 1,
        content: ["This introductory video is designed to educate you about the May 2024 geomagnetic storm and its effects."],
        datetime: 0
    );
    _controller = YoutubePlayerController(
      initialVideoId: vid.sourcelink.split('https://youtu.be/')[1],
      flags: YoutubePlayerFlags(
          autoPlay: true,
          mute: false,
          loop: false,
          showLiveFullscreenButton: false
      ),
    );
    i=0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: primary,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(vid.title,
            style: TextStyle(
                fontSize: 24.sp,
                color: background,
                fontWeight: FontWeight.bold,
                fontFamily: "Droid Arabic"
            ),
            maxLines: 2,
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          toolbarHeight: 80.sp,
        ),
        body: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage('assets/star.png'),opacity: 0.03,repeat: ImageRepeat.repeat)
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 50.sp,),
                Center(
                  child: Container(
                    width: MediaQuery.sizeOf(context).width-40.sp,
                    height: MediaQuery.sizeOf(context).width-40.sp,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.sp)
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15.sp),
                      child: YoutubePlayerBuilder(

                        onExitFullScreen: () {
                          SystemChrome.setPreferredOrientations(DeviceOrientation.values);
                        },
                        player: YoutubePlayer(
                          controller: _controller,
                          showVideoProgressIndicator: true,
                          progressIndicatorColor: primary,
                          progressColors: ProgressBarColors(
                            playedColor: primary,
                            handleColor: background,
                          ),
                          onReady:() {
                            print("ready");
                            _controller.play();
                            // _controller.addListener(listener);
                          },
                        ),
                        builder:(p0, p1) =>p1,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30.sp,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.sp),
                  child: Text(vid.content[0],
                    style: TextStyle(
                        fontSize: 20.sp,
                        color: background,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Calibri",
                        letterSpacing: 1.5,
                        height: 2.sp
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
                SizedBox(height: 30.sp,),
                Column(
                  children: [
                    InkWell(
                      onTap: () async {
                        await launchUrl( Uri.parse(vid.sourcelink));
                      },
                      child: Container(
                        width: 280.sp,
                        padding: EdgeInsets.all(10.sp),
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(15.sp)
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Watch On Youtube",
                                style: TextStyle(
                                  fontSize: 24.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Droid Arabic",
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Icon(FontAwesomeIcons.youtube,color: Colors.white,size: 24.sp,)
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () async {
                            Get.off(ARScreen());
                          },
                          child: Container(
                            width: 250.w,
                            padding: EdgeInsets.all(8.sp),
                            decoration: BoxDecoration(
                                color: silverdark,
                                borderRadius: BorderRadius.circular(15.sp)
                            ),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Continue To AR",
                                    style: TextStyle(
                                      fontSize: 24.sp,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Droid Arabic",
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  Icon(Icons.remove_red_eye_outlined,color: Colors.white,)
                                ],
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            await FirebaseFirestore.instance.collection("may2024").doc(FirebaseAuth.instance.currentUser!.uid)
                                .set(
                                {
                                  'step':1
                                }
                            );
                            Get.offAll(NnavbarScreen());
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical:8.sp,horizontal: 20.sp),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15.sp)
                            ),
                            child: Center(
                              child: Text("Skip",
                                style: TextStyle(
                                  fontSize: 24.sp,
                                  color: primary,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Droid Arabic",
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height:50.h)
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
