import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:spacex/Design/Colors/ColorsMethods.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

Map<int,List<String>> explore_items = {
  0:['What is Geomagnetic Storm?','Information Article','CBS 17',"assets/SolarDisturbance.png"],
  1:['Geomagnetic storm Video','Educational Video','CTV News','assets/geomagneticstorm.jpg'],
  2:['Geomagnetic storm Predictions','Using AI','Space-X App','assets/forecast.jpg'],
  3:['Geomagnetic storm Visualized Data','Chart Display','ResearchGate','assets/Magnetometer.jpg'],
};
Map<int,List<String>> games_items = {
  0:['Geomagnetic Storm Quiz',"assets/quiz.png","quiz"],
  1:['Geomagnetic Storm Slide','assets/slidepuzzle.png','slide'],
  2:['Geomagnetic storm Memory Game','assets/memory.jpg','memory'],
  3:['Geomagnetic storm Jigsaw Puzzle','assets/jigsaw.jpg','puzzle'],
  4:['Geomagnetic storm Crossword','assets/wordsearch.png','crossword'],
  5:['Geomagnetic storm Hangman','assets/hangman.png','hangman'],
};

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
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
              children: [
                AppBar_Section(context),
                Information_Section(context),
                Games_Section(context),
              ],
            ),
          ),
        )
      ),
    );
  }

  Widget AppBar_Section(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10.h,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image(image: AssetImage("assets/logo.png"),width: 50.sp,height: 50.sp,color: background,),
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
                        Text("0",
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
                CircleAvatar(radius: 20.sp,backgroundImage: AssetImage("assets/sun.jpg"))
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
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 150.sp,
              height: 150.sp,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.sp),
                image: DecorationImage(image: AssetImage(item[3]),fit: BoxFit.cover,opacity: 0.8),
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
              child: Text(item[0],
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
              child: Text("${item[1]} - ${item[2]}",
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
            itemCount: explore_items.length,
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
