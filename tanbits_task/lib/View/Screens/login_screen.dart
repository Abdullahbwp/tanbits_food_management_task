// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:tanbits_task/Provider/login_provider.dart';
import 'package:tanbits_task/Utills/app_colors.dart';
import 'package:tanbits_task/View/Screens/home_screen.dart';
import 'package:tanbits_task/View/Screens/sign_up_screen.dart';
import 'package:tanbits_task/Widgets/custom_text.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final globalKey = GlobalKey<ScaffoldState>();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final loginProvier = Provider.of<LoginProvider>(context);
    return Scaffold(
      key: globalKey,
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        elevation: 0.0,
        centerTitle: true,
        title: CustomText(
          text: "Login",
          color: AppColors.blackColor,
          fontWeight: FontWeight.bold,
          size: 20.sp,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 30.h,
              ),
              CustomText(
                text: "Email Address",
                size: 14.sp,
                color: AppColors.labelColor,
                fontWeight: FontWeight.w600,
              ),
              SizedBox(
                height: 10.h,
              ),
              Container(
                height: 45.h,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black26),
                    borderRadius: BorderRadius.circular(12.sp)),
                child: TextFormField(
                  controller: loginProvier.emailController,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(
                        Icons.email_outlined,
                        color: AppColors.labelColor,
                        size: 20.sp,
                      ),
                      hintText: 'Enter Email Address',
                      contentPadding: EdgeInsets.all(10.sp),
                      hintStyle:
                          TextStyle(fontSize: 14.sp, color: Colors.black38)),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              CustomText(
                text: "Password",
                size: 14.sp,
                color: AppColors.labelColor,
                fontWeight: FontWeight.w600,
              ),
              SizedBox(
                height: 10.h,
              ),
              Container(
                height: 45.h,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black45),
                    borderRadius: BorderRadius.circular(12.sp)),
                child: TextFormField(
                  controller: loginProvier.passwordController,
                  obscureText: !loginProvier.isVisible,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(10.sp),
                    prefixIcon: Icon(
                      Icons.lock_outline,
                      size: 20.sp,
                      color: AppColors.labelColor,
                    ),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        loginProvier.showVisibility();
                      },
                      child: loginProvier.isVisible == false
                          ? Icon(
                              Icons.remove_red_eye,
                              size: 20.sp,
                              color: AppColors.labelColor,
                            )
                          : Icon(
                              Icons.remove_red_eye_outlined,
                              size: 20.sp,
                              color: AppColors.labelColor,
                            ),
                    ),
                    hintText: 'Enter Password',
                    hintStyle: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.black38,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              GestureDetector(
                onTap: () async {
                  loginProvier.setLoading(true);
                  if (loginProvier.emailController.text.isEmpty) {
                    final snackBar = SnackBar(
                        backgroundColor: AppColors.blackColor,
                        content: const CustomText(
                          text: "Email Field is not Empty",
                        ));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    loginProvier.setLoading(false);
                  } else if (loginProvier.passwordController.text.isEmpty) {
                    final snackBar = SnackBar(
                        backgroundColor: AppColors.blackColor,
                        content: const CustomText(
                          text: "Passsword Field is not Empty",
                        ));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    loginProvier.setLoading(false);
                  } else {
                    bool? res = await loginProvier.loginMethod(context);
                    if (res!) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SearchScreen(),
                          ));
                      loginProvier.emailController.clear();
                      loginProvier.passwordController.clear();
                    }
                    loginProvier.setLoading(false);
                  }
                },
                child: Container(
                  height: 45.h,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: AppColors.blackColor,
                      borderRadius: BorderRadius.circular(12.sp)),
                  child: loginProvier.isLoading == true
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Center(
                          child: CustomText(
                            text: "Login",
                            size: 14.sp,
                            color: AppColors.whiteColor,
                          ),
                        ),
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              const Center(
                child: CustomText(
                  text: "Forgot Password?",
                  color: AppColors.blackColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 180.h,
              ),
              Center(
                child: CustomText(
                  text: "or continue with",
                  size: 14.sp,
                  color: Colors.black45,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Container(
                height: 45.h,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: AppColors.googleColor,
                    borderRadius: BorderRadius.circular(10.sp)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.g_mobiledata,
                      size: 30.sp,
                      color: AppColors.whiteColor,
                    ),
                    SizedBox(width: 4.w),
                    CustomText(
                      text: "Login with Google",
                      size: 14.sp,
                      color: AppColors.whiteColor,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Container(
                height: 45.h,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: AppColors.facebookColor,
                    borderRadius: BorderRadius.circular(10.sp)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.facebook,
                      size: 30.sp,
                      color: AppColors.whiteColor,
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    CustomText(
                      text: "Login with Facebook",
                      size: 14.sp,
                      color: AppColors.whiteColor,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Center(
                child: CustomText(
                  text: "OR",
                  size: 16.sp,
                  color: AppColors.blackColor,
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    text: "Creteate an account ?",
                    color: AppColors.labelColor,
                    size: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                  SizedBox(
                    width: 4.w,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignUpScreen(),
                          ));
                    },
                    child: CustomText(
                      text: "Sign Up",
                      size: 16.sp,
                      color: AppColors.blackColor,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20.h,
              )
            ],
          ),
        ),
      ),
    );
  }
}
