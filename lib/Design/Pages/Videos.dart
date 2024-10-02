import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spacex/Design/Colors/ColorsMethods.dart';
import 'package:spacex/Methods/Models/ExploreModel.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

late ExploreModel vid;

late YoutubePlayerController _controller;

class VideoScreen extends StatefulWidget {
  VideoScreen({required ExploreModel video}){
    vid = video;
    _controller = YoutubePlayerController(
      initialVideoId: video.sourcelink.split('https://youtu.be/')[1],
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
        loop: false,
        showLiveFullscreenButton: false
      ),
    );
  }

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {


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
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: primary,
        appBar: AppBar(
          leading: BackButton(color: background,style: ButtonStyle(iconSize: WidgetStatePropertyAll(32.sp)),),
          title: Text(vid.title,
            style: TextStyle(
                fontSize: 24.sp,
                color: background,
                fontWeight: FontWeight.bold,
                fontFamily: "Droid Arabic"
            ),
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          leadingWidth: 40.sp,
        ),
        body: SingleChildScrollView(
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
                      width: 220.sp,
                      padding: EdgeInsets.all(8.sp),
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(15.sp)
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Open External",
                              style: TextStyle(
                                fontSize: 24.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Droid Arabic",
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Icon(Icons.subdirectory_arrow_left_outlined,color: Colors.white,)
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h,),
                  InkWell(
                    onTap: () async {

                    },
                    child: Container(
                      width: 300.sp,
                      padding: EdgeInsets.all(8.sp),
                      decoration: BoxDecoration(
                          color: silverdark,
                          borderRadius: BorderRadius.circular(15.sp)
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("View AR Explanation",
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
                  SizedBox(height:50.h)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
