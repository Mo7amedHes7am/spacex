import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:spacex/Design/Colors/ColorsMethods.dart';
import 'package:spacex/Design/Pages/ArMap.dart';
import 'package:spacex/Design/Pages/Articles.dart';
import 'package:spacex/Design/Pages/StormMap.dart';
import 'package:spacex/Design/Pages/Videos.dart';
import 'package:spacex/Methods/Models/ExploreModel.dart';

import '../Main/nHomeScreen.dart';

late String t;
late String te;

class AllData extends StatefulWidget {
  AllData({required String title, required String datatype}){
    t = datatype;
    te = title;
  }

  @override
  State<AllData> createState() => _AllDataState();
}

class _AllDataState extends State<AllData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,
      appBar: AppBar(
        leading: BackButton(color: background,style: ButtonStyle(iconSize: WidgetStatePropertyAll(32.sp)),),
        title: Text(te,
          style: TextStyle(
              fontSize: 18.sp,
              color: background,
              fontWeight: FontWeight.bold,
              fontFamily: "Droid Arabic"
          ),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        leadingWidth: 40.sp,
      ),
      body: SingleChildScrollView(
        child: Container(
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                constraints: BoxConstraints(
                    maxHeight: 300.sp
                ),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: explore_items.values.where((element) => element.datatype == t,).toList().length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return ExploreCard(context,explore_items.values.where((element) => element.datatype == t,).toList()[index]);
                  },
                ),
              ),
              SizedBox(height: 40.h,)
            ],
          ),
        ),
      ),
    );
  }

  Widget ExploreCard(BuildContext context, ExploreModel index) {
    print(index.id);
    final item = index;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        InkWell(
          onTap: (){
            if (index.id=="0") {
              Get.to(StormMap());
            }else if(index.id=="1"){
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
          child: Row(
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


}
