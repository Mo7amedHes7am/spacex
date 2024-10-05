import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:spacex/Design/Auth/Signin.dart';
import 'package:spacex/Design/Colors/ColorsMethods.dart';

class ForgotScreen extends StatefulWidget {
  const ForgotScreen({super.key});

  @override
  State<ForgotScreen> createState() => _ForgotScreenState();
}

class _ForgotScreenState extends State<ForgotScreen> {

  var emailcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height*0.4,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.black,
                  image: DecorationImage(
                    image: AssetImage('assets/earth2.gif'),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(Colors.black12, BlendMode.darken),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.only(top: 30, left: 10),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 45.w,
                            height: 45.h,
                            decoration: BoxDecoration(
                              color: Colors.black54,
                              shape: BoxShape.circle,
                            ),
                            child: BackButton(
                              color: Colors.white,
                              onPressed: (){
                                Get.off(SigninScreen());
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Find your email',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 40.h,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: TextFormField(
                  style: TextStyle(color: Colors.white),
                  controller: emailcontroller,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    hintText: 'Email',
                    hintStyle: TextStyle(color: Colors.white54, fontSize: 15.sp),
                    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey,)),
                    border: OutlineInputBorder(borderSide: BorderSide(color: background,)),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: background,width: 2.w)),
                  ),
                ),
              ),
              SizedBox(height: 32.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () async {
                      await FirebaseAuth.instance.sendPasswordResetEmail(email: emailcontroller.text);
                      final snackBar = SnackBar(
                        duration: Duration(milliseconds: 1500,),
                        elevation: 0,
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.transparent,
                        content: AwesomeSnackbarContent(
                          title: 'Success',
                          message: 'Sent Reset Email Password To Your Email',
                          contentType: ContentType.success,
                        ),
                      );
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(snackBar);
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 328.w,
                      height: 48.h,
                      decoration: BoxDecoration(
                        color: background,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Find',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              height: 0.10,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
