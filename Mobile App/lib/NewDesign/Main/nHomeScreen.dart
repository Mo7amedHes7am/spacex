import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:spacex/Design/Colors/ColorsMethods.dart';
import 'package:spacex/Design/Pages/ArMap.dart';
import 'package:spacex/Design/Pages/Articles.dart';
import 'package:spacex/Design/Pages/Quizes.dart';
import 'package:spacex/Design/Pages/StormMap.dart';
import 'package:spacex/Design/Pages/Videos.dart';
import 'package:spacex/Methods/Models/ExploreModel.dart';
import 'package:spacex/Methods/Models/QuizModel.dart';
import 'package:spacex/NewDesign/Pages/ARS.dart';
import 'package:spacex/NewDesign/Pages/GM.dart';

import '../../NewDesign/NavigationBar/NnavBar.dart';

final Item0 = ExploreModel(
    id: "0",
    datatype: "map",
    imgurl: AssetImage("assets/worldmap.webp"),
    source: "Storm-X App",
    sourcelink: "",
    subtitle: "Map Display",
    title: "May 2024 Geomagnetic Storm Map",
    type: 1,
    content: [],
    datetime:0
);

final Item1 = ExploreModel(
    id: "1",
    datatype: "ar",
    imgurl: AssetImage('assets/geomagneticstorm.jpg'),
    source: 'Storm-X App',
    sourcelink: "",
    subtitle: 'AR Display',
    title: 'May 2024 Geomagnetic Storm Augment Reality',
    type: 1,
    content: [],
    datetime:0
);

final Item2 = ExploreModel(
    id: "2",
    datatype: "",
    imgurl: NetworkImage('https://i9.ytimg.com/vi/S1PgEgjX3JM/mqdefault.jpg?sqp=CNjy77cG-oaymwEmCMACELQB8quKqQMa8AEB-AHUBoAC4AOKAgwIABABGE4gWChlMA8=&rs=AOn4CLAPUqjT1PuXELyvoEV7cgLHZe1pOg'),
    source: 'Storm-X Youtube',
    sourcelink: "",
    subtitle: 'Video Explantion',
    title: 'Global geomagnetic storm and aurora activity',
    type: 1,
    content: [],
    datetime:0
);

Timer? _timer;

Map<String,ExploreModel> explore_items = {
  "0" : Item0,
  "1" : Item1,
};

Map<int,dynamic> games_items = {
};

class NHomeScreen extends StatefulWidget {
  const NHomeScreen({super.key});

  @override
  State<NHomeScreen> createState() => _NHomeScreenState();
}

