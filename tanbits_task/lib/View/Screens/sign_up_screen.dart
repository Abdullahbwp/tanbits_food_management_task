import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:tanbits_task/Provider/sign_up_provider.dart';
import 'package:tanbits_task/Utills/app_colors.dart';
import 'package:tanbits_task/Widgets/custom_text.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    final signUpProvider = Provider.of<SignUpProvider>(context);
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        elevation: 0.0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppColors.blackColor),
        title: CustomText(
          text: "Sign Up",
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
                height: 80.h,
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
                  controller: signUpProvider.emailController,
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
                  controller: signUpProvider.passwordController,
                  obscureText: !signUpProvider.isVisible,
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
                          signUpProvider.toggleVisibility();
                        },
                        child: signUpProvider.isVisible == false
                            ? Icon(
                                Icons.remove_red_eye,
                                size: 20.sp,
                              )
                            : Icon(
                                Icons.remove_red_eye_outlined,
                                size: 20.sp,
                              ),
                      ),
                      hintText: 'Enter Password',
                      hintStyle: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.black38,
                          fontWeight: FontWeight.w400)),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              GestureDetector(
                onTap: () async {
                  signUpProvider.signUpMethod();
               
                },
                child: Container(
                  height: 45.h,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: AppColors.blackColor,
                      borderRadius: BorderRadius.circular(12.sp)),
                  child: Center(
                    child: CustomText(
                      text: "Sign Up",
                      size: 14.sp,
                      color: AppColors.whiteColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
