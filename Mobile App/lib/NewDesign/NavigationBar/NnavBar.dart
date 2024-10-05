import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:spacex/Design/Colors/ColorsMethods.dart';
import 'package:spacex/Design/Main/Community.dart';
import 'package:spacex/Design/Main/Home.dart';
import 'package:spacex/Methods/Models/UserModel.dart';
import 'package:spacex/NewDesign/Main/nHomeScreen.dart';

late UserModel user;

class NnavbarScreen extends StatefulWidget {
  const NnavbarScreen({super.key});

  @override
  State<NnavbarScreen> createState() => _NnavbarScreenState();
}

int _currentIndex = 0;
final List<Widget> pages = [NHomeScreen(), CommunityPage(), HomePage(), HomePage(),HomePage()];

class _NnavbarScreenState extends State<NnavbarScreen> {

  GetUserData(BuildContext context){
    return StreamBuilder(
        stream:  FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            user = UserModel.fromMap(snapshot.data!.data()!);
            return DataScreen(context);
          }
          else{
            return Scaffold(body: Center(child: CircularProgressIndicator(color: primary,),),);
          }
        });
  }


  @override
  Widget build(BuildContext context) {
    return GetUserData(context);
  }

  DataScreen(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: pages[_currentIndex],
        extendBody: true,
        bottomNavigationBar: CustomNavigationBar(
          iconSize: 30.sp,
          selectedColor: background,
          strokeColor: background,
          unSelectedColor: Colors.grey,
          opacity: 0.5,
          backgroundColor: Colors.white.withOpacity(0.3),
          items: [
            CustomNavigationBarItem(
              icon: Icon(Icons.home,size: 30.sp,),
              title: Text("Home",
                style: TextStyle(
                  color: _currentIndex==0?Colors.white:Colors.grey,
                  fontWeight: _currentIndex==0?FontWeight.bold:FontWeight.w300,
                  fontSize: 15.sp,
                  fontFamily: "Calibri"
                ),
              ),
            ),
            CustomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.signsPost,size: 30.sp,),
              title: Text("Community",
                style: TextStyle(
                    color: _currentIndex==1?Colors.white:Colors.grey,
                    fontWeight: _currentIndex==1?FontWeight.bold:FontWeight.w300,
                    fontSize: 15.sp,
                    fontFamily: "Calibri"
                ),
              ),
            ),
            CustomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.gamepad,size: 30.sp,),
              title: Text("Games",
                style: TextStyle(
                    color: _currentIndex==2?Colors.white:Colors.grey,
                    fontWeight: _currentIndex==2?FontWeight.bold:FontWeight.w300,
                    fontSize: 15.sp,
                    fontFamily: "Calibri"
                ),),
            ),
            CustomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.chartColumn,size: 30.sp,),
              title: Text("Charts",
                style: TextStyle(
                    color: _currentIndex==3?Colors.white:Colors.grey,
                    fontWeight: _currentIndex==3?FontWeight.bold:FontWeight.w300,
                    fontSize: 15.sp,
                    fontFamily: "Calibri"
                ),
              ),
            ),
            CustomNavigationBarItem(
              icon: Icon(Icons.account_circle,size: 30.sp,),
              title: Text("Profile",
                style: TextStyle(
                    color: _currentIndex==4?Colors.white:Colors.grey,
                    fontWeight: _currentIndex==4?FontWeight.bold:FontWeight.w300,
                    fontSize: 15.sp,
                    fontFamily: "Calibri"
                ),
              ),
            ),
          ],
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}
