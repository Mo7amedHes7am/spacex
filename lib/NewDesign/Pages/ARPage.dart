import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_embed_unity/flutter_embed_unity.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:spacex/Design/Colors/ColorsMethods.dart';
import 'package:spacex/NewDesign/NavigationBar/NnavBar.dart';
import 'package:spacex/NewDesign/Pages/GamePage.dart';

class ARScreen extends StatefulWidget {
  const ARScreen({super.key});

  @override
  State<ARScreen> createState() => _ARScreenState();
}


class _ARScreenState extends State<ARScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: primary,
        body: SingleChildScrollView(
          child: Column(
            children:[
              SizedBox(
                width: MediaQuery.sizeOf(context).width,
                height: MediaQuery.sizeOf(context).height-150.h,
                child: EmbedUnity(
                  onMessageFromUnity: (String message) {
                    // Receive message from Unity sent via SendToFlutter.cs
                  },
                ),
              ),
              SizedBox(height: 20.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () async {
                      Get.off(GameScreen());
                    },
                    child: Container(
                      width: 270.w,
                      padding: EdgeInsets.all(10.sp),
                      decoration: BoxDecoration(
                          color: silverdark,
                          borderRadius: BorderRadius.circular(15.sp)
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Continue To Game",
                              style: TextStyle(
                                fontSize: 24.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Droid Arabic",
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Icon(FontAwesomeIcons.gamepad,color: Colors.white,)
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
                            'step':2
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
            ]
          ),
        ),
      ),
    );
  }
}
