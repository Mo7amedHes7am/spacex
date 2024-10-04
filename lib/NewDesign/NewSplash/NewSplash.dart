import 'dart:async';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:spacex/Design/Auth/Signup.dart';
import 'package:spacex/Design/Colors/ColorsMethods.dart';
import 'package:spacex/Design/NavigationBar/NavBar.dart';
import 'package:spacex/NewDesign/NavigationBar/NnavBar.dart';

class NewSplashScreen extends StatefulWidget {
  const NewSplashScreen({super.key});

  @override
  State<NewSplashScreen> createState() => _NewSplashScreenState();
}

Timer? _timer;

late String fact;
List<String> randoms = [
  "Space weather is a branch of space physics and aeronomy, or heliophysics, concerned with the varying conditions within the Solar System and its heliosphere.",
  "Some spacecraft failures can be directly attributed to space weather; many more are thought to have a space weather component.",
  "Space weather effects on satellites depend on their orbits.",
  "Aeromagnetic surveys are flown to help locate various mineral resources.",
  "High-energy particles and radiation from the sun can heat Earth’s atmosphere as they collide with common molecules, like nitrogen and oxygen.",
  "The heated air rises and causes the upper atmosphere to expand like a balloon.",
  "If an electromagnetic storm is strong enough, the atmosphere can expand so much that it engulfs the orbits of low-Earth-orbit satellites, slowing them down and decreasing their altitude. This process is called orbital drag.",
  "Gases and particles stream from the sun to Earth at speeds of a million mph. This stream is called the solar wind. Even though the sun is 93 million miles (150 million kilometers) from Earth, the solar wind can affect Earth and the rest of the solar system.",
];

class _NewSplashScreenState extends State<NewSplashScreen> {

  @override
  void initState() {
    startTimer();
    fact = randoms[Random().nextInt(randoms.length)];
    Future.delayed(Duration(seconds: 3)).then((value) {
      if (FirebaseAuth.instance.currentUser != null) {
        Get.off(NnavbarScreen());
      }else{
        Get.off(SignUpScreen());
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      setState(() {
        fact = randoms[Random().nextInt(randoms.length)];
      });
    });
  }


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
                  Text("Did You Know ?",
                    style: TextStyle(
                        fontSize: 22.sp,
                        color: background,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Calibri"
                    ),
                    textAlign: TextAlign.start,
                  ),
                  Text(fact,
                    style: TextStyle(
                        fontSize: 16.sp,
                        color: background,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Calibri"
                    ),
                    textAlign: TextAlign.center,
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
