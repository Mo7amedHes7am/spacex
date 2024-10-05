import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:responsive_navigation_bar/responsive_navigation_bar.dart';
import 'package:spacex/Design/Colors/ColorsMethods.dart';
import 'package:spacex/Design/Main/Community.dart';
import 'package:spacex/Design/Main/Home.dart';
import 'package:spacex/Methods/Models/UserModel.dart';

class HomeMain extends StatefulWidget {
  const HomeMain({super.key});

  @override
  State<HomeMain> createState() => _HomeMainState();
}

late UserModel user;

class _HomeMainState extends State<HomeMain> {
  int _selectedIndex = 0;
  final pages = [HomePage(), CommunityPage(), HomePage()];

  void changeTab(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

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

  DataScreen(BuildContext context){
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: pages[_selectedIndex],
        extendBody: true,
        bottomNavigationBar: ResponsiveNavigationBar(
          selectedIndex: _selectedIndex,
          backgroundColor: Colors.transparent,
          onTabChange: changeTab,
          // showActiveButtonText: false,
          textStyle: TextStyle(
            color: Colors.white,
            fontSize: 20.sp,
            fontFamily: "ProtestGuerrilla",
            fontWeight: FontWeight.bold,
          ),
          activeIconColor: primary,
          fontSize: 20.sp,
          navigationBarButtons: <NavigationBarButton>[
            NavigationBarButton(
                textColor: primary,
                text: 'Home',
                icon: Icons.home,
                backgroundColor: background
            ),
            NavigationBarButton(
                text: 'Community',
                icon: FontAwesomeIcons.signsPost,
                textColor: primary,
                backgroundColor: background
            ),
            NavigationBarButton(
                text: 'Charts',
                icon: FontAwesomeIcons.chartColumn,
                textColor: primary,
                backgroundColor: background
            ),
          ],
        ),
      ),
    );
  }

}