class _NHomeScreenState extends State<NHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return GetData(context);
  }

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
      });
    });
  }

  GetData(BuildContext context){
    return StreamBuilder(
        stream:  FirebaseFirestore.instance.collection('data').snapshots(),
        builder: (context, snapshot) {
          explore_items.clear();
          explore_items = {
            "0" : Item0,
            "1" : Item1,
          };
          games_items.clear();
          if (snapshot.hasData) {
            for(var data in snapshot.data!.docs){
              if (data.data()['type']==1) {
                explore_items[data.data()['id']]=ExploreModel.fromMap(data.data());
              }else if(data.data()['type']=='quiz'){
                games_items[games_items.length]=QuizModel.fromMap(data.data());
              }
            }
            return DataScreen(NetworkImage(user.imgurl));
          }
          else{
            return Scaffold(body: Center(child: CircularProgressIndicator(color: primary,),),);
          }
        });
  }

  DataScreen(ImageProvider image){
    return Scaffold(
        extendBody: true,
        body: Container(
          constraints: BoxConstraints(
              minHeight: MediaQuery.sizeOf(context).height
          ),
          padding: EdgeInsets.symmetric(horizontal: 20.sp),
          width: MediaQuery.sizeOf(context).width,
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage('assets/star.png'),opacity: 0.1,repeat: ImageRepeat.repeat),
              gradient: LinearGradient(
                  colors: [
                    Color(0xff070b23),
                    Color(0xff060d24),
                    Color(0xff061129)
                  ],
                  transform: GradientRotation(45.sp),
                  stops: [0.0,0.33,0.67]
              )
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppBar_Section(context, image),
                Information_Section(context),
                Games_Section(context),
                SizedBox(height: 100.sp,)
              ],
            ),
          ),
        )
    );
  }

  Widget AppBar_Section(BuildContext context, ImageProvider image) {
    return Column(
      children: [
        SizedBox(height: 10.h,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(width:240.w,child: Text('WELCOME, ${user.fname}',style: TextStyle(color: Colors.white,fontSize: 24.sp,fontWeight: FontWeight.bold,fontFamily: 'Calibri'),maxLines: 1,overflow: TextOverflow.ellipsis,)),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CircleAvatar(radius: 20.sp,backgroundImage: image),
                SizedBox(width: 10.sp,),
                Container(
                  padding: EdgeInsets.symmetric(horizontal:10.sp),
                  height: 40.sp,
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(45.sp)
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          size: 24.sp,
                          FontAwesomeIcons.coins,color: background,
                        ),
                        SizedBox(width:5.sp),
                        Text(user.points>=1000?user.points>=1000000?"${user.points~/1000000} M":"${user.points~/1000} K":user.points.toString(),
                          style: TextStyle(
                              color: background,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Droid Arabic"
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 40.h,),
      ],
    );
  }

  Widget Information_Section(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Explore",
          style: TextStyle(
              fontWeight: FontWeight.w900,
              color: background,
              fontSize: 22.sp,
              fontFamily: "Calibri"
          ),
          textAlign: TextAlign.start,
        ),
        SizedBox(height: 20.h,),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              InkWell(
                onTap: (){
                  Get.to(AllData(title: 'All Maps', datatype: 'map'));
                },
                child: Container(
                  width: 80.sp,
                  height: 80.sp,
                  decoration: BoxDecoration(
                    color: Color(0xFFE7E6E9),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.map,size: 32.sp,),
                      Text("Maps",
                        style: TextStyle(
                          color: primary,
                          fontSize: 12.sp,
                          fontFamily: 'Almarai',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 16.w,),
              InkWell(
                onTap: (){
                  Get.to(AllData(title: 'All Augument Realities', datatype: 'ar'));
                },
                child: Container(
                  width: 80.sp,
                  height: 80.sp,
                  decoration: BoxDecoration(
                    color: Color(0xFFE7E6E9),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(FontAwesomeIcons.vrCardboard,size: 32.sp,),
                      Text("AR",
                        style: TextStyle(
                          color: primary,
                          fontSize: 12.sp,
                          fontFamily: 'Almarai',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 16.w,),
              InkWell(
                onTap: (){
                  Get.to(AllData(title: 'All Articles', datatype: 'article'));
                },
                child: Container(
                  width: 80.sp,
                  height: 80.sp,
                  decoration: BoxDecoration(
                    color: Color(0xFFE7E6E9),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.book,size: 32.sp,),
                      Text("Articles",
                        style: TextStyle(
                          color: primary,
                          fontSize: 12.sp,
                          fontFamily: 'Almarai',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 16.w,),
              InkWell(
                onTap: (){
                  Get.to(AllData(title: 'All Videos', datatype: 'video'));
                },
                child: Container(
                  width: 80.sp,
                  height: 80.sp,
                  decoration: BoxDecoration(
                    color: Color(0xFFE7E6E9),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.video_camera_back,size: 32.sp,),
                      Text("Videos",
                        style: TextStyle(
                          color: primary,
                          fontSize: 12.sp,
                          fontFamily: 'Almarai',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 16.w,),
            ],
          ),
        ),
        SizedBox(height: 20.h,),

      ],
    );

  }

  Widget ExploreCard(BuildContext context, String index) {
    final item = explore_items[index]!;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        InkWell(
          onTap: (){
            if (index=="0") {
              Get.to(StormMap());
            }else if(index=="1"){
              Get.to(ARMap());
            }else{
              if(item.datatype=="article"){
                Get.to(ArticleScreen(article: item,));
              }
              else if(item.datatype=="video"){
                Get.to(VideoScreen(video:item));
              }
            }
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 150.sp,
                height: 150.sp,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.sp),
                    image: DecorationImage(image: item.imgurl,fit: BoxFit.cover,opacity: 0.8),
                    gradient: LinearGradient(
                        colors: [Colors.transparent,Colors.white],
                        transform: GradientRotation(90.sp),
                        stops: [0.0,0.8]
                    )
                ),
              ),
              SizedBox(height: 10.sp,),
              SizedBox(
                width: 150.sp,
                child: Text(item.title,
                  style: TextStyle(
                      fontFamily: "Droid Arabic",
                      color: background,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      height: 1
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(height: 10.sp,),
              SizedBox(
                width: 150.sp,
                child: Text("${item.subtitle} - ${item.source}",
                  style: TextStyle(
                    fontFamily: "Droid Arabic",
                    color: silverdark,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 20.sp,)
      ],
    );
  }

  Widget Games_Section(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Games And Quizes",
          style: TextStyle(
              fontWeight: FontWeight.w900,
              color: background,
              fontSize: 22.sp,
              fontFamily: "Calibri"
          ),
          textAlign: TextAlign.start,
        ),
        Container(
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: games_items.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return GameCard(context,index);
            },
          ),
        ),
        SizedBox(height: 20.h,),
      ],
    );
  }

  Widget GameCard(BuildContext context, int index) {
    final item = games_items[index]!;
    return Column(
      children: [
        Container(
          width: MediaQuery.sizeOf(context).width-60.sp,
          height: 220.sp,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.sp),
            image: DecorationImage(image: item.imgurl,fit: BoxFit.cover),
          ),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.sp),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.sp),
                gradient: LinearGradient(
                    colors: [Colors.transparent,Colors.white.withOpacity(0.6)],
                    transform: GradientRotation(90.sp),
                    stops: [0.0,0.5]
                )
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.title,
                  style: TextStyle(
                      fontFamily: "Droid Arabic",
                      color: darkgrey,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      height: 1
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 20.sp,),
                Center(
                  child: InkWell(
                    onTap: () {
                      if (item.type=="quiz") {
                        Get.to(QuizScreen(Quiz: item as QuizModel,));
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.all(5.sp),
                      decoration: BoxDecoration(
                          color: primary,
                          borderRadius: BorderRadius.circular(45.sp)
                      ),
                      child: Center(
                        child: Text("Play Now",
                          style: TextStyle(
                            color: background,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.sp,
                            fontFamily: "Droid Arabic",
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.sp,),
              ],
            ),
          ),
        ),
        SizedBox(height: 20.sp,),
        Container(
          width: MediaQuery.sizeOf(context).width-60.sp,
          height: 220.sp,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.sp),
            image: DecorationImage(image: AssetImage('assets/puzzle.jpg'),fit: BoxFit.cover),
          ),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.sp),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.sp),
                gradient: LinearGradient(
                    colors: [Colors.transparent,Colors.white.withOpacity(0.6)],
                    transform: GradientRotation(90.sp),
                    stops: [0.0,0.5]
                )
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Complete The Puzzle",
                  style: TextStyle(
                      fontFamily: "Droid Arabic",
                      color: darkgrey,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      height: 1
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 20.sp,),
                Center(
                  child: InkWell(
                    onTap: () {
                      Get.to(Gm());
                    },
                    child: Container(
                      padding: EdgeInsets.all(5.sp),
                      decoration: BoxDecoration(
                          color: primary,
                          borderRadius: BorderRadius.circular(45.sp)
                      ),
                      child: Center(
                        child: Text("Play Now",
                          style: TextStyle(
                            color: background,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.sp,
                            fontFamily: "Droid Arabic",
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.sp,),
              ],
            ),
          ),
        ),
        SizedBox(height: 20.sp,),
      ],
    );
  }
}
