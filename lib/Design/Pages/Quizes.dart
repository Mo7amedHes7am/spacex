import 'dart:async';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_common/get_reset.dart';
import 'package:spacex/Design/Colors/ColorsMethods.dart';
import 'package:spacex/Design/Main/Home.dart';
import 'package:spacex/Design/Pages/Videos.dart';
import 'package:spacex/Methods/GlobalMethods.dart';
import 'package:spacex/Methods/Models/QuizModel.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:spacex/NewDesign/Pages/SuccessScreen.dart';

late QuizModel quiz;
bool take = false;
bool reveal = false;
bool finish = false;
Timer? _timer;
int total = 0;
late AudioPlayer player = AudioPlayer();

int corrects = 0;
late int timetaken;
late int timefinish;
class QuizScreen extends StatefulWidget {
  QuizScreen({required QuizModel Quiz}){
    quiz = Quiz;
  }

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {

  @override
  void initState() {
    startTimer();
    reveal = false;
    take = false;
    finish = false;
    corrects = 0;
    total = 0;
    player = AudioPlayer();
    player.setReleaseMode(ReleaseMode.stop);
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
        if (take) {
          if (timefinish>timetaken) {
            timefinish-=1000;
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return take?QuizPage(context):Home(context);
  }

  QuizPage(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: primary,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20.sp),
            child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.timer,color: timefinish-timetaken<=5000?CupertinoColors.destructiveRed:background,size: 24.sp,),
                      SizedBox(width: 15.sp,),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(printDuration(timetaken,timefinish),
                          style: TextStyle(
                              fontSize: 20.sp,
                              color: timefinish-timetaken<=5000?CupertinoColors.destructiveRed:background,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Droid Arabic"
                          ),
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 50.h,),
                  Text("Question ${total+1} out of ${quiz.questions.length}",
                    style: TextStyle(
                        fontSize: 20.sp,
                        color: background,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Droid Arabic"
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20.h,),
                  Text(quiz.questions.keys.toList()[total],
                    style: TextStyle(
                        fontSize: 24.sp,
                        color: background,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Droid Arabic"
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 50.h,),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: quiz.questions[quiz.questions.keys.toList()[total]]!.length,
                    itemBuilder: (context, index) {
                      final answer = quiz.questions[quiz.questions.keys.toList()[total]]![index];
                      final q = quiz.answers[quiz.questions.keys.toList()[total]]!;
                      return Column(
                        children: [
                          InkWell(
                            onTap:(){
                              if (!reveal && q==index) {
                                corrects += 1;
                                WidgetsBinding.instance.addPostFrameCallback((_) async {
                                  await player.setSource(AssetSource('audio/correct.mp3'));
                                  await player.resume();
                                });
                                // AssetsAudioPlayer.newPlayer().open(
                                //   Audio("audio/right.mp3"),
                                //   autoStart: true,
                                //   showNotification: true,
                                // );
                              }else if(!reveal && q!=index){
                                WidgetsBinding.instance.addPostFrameCallback((_) async {
                                  await player.setSource(AssetSource('audio/wrong.mp3'));
                                  await player.resume();
                                });
                              }
                              setState(() {
                                reveal = true;
                              });

                            },
                            child: Container(
                              padding: EdgeInsets.all(10.sp),
                              decoration: BoxDecoration(
                                  color: (reveal && q==index)?CupertinoColors.activeGreen:reveal?CupertinoColors.destructiveRed:Colors.white,
                                  borderRadius: BorderRadius.circular(15.sp)
                              ),
                              child: Center(
                                child: Text(answer,
                                  style: TextStyle(
                                      fontSize: 20.sp,
                                      color: primary,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Calibri"
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20.h,)
                        ],
                      );
                    },
                  ),
                  reveal?InkWell(
                    onTap:(){
                      setState(() async {
                        if (total==quiz.questions.length-1) {
                          if (corrects>=1) {
                            await FirebaseFirestore.instance.collection("may2024").doc(FirebaseAuth.instance.currentUser!.uid)
                                .set(
                                {
                                  'step':4
                                }
                            );
                            Get.off(Successscreen());
                          }else{
                            final snackBar = SnackBar(
                              duration: Duration(milliseconds: 1500,),
                              elevation: 0,
                              behavior: SnackBarBehavior.floating,
                              backgroundColor: Colors.transparent,
                              content: AwesomeSnackbarContent(
                                title: 'Sorry',
                                message: 'Please Focus And Try Again!',
                                contentType: ContentType.failure,
                              ),
                            );
                            ScaffoldMessenger.of(context)
                              ..hideCurrentSnackBar()
                              ..showSnackBar(snackBar);
                          }
                          take = false;
                        }
                        reveal = false;
                        total+=1;
                      });

                    },
                    child: Container(
                      padding: EdgeInsets.all(10.sp),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15.sp)
                      ),
                      child: Center(
                        child: Text(total==quiz.questions.length-1?'Finish':"Next Question",
                          style: TextStyle(
                              fontSize: 20.sp,
                              color: primary,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Calibri"
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ):SizedBox(),
                ]
            ),
          ),
        ),
      ),
    );
  }

  Home(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,
      appBar: AppBar(
        leading: BackButton(color: background,style: ButtonStyle(iconSize: WidgetStatePropertyAll(32.sp)),),
        title: Text(quiz.title,
          style: TextStyle(
              fontSize: 18.sp,
              color: background,
              fontWeight: FontWeight.bold,
              fontFamily: "Droid Arabic"
          ),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        leadingWidth: 40.sp,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.sp),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: MediaQuery.sizeOf(context).width-40.sp,
                  height: 300.sp,
                  decoration: BoxDecoration(
                      image: DecorationImage(image: quiz.imgurl,fit: BoxFit.cover),
                      borderRadius: BorderRadius.circular(15.sp)
                  ),
                ),
              ),
              SizedBox(height: 20.sp,),
              Text(quiz.title,
                style: TextStyle(
                    fontSize: 24.sp,
                    color: background,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Droid Arabic"
                ),
                textAlign: TextAlign.start,
              ),
              SizedBox(height: 20.sp,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 100.sp,
                    height: 100.sp,
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(15.sp)
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.question_mark,size: 50.sp,color: background,),
                          Text(quiz.questions.keys.where((element) => element.contains("easy"),).toList().length.toString() + " Questions",
                            style: TextStyle(
                                fontSize: 14.sp,
                                color: background,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Droid Arabic"
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 100.sp,
                    height: 100.sp,
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(15.sp)
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(FontAwesomeIcons.coins,size: 40.sp,color: background,),
                          Text("Up To ${quiz.points.last} Points",
                            style: TextStyle(
                                fontSize: 14.sp,
                                color: background,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Droid Arabic"
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 100.sp,
                    height: 100.sp,
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(15.sp)
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(FontAwesomeIcons.graduationCap,size: 50.sp,color: background,),
                          Text("${quiz.passed>=1000?quiz.passed>=1000000?'${quiz.passed~/1000000} M':'${quiz.passed~/1000} K':quiz.passed.toString()} Passed This",
                            style: TextStyle(
                                fontSize: 14.sp,
                                color: background,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Droid Arabic"
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.sp,),
              Text(quiz.description,
                style: TextStyle(
                    fontSize: 18.sp,
                    color: background,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Droid Arabic"
                ),
                textAlign: TextAlign.start,
              ),
              SizedBox(height: 20.sp,),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        if (quiz.focusedtype=="video") {
                          Get.to(VideoScreen(video: explore_items[quiz.focusedid]!));
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.all(8.sp),
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(15.sp)
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text((quiz.focusedtype !="article" && quiz.focusedtype !="pdf")?'Watch ${quiz.focusedtype.toString().toUpperCase()}':'Read ${quiz.focusedtype.toString().toUpperCase()}',
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    color: background,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Droid Arabic"
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Icon((quiz.focusedtype !="article" && quiz.focusedtype !="pdf")?FontAwesomeIcons.video:FontAwesomeIcons.book,size: 35.sp,color: background,),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 30.sp,),
                  Expanded(
                    child: InkWell(
                      onTap: () async{
                        timetaken = DateTime.now().millisecondsSinceEpoch;
                        timefinish = DateTime.now().millisecondsSinceEpoch+quiz.time;
                        take=true;
                        setState(() {
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.all(8.sp),
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(15.sp)
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text('Take Quiz',
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    color: background,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Droid Arabic"
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Icon(Icons.quiz,size: 35.sp,color: background,),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
