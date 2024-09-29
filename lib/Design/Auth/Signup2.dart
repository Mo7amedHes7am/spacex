import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:spacex/Design/Auth/Signup.dart';
import 'package:spacex/Design/Colors/ColorsMethods.dart';
import 'package:spacex/Design/Main/Home.dart';

bool x = false;
class SignupScreen2 extends StatefulWidget
{
  @override
  State<SignupScreen2> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen2> {

  var firstnamecontroller = TextEditingController();
  var lastnamecontroller = TextEditingController();
  var emailcontroller = TextEditingController();
  var passwordcontroller = TextEditingController();
  var confirmpasswordcontroller = TextEditingController();
  bool passToggle = true;
  bool isRememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  image: AssetImage('assets/sunorbiting.gif'),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(Colors.black12, BlendMode.darken),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(top: 30.h, left: 10.w),
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
            SizedBox(height: 25.h,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.w),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Signup with email',
                          style: TextStyle(color: Colors.white, fontSize: 18.sp),
                        ),
                      ],
                    ),
                    SizedBox(height: 40.h,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex:1,
                          child: SizedBox(
                            height: 50.h,
                            child: TextFormField(
                              controller: firstnamecontroller,
                              onChanged: Completed,
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(10),
                                labelStyle: TextStyle(color: background, fontSize: 15.sp),
                                hintText: 'First name',
                                hoverColor: Colors.white,
                                hintStyle: TextStyle(color: Colors.white54, fontSize: 15.sp),
                                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey,)),
                                border: OutlineInputBorder(borderSide: BorderSide(color: background,)),
                                floatingLabelBehavior: FloatingLabelBehavior.always,
                                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: background,width: 2.w)),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 20.w,),
                        Expanded(
                          flex:1,
                          child: SizedBox(
                            height: 50.h,
                            child: TextFormField(
                              controller: lastnamecontroller,
                              onChanged: Completed,
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(10),
                                labelStyle: TextStyle(color: background, fontSize: 15.sp),
                                hintText: 'Last name',
                                hoverColor: Colors.white,
                                hintStyle: TextStyle(color: Colors.white54, fontSize: 15.sp),
                                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey,)),
                                border: OutlineInputBorder(borderSide: BorderSide(color: background,)),
                                floatingLabelBehavior: FloatingLabelBehavior.always,
                                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: background,width: 2.w)),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    SizedBox(
                      height: 50.h,
                      child: TextFormField(
                        onChanged: Completed,
                        style: TextStyle(color: Colors.white),
                        controller: emailcontroller,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10),
                          labelStyle: TextStyle(color: background, fontSize: 18.sp),
                          hintText: 'Email',
                          hoverColor: Colors.white,
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
                      height: 50.h,
                      child: TextFormField(
                        onChanged: Completed,
                        style: TextStyle(color: Colors.white),
                        controller: passwordcontroller,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: passToggle,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(10),
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
                    SizedBox(
                      height: 20.h,
                    ),
                    SizedBox(
                      height: 50.h,
                      child: TextFormField(
                        onChanged: Completed,
                        style: TextStyle(color: Colors.white),
                        controller: confirmpasswordcontroller,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: passToggle,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(10),
                            labelStyle: TextStyle(color: background, fontSize: 18.sp),
                            hintText: 'Confirm password',
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
                    SizedBox(height: 40.h,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: ()async{
                            if (firstnamecontroller.text.length == 0) {
                              final snackBar = SnackBar(
                                duration: Duration(milliseconds: 1500,),
                                elevation: 0,
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: Colors.transparent,
                                content: AwesomeSnackbarContent(
                                  title: 'Error',
                                  message: 'First Name Can\'t Be Empty',
                                  contentType: ContentType.failure,
                                ),
                              );
                              ScaffoldMessenger.of(context)
                                ..hideCurrentSnackBar()
                                ..showSnackBar(snackBar);
                              return;
                            }else if(lastnamecontroller.text.length == 0){
                              final snackBar = SnackBar(
                                duration: Duration(milliseconds: 1500,),
                                elevation: 0,
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: Colors.transparent,
                                content: AwesomeSnackbarContent(
                                  title: 'Error',
                                  message: 'Last Name Can\'t Be Empty',
                                  contentType: ContentType.failure,
                                ),
                              );
                              ScaffoldMessenger.of(context)
                                ..hideCurrentSnackBar()
                                ..showSnackBar(snackBar);
                              return;
                            }else if(emailcontroller.text.length == 0){
                              final snackBar = SnackBar(
                                duration: Duration(milliseconds: 1500,),
                                elevation: 0,
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: Colors.transparent,
                                content: AwesomeSnackbarContent(
                                  title: 'Error',
                                  message: 'Email Can\'t Be Empty',
                                  contentType: ContentType.failure,
                                ),
                              );
                              ScaffoldMessenger.of(context)
                                ..hideCurrentSnackBar()
                                ..showSnackBar(snackBar);
                              return;
                            }
                            else if(passwordcontroller.text.length == 0){
                              final snackBar = SnackBar(
                                duration: Duration(milliseconds: 1500,),
                                elevation: 0,
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: Colors.transparent,
                                content: AwesomeSnackbarContent(
                                  title: 'Error',
                                  message: 'Password Can\'t Be Empty',
                                  contentType: ContentType.failure,
                                ),
                              );
                              ScaffoldMessenger.of(context)
                                ..hideCurrentSnackBar()
                                ..showSnackBar(snackBar);
                              return;
                            }else if (confirmpasswordcontroller.text != passwordcontroller.text){
                              final snackBar = SnackBar(
                                duration: Duration(milliseconds: 1500,),
                                elevation: 0,
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: Colors.transparent,
                                content: AwesomeSnackbarContent(
                                  title: 'Error',
                                  message: 'Password isn\'t match confirm password' ,
                                  contentType: ContentType.failure,
                                ),
                              );
                              ScaffoldMessenger.of(context)
                                ..hideCurrentSnackBar()
                                ..showSnackBar(snackBar);
                              return;
                            }
                            else{
                              await signUpWithEmail(emailcontroller.text.toString(),passwordcontroller.text.toString(),firstnamecontroller.text.toString() + " " +lastnamecontroller.text.toString(),context);
                            }
                          },
                          child: Container(
                            width: 280.w,
                            height: 45.h,
                            decoration: BoxDecoration(
                              color: x?background:darkgrey,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Create account',
                                  style: TextStyle(color: x?Colors.black:silverdark, fontSize: 15.sp,fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Completed(String value)async {
    if (
    confirmpasswordcontroller.text.length != 0 &&
        passwordcontroller.text.length != 0 &&
        emailcontroller.text.length != 0 &&
        firstnamecontroller.text.length != 0 &&
        lastnamecontroller.text.length != 0) {
      setState(() {
        x = true;
      });
    }else{
      setState(() {
        x = false;
      });
    }
  }

  signUpWithEmail(String Email, String Password, String Name, BuildContext context) async{
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: Email,
        password: Password,
      );
      final user = <String, dynamic>{
        "uid": FirebaseAuth.instance.currentUser!.uid,
        "fname": firstnamecontroller.text.toString(),
        "lname": lastnamecontroller.text.toString(),
        "email": emailcontroller.text.toString(),
        "imgurl": 'https://firebasestorage.googleapis.com/v0/b/exa-spacex.appspot.com/o/profileimg%2FUser-Profile-PNG.png?alt=media&token=211e1cad-8e06-4ba5-b295-a1651d4d988e',
        'points':0
      };

      await FirebaseFirestore
          .instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set(user)
          .onError((e, _) => print("Error writing document: $e"));

      Get.offAll(HomePage());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        final snackBar = SnackBar(
          duration: Duration(milliseconds: 1500,),
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'Error',
            message: 'The password provided is too weak.',
            contentType: ContentType.failure,
          ),
        );
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);

      } else if (e.code == 'email-already-in-use') {
        final snackBar = SnackBar(
          duration: Duration(milliseconds: 1500,),
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'Error',
            message: 'The account already exists for that email.',
            contentType: ContentType.failure,
          ),
        );
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
      }
    } catch (e) {
      print(e);
    }
  }


}