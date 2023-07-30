// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tanbits_task/Utills/app_colors.dart';
import 'package:tanbits_task/Widgets/custom_text.dart';

class SignUpProvider extends ChangeNotifier {
  bool _isVisible = false;
  bool get isVisible => _isVisible;
  void toggleVisibility() {
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

  Future<bool?> signUpMethod(BuildContext context) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      // Successfully signed up
      print('User signed up: ${userCredential.user?.email}');
      const snackBar = SnackBar(
          backgroundColor: AppColors.blackColor,
          content: CustomText(
            text: "Acccount Created Successfully",
          ));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      setLoading(false);
      return true;
    } catch (e) {
      //..............Handle sign-up errors...............//
      print('Error signing up: $e');
      return false;
    }
  }
}
