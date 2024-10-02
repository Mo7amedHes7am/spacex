import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spacex/Design/Auth/forgot_screen.dart';
import 'package:spacex/Design/Colors/ColorsMethods.dart';
import 'package:spacex/Design/Components/PostCard.dart';
import 'package:spacex/Design/NavigationBar/NavBar.dart';

class CommunityPage extends StatefulWidget {
  const CommunityPage({super.key});

  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,
      appBar: AppBar(
        title: Row(
          children: [
            Text("Discover",
              style: TextStyle(
                  color: background,
                  fontSize: 24.sp,
                  fontFamily: "Senmoly Caligan",
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2
              ),
            ),
            SizedBox(width: 10.sp,),
            Image.network(
              "https://upload.wikimedia.org/wikipedia/commons/thumb/e/e5/NASA_logo.svg/1224px-NASA_logo.svg.png",
              width: 30.sp,
            ),
          ],
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        foregroundColor: Colors.transparent,
        actions: [
          CircleAvatar(radius: 20.sp,backgroundImage: NetworkImage(user.imgurl)),
          SizedBox(width: 20.sp,)
        ],
      ),
      body: ListView.builder(
          itemCount: 3,
          padding: EdgeInsets.only(left: 20.sp,top: 15.sp,right: 20.sp,bottom: 80.sp),
          itemBuilder: (context, index) {
            return PostCard(context: context);
          },
      ),
    );
  }
}
