import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:spacex/Design/Colors/ColorsMethods.dart';
import 'package:spacex/Methods/Models/ExploreModel.dart';
import 'package:url_launcher/url_launcher.dart';

late ExploreModel art;

class ArticleScreen extends StatefulWidget {
  ArticleScreen({required ExploreModel article}){
    art = article;
  }

  @override
  State<ArticleScreen> createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
            leading: BackButton(
              color: background,
              style: ButtonStyle(iconSize: WidgetStatePropertyAll(25.sp)),
            ),
          ),
          backgroundColor: primary,
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(bottom: 30.sp,right: 20.sp,left: 20.sp),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(art.title,
                    style: TextStyle(
                        fontSize: 24.sp,
                        color: background,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Droid Arabic"
                    ),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(height: 20.h,),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15.sp),
                    child: Image(
                      image: art.imgurl,
                      width: MediaQuery.sizeOf(context).width-40.sp,
                    ),
                  ),
                  SizedBox(height: 20.sp,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(DateFormat('dd MMMM yyyy').format(DateTime.fromMillisecondsSinceEpoch(art.datetime)),
                        style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.white70,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Fredoka"
                        ),
                        textAlign: TextAlign.start,
                      ),
                      SizedBox(width:10.sp),
                    ],
                  ),
                  SizedBox(height: 20.sp,),
                  Text(art.content[0].replaceAll("\\n", "\n"),
                    style: TextStyle(
                        fontSize: 18.sp,
                        color: background,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Calibri"
                    ),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(height: 30.sp,),
                  InkWell(
                    onTap: () async {
                      await launchUrl( Uri.parse(art.sourcelink));
                    },
                    child: Container(
                      width: 260.sp,
                      padding: EdgeInsets.all(8.sp),
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(15.sp)
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Open Source Link",
                              style: TextStyle(
                                fontSize: 24.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Droid Arabic",
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Icon(Icons.subdirectory_arrow_left_outlined,color: Colors.white,)
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        )
    );
  }
}
