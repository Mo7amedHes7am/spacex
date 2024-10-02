import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:responsive_navigation_bar/responsive_navigation_bar.dart';
import 'package:spacex/Design/Auth/forgot_screen.dart';
import 'package:spacex/Design/Colors/ColorsMethods.dart';
import 'package:spacex/Design/Main/Home.dart';

class HomeMain extends StatefulWidget {
  const HomeMain({super.key});

  @override
  State<HomeMain> createState() => _HomeMainState();
}

class _HomeMainState extends State<HomeMain> {
  int _selectedIndex = 0;
  final pages = [HomePage(), HomePage(), HomePage()];

  void changeTab(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
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
              text: 'Stormers',
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
