import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpProvider extends ChangeNotifier {
  bool _isVisible = false;
  bool get isVisible => _isVisible;
  void toggleVisibility() {
    _isVisible = !_isVisible;
    notifyListeners();
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> signUpMethod() async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      // Successfully signed up
      print('User signed up: ${userCredential.user?.email}');
    } catch (e) {
      // Handle sign-up errors
      print('Error signing up: $e');
    }
  }
}
