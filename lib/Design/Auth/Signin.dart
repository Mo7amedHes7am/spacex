import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:spacex/Design/Auth/Signup.dart';
import 'package:spacex/Design/Auth/forgot_screen.dart';
import 'package:spacex/Design/Colors/ColorsMethods.dart';
import 'package:spacex/Design/Main/Home.dart';
import 'package:spacex/Design/NavigationBar/NavBar.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {

  var emailcontroller = TextEditingController();
  var passwordcontroller = TextEditingController();
  bool passToggle = true;
  bool isRememberMe = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height*0.3,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.black,
                  image: DecorationImage(
                    image: AssetImage('assets/galaxy2.gif'),
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
                                Get.off(SignUpScreen());
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(35.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Login to your account',
                            style: TextStyle(color: Colors.white, fontSize: 18.sp),
                          ),
                        ],
                      ),
                      SizedBox(height: 25.h,),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 55.h,
                              child: TextFormField(
                                style: TextStyle(color: Colors.white),
                                controller: emailcontroller,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(10.sp),
                                  labelStyle: TextStyle(color: background, fontSize: 18.sp),
                                  hintText: 'Email',
                                  hintStyle: TextStyle(color: Colors.white54, fontSize: 15.sp),
                                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey,)),
                                  border: OutlineInputBorder(borderSide: BorderSide(color: background,)),
                                  floatingLabelBehavior: FloatingLabelBehavior.always,
                                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: background,width: 2.w)),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            SizedBox(
                              height: 55.h,
                              child: TextFormField(
                                style: TextStyle(color: Colors.white),
                                controller: passwordcontroller,
                                keyboardType: TextInputType.visiblePassword,
                                obscureText: passToggle,
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(10.sp),
                                    labelStyle: TextStyle(color: background, fontSize: 18.sp),
                                    hintText: 'Password',
                                    hintStyle: TextStyle(color: Colors.white54, fontSize: 15.sp),
                                    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey,)),
                                    border: OutlineInputBorder(borderSide: BorderSide(color: background,)),
                                    floatingLabelBehavior: FloatingLabelBehavior.always,
                                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: background, width: 2.w)),
                                    suffix: InkWell(
                                      onTap: (){
                                        setState(() {
                                          passToggle = !passToggle;
                                        });
                                      },
                                      child: Icon(passToggle ? Icons.visibility_off : Icons.visibility, color: Colors.grey,),
                                    )
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Get.to(ForgotScreen());
                                  },
                                  child: Text(
                                    'Forgot Password?',
                                    style: TextStyle(color: background, fontSize: 12.sp),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 48.h,),
                      Center(
                        child: InkWell(
                          onTap: ()async {
                            await signInWithEmail(emailcontroller.text.toString(), passwordcontroller.text.toString(), context);
                          },
                          child: Container(
                            width: 280.w,
                            height: 45.h,
                            decoration: BoxDecoration(
                              color: background,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Login',
                                  style: TextStyle(color: darkgrey, fontSize: 15.sp,fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> checkIfDocExists(String docId) async {
    try {
      // Get reference to Firestore collection
      var collectionRef = FirebaseFirestore.instance.collection('users');

      var docm = await collectionRef.doc(docId).get();
      return docm.exists;
    } catch (e) {
      throw e;
    }
  }

  signInWithEmail(String email, String password, BuildContext context)async{
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      FirebaseMessaging.instance.subscribeToTopic("news");
      Get.offAll(HomeMain());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        final snackBar = SnackBar(
          duration: Duration(milliseconds: 1500,),
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'Error',
            message: 'There Is No Account With This Email.',
            contentType: ContentType.failure,
          ),
        );
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
      }
      else if (e.code == 'wrong-password') {
        final snackBar = SnackBar(
          duration: Duration(milliseconds: 1500,),
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'Error',
            message: 'Wrong Password.',
            contentType: ContentType.failure,
          ),
        );
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
      }
    }
  }

}
