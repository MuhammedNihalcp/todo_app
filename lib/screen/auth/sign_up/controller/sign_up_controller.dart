import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/screen/auth/sign_in/view/sign_in_view.dart';

import '../../../../core/colors.dart';
import '../model/sign_up_model.dart';

class SignUpContoller extends GetxController {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController conformpasswordcontroller = TextEditingController();

  bool agree = false;

  bool isLoading = false;
  final auth = FirebaseAuth.instance;

  void onChanged(bool? value) {
    agree = value ?? false;
    update();
  }

  void addUser() async {
    UserCredential authResult;
    isLoading = true;
    update();
    SignUpModel model = SignUpModel(
      username: usernameController.text.trim(),
      email: emailcontroller.text.trim(),
      password: passwordcontroller.text.trim(),
      conformpassword: conformpasswordcontroller.text.trim(),
    );
    try {
      authResult = await auth.createUserWithEmailAndPassword(
        email: model.email,
        password: model.password,
      );
      log('create cheythu');
      await FirebaseFirestore.instance
          .collection('users')
          .doc(authResult.user!.uid)
          .set({
        'username': model.username,
        'email': model.email,
        'password': model.password,
      });
      log('usere add cheythu');
      disposetext();
      isLoading = false;
      update();
      Get.to(() => ScreenSignIn());
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error', e.message.toString(),
          colorText: colorRed, backgroundColor: colorWhite);
      isLoading = false;
      update();
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  void disposetext() {
    usernameController.clear();
    emailcontroller.clear();
    passwordcontroller.clear();
    conformpasswordcontroller.clear();
  }

  String? usernameValidation(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter the username';
    } else if (value.length < 2) {
      return 'Too short username';
    } else {
      return null;
    }
  }

  String? emailValdation(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    } else if (!RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(value)) {
      return 'Invalid email , please enter correct email';
    } else {
      return null;
    }
  }

  String? passwordValdation(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    } else if (value.length < 8) {
      return 'Password must have atleast 8 character';
    } else if (value.length > 10) {
      return 'Password exceeds 8 character';
    }
    return null;
  }

  String? confirmpasswordValdation(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    } else if (value.length < 8) {
      return 'Password must have atleast 8 character';
    } else if (value != passwordcontroller.text) {
      return 'Password does not match';
    } else {
      return null;
    }
  }

  bool obscureText = true;
  Icon icon = const Icon(
    Icons.visibility_off,
    color: colorWhite,
  );

  void visibility() {
    if (obscureText == false) {
      icon = const Icon(
        Icons.visibility_off,
        color: colorWhite,
      );
      obscureText = true;
      update();
    } else {
      icon = const Icon(
        Icons.visibility,
        color: colorWhite,
      );
      obscureText = false;
      update();
    }
  }
}
