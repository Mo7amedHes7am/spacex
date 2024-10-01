import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spacex/Design/Colors/ColorsMethods.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class StormMap extends StatefulWidget {
  const StormMap({super.key});

  @override
  State<StormMap> createState() => _StormMapState();
}

WebViewController controller = WebViewController()
  ..setJavaScriptMode(JavaScriptMode.unrestricted)
  ..setNavigationDelegate(
    NavigationDelegate(
      onProgress: (int progress) {
        print(progress);
      },
      onPageStarted: (String url) {},
      onPageFinished: (String url) {},
      onHttpError: (HttpResponseError error) {
        print(error);
      },
      onWebResourceError: (WebResourceError error) {
        print(error);
      },
      onNavigationRequest: (NavigationRequest request) {
        if (request.url.startsWith('https://www.youtube.com/')) {
          return NavigationDecision.prevent;
        }
        return NavigationDecision.navigate;
      },
    ),
  )..loadRequest(Uri.parse('https://stormx-three.vercel.app/'));

class _StormMapState extends State<StormMap> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: primary,
        appBar: AppBar(
          leading: BackButton(color: background,style: ButtonStyle(iconSize: WidgetStatePropertyAll(32.sp)),),
          title: Text("May 2024 Geomagnetic Storm Map",
            style: TextStyle(
                fontSize: 24.sp,
                color: background,
                fontWeight: FontWeight.bold,
                fontFamily: "Droid Arabic"
            ),
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          leadingWidth: 40.sp,
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 50.sp,),
              Center(
                child: Container(
                    width: MediaQuery.sizeOf(context).width-40.sp,
                    height: MediaQuery.sizeOf(context).width-40.sp,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.sp)
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15.sp),
                        child: WebViewWidget(controller: controller))
                ),
              ),
              SizedBox(height: 30.sp,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.sp),
                child: RichText(text: TextSpan(
                    children: [
                      TextSpan(text: "This map was generated using ",
                        style: TextStyle(
                            fontSize: 20.sp,
                            color: background,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Calibri",
                          letterSpacing: 1.5,
                          height: 2.sp
                        ),
                      ),
                      WidgetSpan(child:Image.network(
                        "https://upload.wikimedia.org/wikipedia/commons/thumb/e/e5/NASA_logo.svg/1224px-NASA_logo.svg.png",
                        width: 48.sp,
                      ),
                        style: TextStyle(
                          fontSize: 40.sp,
                          color: background,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Calibri",
                          letterSpacing: 1.5,
                          height: 2.sp
                        )
                      ),
                      TextSpan(text: " data to visualize the may 2024 geomagnetic storm phenomenon.",
                        style: TextStyle(
                            fontSize: 20.sp,
                            color: background,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Calibri",
                            letterSpacing: 1.5
                        ),
                      ),
                    ]
                ),
                  textAlign: TextAlign.start,
                ),
              ),
              SizedBox(height: 30.sp,),
              InkWell(
                onTap: () async {
                  await launchUrl( Uri.parse('https://stormx-three.vercel.app/'));
                },
                child: Container(
                  width: 220.sp,
                  padding: EdgeInsets.all(8.sp),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(15.sp)
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Open External",
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
    );
  }
}
