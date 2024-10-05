import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:spacex/Design/Colors/ColorsMethods.dart';
import 'package:spacex/NewDesign/May2024/May2024.dart';

class IntroMay2024Screen extends StatefulWidget {
  const IntroMay2024Screen({super.key});

  @override
  State<IntroMay2024Screen> createState() => _IntroMay2024ScreenState();
}

class _IntroMay2024ScreenState extends State<IntroMay2024Screen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: MediaQuery.sizeOf(context).height,
          width: MediaQuery.sizeOf(context).width,
          decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage('assets/make3.gif'),fit: BoxFit.cover)
          ),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20.sp,vertical: 20.sp),
              padding: EdgeInsets.all(8.sp),
              width: MediaQuery.sizeOf(context).width,
              constraints: BoxConstraints(
                  maxHeight: 200.sp
              ),
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(15.sp)
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("Welcome To May 2024 Magnetic Storm Journey",
                    style: TextStyle(
                        fontSize: 22.sp,
                        color: background,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Calibri"
                    ),
                    textAlign: TextAlign.center,
                  ),
                  InkWell(
                    onTap: () async {
                      await FirebaseFirestore.instance.collection("may2024").doc(FirebaseAuth.instance.currentUser!.uid)
                          .set(
                        {
                          'step':0
                          }
                      );
                      Get.off(May2024());
                    },
                    child: Container(
                      padding: EdgeInsets.all(10.sp),
                      decoration: BoxDecoration(
                        color: primary,
                        borderRadius: BorderRadius.circular(45.sp)
                      ),
                      child: Text("Lets Get Started",
                        style: TextStyle(
                            fontSize: 16.sp,
                            color: background,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Calibri"
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
