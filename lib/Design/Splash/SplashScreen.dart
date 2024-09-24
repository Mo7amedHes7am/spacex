import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:spacex/Design/Auth/Signup.dart';
import 'package:spacex/Design/Colors/ColorsMethods.dart';
import 'package:spacex/Design/Main/Home.dart';
import 'package:spacex/main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<SplashScreen> {

  @override
  void initState() {
    Future.delayed(Duration(seconds: 3)).then((value) {
      if (FirebaseAuth.instance.currentUser != null) {
        Get.off(HomePage());
      }else{
        Get.off(SignUpScreen());
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:background,
      body: Container(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height,
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/galaxy.gif"),fit: BoxFit.fill)
        ),
        child: Center(
          child: Text("Storm-X",style: TextStyle(
            fontFamily: "ProtestGuerrilla",
            color: background,
            fontWeight: FontWeight.w700,
            fontSize: 72.sp
          ),),
        ),
      ),
    );
  }
}
