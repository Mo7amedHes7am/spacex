import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:spacex/Design/Auth/Signin.dart';
import 'package:spacex/Design/Auth/Signup2.dart';
import 'package:spacex/Design/Colors/ColorsMethods.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.black,
                    image: DecorationImage(
                      image: AssetImage("assets/stars.gif"),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(Colors.black12, BlendMode.darken),
                    ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(height: 0.h,),
                    Image(
                      image: AssetImage("assets/giphynobg.gif"),
                      width: MediaQuery.sizeOf(context).width,
                      fit: BoxFit.fill,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xff0A0A0A00), Color(0xff0A0A0A)],
                            begin: Alignment(0.0, -0.3),
                            end: Alignment(0, 0.2),
                          )
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(height: 10.h,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Signup',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 25.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20.h,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: ()async{

                                    },
                                    child: Container(
                                      height: 45.h,
                                      width: 320.w,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(color: Colors.black),
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(FontAwesomeIcons.google,color: primary,),
                                          SizedBox(width: 8.w,),
                                          Text(
                                            'Continue with Google',
                                            style: TextStyle(
                                              color: primary,
                                              fontSize: 15.sp,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 12.h,),
                                  InkWell(
                                    onTap: () {
                                      Get.off(SignupScreen2());
                                    },
                                    child: Container(
                                      height: 45.h,
                                      width: 320.w,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(color: Colors.black),
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.email,color: primary,),
                                          SizedBox(width: 8.w,),
                                          Text(
                                            'Continue with Email',
                                            style: TextStyle(
                                              color: primary,
                                              fontSize: 15.sp,
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
                          SizedBox(height: 20.h,),
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Already have an account ?',
                                    style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold, color: Colors.white),
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        Get.to(SigninScreen());
                                      },
                                      child: Text(
                                        'Login',
                                        style: TextStyle(
                                            fontSize: 16.sp, fontWeight: FontWeight.bold, color: Colors.white),
                                      )
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: 260.w,
                                        child: Text(
                                          'By signing up, you are creating an account and agree to Policies.',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 70.h,),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
