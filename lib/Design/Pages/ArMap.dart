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

class ARMap extends StatefulWidget {
  const ARMap({super.key});

  @override
  State<ARMap> createState() => _ARMapState();
}


class _ARMapState extends State<ARMap> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: primary,
        appBar: AppBar(
          
        ),
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
              ]
          ),
        ),
      ),
    );
  }
}
