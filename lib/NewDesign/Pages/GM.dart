import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:spacex/Design/Colors/ColorsMethods.dart';
import 'package:spacex/NewDesign/NavigationBar/NnavBar.dart';
import 'package:spacex/NewDesign/Pages/GameClass.dart';
import 'package:spacex/NewDesign/Pages/QuizPage.dart';

class Gm extends StatefulWidget {
  const Gm({super.key});

  @override
  State<Gm> createState() => _GmState();
}

List<Widget> pieces = [];

class _GmState extends State<Gm> {

  @override
  void initState() {
    pieces.clear();
    splitImage(Image.asset('assets/puzzle.jpg'));
    super.initState();
  }


  void splitImage(Image image) async {

    for (int x = 0; x < 3; x++) {
      for (int y = 0; y < 3; y++) {
        setState(() {
          pieces.add(PuzzlePiece(
              bringToTop: bringToTop,
              sendToBack: sendToBack,
              image: image,
              imageSize: Size(400.sp, 240.sp),
              row: x,
              col: y,
              maxRow: 3,
              maxCol: 3));
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: primary,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.transparent,
          leading: BackButton(color: Colors.white,),
          surfaceTintColor: Colors.transparent,
          title: Text("Complete The Puzzle",
            style: TextStyle(
                color: Colors.white,
                fontFamily: 'Calibri',
                fontSize: 24.sp,
                fontWeight: FontWeight.bold
            ),),
          centerTitle: true,
        ),
        body: new Center(
            child: Column(
              children: [
                SizedBox(
                  width: MediaQuery.sizeOf(context).width,
                  height: MediaQuery.sizeOf(context).height*0.75,
                  child: Stack(
                      children: [
                        Center(
                          child: Container(
                            width: 400.sp,
                            height: 240.sp,
                            decoration: BoxDecoration(
                                image: DecorationImage(image: AssetImage('assets/puzzle.jpg'),opacity: 0.3,fit: BoxFit.cover),
                                border: Border.all(color: Colors.white,width: 2.sp)
                            ),
                          ),
                        ),
                        Stack(children: pieces),

                      ]
                  ),
                ),

              ],
            )
        ),
      ),
    );
  }

  // when the pan of a piece starts, we need to bring it to the front of the stack
  void bringToTop(Widget widget) {
    setState(() {
      pieces.remove(widget);
      pieces.add(widget);
    });
  }

// when a piece reaches its final position, it will be sent to the back of the stack to not get in the way of other, still movable, pieces
  void sendToBack(Widget widget) {
    setState(() {
      pieces.remove(widget);
      pieces.insert(0, widget);
    });
  }

}
