import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:todo_app/screen/auth/sign_in/model/sign_in_model.dart';
import 'package:todo_app/screen/home/view/home_view.dart';

import '../../../../core/colors.dart';

class SignInContoller extends GetxController {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordContorller = TextEditingController();

  bool agree = false;

  bool isLoading = false;
  final auth = FirebaseAuth.instance;

  void onChanged(bool? value) {
    agree = value ?? false;
    update();
  }

  void loginUser() async {
    isLoading = true;
    update();
    SignInModel model = SignInModel(
      username: usernameController.text.trim(),
      password: passwordContorller.text.trim(),
    );
    try {
      log('try keri');
      await auth.signInWithEmailAndPassword(
        email: model.username,
        password: model.password,
      );
      log('login cheythu');
      isLoading = false;
      update();
      Get.offAll(() => ScreenHome());
    } on PlatformException catch (e) {
      Get.snackbar('Error', e.message.toString());
      isLoading = false;
      update();
    } catch (e) {
      Get.snackbar('Error', e.toString());
      isLoading = false;
      update();
    }
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
