// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tanbits_task/Utills/app_colors.dart';
import 'package:tanbits_task/Widgets/custom_text.dart';

class LoginProvider extends ChangeNotifier {
  bool _isVisible = false;
  bool get isVisible => _isVisible;
  void showVisibility() {
    _isVisible = !_isVisible;
    notifyListeners();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  void setLoading(bool v) {
    _isLoading = v;
    notifyListeners();
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<bool?> loginMethod(BuildContext context) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      //...... Successfully logged in...................//
      log('User logged in: ${userCredential.user?.email}');
      log('Check User Uid: ${userCredential.user?.uid}');
      final snackBar = SnackBar(
          backgroundColor: AppColors.blackColor,
          content: CustomText(
            text: "Login Successfully",
          ));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      setLoading(false);
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        final snackBar = SnackBar(
            backgroundColor: AppColors.blackColor,
            content: CustomText(
              text: "User not found!!!",
            ));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        print('The password provided is too weak.');
      } else if (e.code == 'wrong-password') {
        final snackBar = SnackBar(
            backgroundColor: AppColors.blackColor,
            content: CustomText(
              text: "Password is invalid!!!",
            ));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else if (e.code == 'invalid-email') {
        final snackBar = SnackBar(
            backgroundColor: AppColors.blackColor,
            content: CustomText(
              text: "Email is invalid!!!",
            ));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
      setLoading(false);
      return false;
    }
  }
}
