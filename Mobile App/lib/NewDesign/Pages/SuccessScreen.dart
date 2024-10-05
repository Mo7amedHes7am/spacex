import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:spacex/Design/Colors/ColorsMethods.dart';
import 'package:spacex/NewDesign/NavigationBar/NnavBar.dart';

class Successscreen extends StatefulWidget {
  const Successscreen({super.key});

  @override
  State<Successscreen> createState() => _SuccessscreenState();
}

class _SuccessscreenState extends State<Successscreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Container(
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height,
            decoration:BoxDecoration(
              color: primary,
              image: DecorationImage(image: AssetImage('assets/star.png'),opacity: 0.1,repeat: ImageRepeat.repeat)
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Congratulations",
                  style: TextStyle(
                      fontSize: 32.sp,
                      color: background,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Droid Arabic"
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20.h,),
                Text("You Earned\nMay 2024 Magnetic Storm Certificate",
                  style: TextStyle(
                      fontSize: 24.sp,
                      color: background,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Droid Arabic"
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20.h,),
                InkWell(
                  onTap: () {
                    final imageProvider = Image.network(
                        'https://moon.nasa.gov/rails/active_storage/blobs/redirect/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBBcElNIiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--791d73db148fb206e3935904b213ebed898ff4ed/2024-certificate.jpg'
                    ).image;
                    showImageViewer(context, imageProvider, onViewerDismissed: () {
                      print("dismissed");
                    });
                  },
                  child: Container(
                    height: 250.sp,
                    width: 350.sp,
                    decoration: BoxDecoration(
                      image: DecorationImage(image: NetworkImage('https://moon.nasa.gov/rails/active_storage/blobs/redirect/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBBcElNIiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--791d73db148fb206e3935904b213ebed898ff4ed/2024-certificate.jpg'),fit: BoxFit.cover,)
                    ),
                  ),
                ),
                SizedBox(height: 20.h,),
                Text("And Got 2000 Points",
                  style: TextStyle(
                      fontSize: 24.sp,
                      color: background,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Droid Arabic"
                  ),
                  textAlign: TextAlign.center,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: SizedBox(
                    width: 300.sp,
                    height: 200.sp,
                    child: Stack(
                      children: [
                        Container(
                          height: 200.sp,
                          width: 200.sp,
                          decoration: BoxDecoration(
                              image: DecorationImage(image: AssetImage('assets/image.png'),fit: BoxFit.cover,)
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: InkWell(
                            onTap: () async {
                              await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).update(
                                  {'points':2000});
                              Get.off(NnavbarScreen());
                            },
                            child: Container(
                              height: 60.sp,
                              width: 200.sp,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                borderRadius: BorderRadius.circular(45.sp)
                              ),
                              child: Center(
                                child: Text("Get Points",
                                  style: TextStyle(
                                      fontSize: 24.sp,
                                      color: primary,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Droid Arabic"
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ]
                    ),
                  ),
                ),

              ],
            ),
          ),
      )
    );
  }
}
