import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:get/get.dart';
import 'package:spacex/Design/Colors/ColorsMethods.dart';
import 'package:spacex/Design/Pages/StormMap.dart';
import 'package:spacex/Methods/Models/ExploreModel.dart';
import 'package:spacex/Methods/Models/UserModel.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

final Item0 = ExploreModel(
    id: "0",
    datatype: "",
    imgurl: AssetImage("assets/worldmap.webp"),
    source: "Storm-X App",
    sourcelink: "",
    subtitle: "Map Display",
    title: "May 2024 Geomagnetic Storm Map",
    type: 1,
    content: []
);

final Item1 = ExploreModel(
    id: "1",
    datatype: "",
    imgurl: AssetImage('assets/geomagneticstorm.jpg'),
    source: 'Storm-X App',
    sourcelink: "",
    subtitle: 'AR Display',
    title: 'May 2024 Geomagnetic Storm Augment Reality',
    type: 1,
    content: []
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
    content: []
);

Map<int,ExploreModel> explore_items = {
  0 : Item0,
  1 : Item1,
  2 : Item2,
};

Map<int,List<String>> games_items = {
  0:['Geomagnetic Storm Quiz',"assets/quiz.png","quiz"],
  1:['Geomagnetic Storm Slide','assets/slidepuzzle.png','slide'],
  2:['Geomagnetic storm Memory Game','assets/memory.jpg','memory'],
  3:['Geomagnetic storm Jigsaw Puzzle','assets/jigsaw.jpg','puzzle'],
  4:['Geomagnetic storm Crossword','assets/wordsearch.png','crossword'],
  5:['Geomagnetic storm Hangman','assets/hangman.png','hangman'],
};

late UserModel user;

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return GetUserData(context);
  }

  GetUserData(BuildContext context){
    return StreamBuilder(
        stream:  FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            user = UserModel.fromMap(snapshot.data!.data()!);
            return GetData(context);
          }
          else{
            return Scaffold(body: Center(child: CircularProgressIndicator(color: primary,),),);
          }
        });
  }

  GetData(BuildContext context){
    return StreamBuilder(
        stream:  FirebaseFirestore.instance.collection('data').snapshots(),
        builder: (context, snapshot) {
          explore_items.clear();
          explore_items = {
            0 : Item0,
            1 : Item1,
            2 : Item2,
          };
          if (snapshot.hasData) {
            for(var data in snapshot.data!.docs){
              if (data.data()['type']==1) {
                explore_items[explore_items.length]=ExploreModel.fromMap(data.data());
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
    return SafeArea(
      child: Scaffold(
          body: Container(
            constraints: BoxConstraints(
                minHeight: MediaQuery.sizeOf(context).height
            ),
            padding: EdgeInsets.symmetric(horizontal: 20.sp),
            width: MediaQuery.sizeOf(context).width,
            decoration: BoxDecoration(
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
                ],
              ),
            ),
          )
      ),
    );
  }

  Widget AppBar_Section(BuildContext context, ImageProvider image) {
    return Column(
      children: [
        SizedBox(height: 10.h,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Storm-X',style: TextStyle(color: Colors.white,fontSize: 30.sp,fontWeight: FontWeight.bold,fontFamily: 'ProtestGuerrilla'),),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: EdgeInsets.all(10.sp),
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
                        Image(
                          width: 24.sp,
                          height: 24.sp,
                          image: Svg('assets/certificate.svg'),color: background,
                        ),
                        SizedBox(width:5.sp),
                        Text(user.points.toString(),
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
                SizedBox(width: 10.sp,),
                CircleAvatar(radius: 20.sp,backgroundImage: image)
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
        Container(
          constraints: BoxConstraints(
            maxHeight: 300.sp
          ),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: explore_items.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return ExploreCard(context,index);
            },
          ),
        ),
        SizedBox(height: 40.h,)
      ],
    );
  }

  Widget ExploreCard(BuildContext context, int index) {
    final item = explore_items[index]!;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        InkWell(
          onTap: (){
            if (index==0) {
              Get.to(StormMap());
            }else if(index==1){

            }else if(index==2){

            }else{
              if(item.datatype=="article"){
                
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
        SizedBox(height: 20.h,),
        Container(
          constraints: BoxConstraints(
              maxHeight: 220.sp
          ),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: games_items.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return GameCard(context,index);
            },
          ),
        ),
      ],
    );
  }

  Widget GameCard(BuildContext context, int index) {
    final item = games_items[index]!;
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 220.sp,
              height: 220.sp,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.sp),
                  image: DecorationImage(image: AssetImage(item[1]),fit: BoxFit.cover),
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
                    Text(item[0],
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
                    SizedBox(height: 20.sp,),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(width: 20.sp,)
      ],
    );
  }
}
