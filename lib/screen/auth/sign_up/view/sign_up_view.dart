import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:todo_app/screen/auth/sign_in/view/sign_in_view.dart';
import 'package:todo_app/screen/auth/sign_up/controller/sign_up_controller.dart';

import '../../../../core/colors.dart';
import '../../../../core/style.dart';
import '../../../../util/TextFormFieldWidget/text_form_field_widget.dart';
import '../../../../util/auth_head_text/auth_head_text.dart';
import '../../../../util/circular_indicator_widget/circular_indicator_widget.dart';

class ScreenSignUp extends StatelessWidget {
  ScreenSignUp({super.key});
  final formKey = GlobalKey<FormState>();
  double width = Get.width;
  double height = Get.height;
  final signupController = Get.put(SignUpContoller());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: authbackgroundColor,
      body: GetBuilder(
          init: signupController,
          builder: (controller) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Form(
                  key: formKey,
                  child: ListView(
                    children: [
                      SizedBox(
                        height: height * 0.1,
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              Get.back();
                            },
                            icon: const Icon(
                              Icons.arrow_back_ios_new_rounded,
                              color: colorWhite,
                            ),
                          ),
                          kwidth15,
                          const AuthHeadText(text: 'Sign Up'),
                        ],
                      ),
                      SizedBox(
                        height: height * 0.1,
                      ),
                      TextFormFieldWidget(
                        controller: signupController.usernameController,
                        validator: (name) {
                          return signupController.usernameValidation(name);
                        },
                        labelText: 'UserName',
                        keyboardType: TextInputType.name,
                      ),
                      kheight20,
                      TextFormFieldWidget(
                        labelText: 'Email',
                        keyboardType: TextInputType.emailAddress,
                        controller: signupController.emailcontroller,
                        validator: (email) {
                          return signupController.emailValdation(email);
                        },
                      ),
                      kheight20,
                      TextFormFieldWidget(
                        labelText: 'Password',
                        keyboardType: TextInputType.name,
                        controller: signupController.passwordcontroller,
                        obscureText: signupController.obscureText,
                        onPressed: () {
                          signupController.visibility();
                        },
                        icon: signupController.icon,
                        validator: (password) {
                          return signupController.passwordValdation(password);
                        },
                      ),
                      kheight20,
                      TextFormFieldWidget(
                        labelText: 'Conform Password',
                        keyboardType: TextInputType.name,
                        controller: signupController.conformpasswordcontroller,
                        obscureText: signupController.obscureText,
                        validator: (conformpassword) {
                          return signupController
                              .confirmpasswordValdation(conformpassword);
                        },
                      ),
                      kheight20,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Material(
                            color: authbackgroundColor,
                            child: Checkbox(
                              checkColor: authbuttoncolor,
                              fillColor: MaterialStateProperty.all(colorWhite),
                              value: signupController.agree,
                              onChanged: (values) {
                                signupController.onChanged(values);
                              },
                            ),
                          ),
                          RichText(
                            text: const TextSpan(
                              text: 'I have Agree with ',
                              style: TextStyle(
                                  color: colorWhite,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16),
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'privacy',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: authbuttoncolor,
                                  ),
                                ),
                                TextSpan(text: ' and '),
                                TextSpan(
                                  text: 'policy',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: authbuttoncolor,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      kheight20,
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(authbuttoncolor),
                          fixedSize: MaterialStateProperty.all(
                            Size(width * 0.8, height * 0.08),
                          ),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            signupController.agree
                                ? signupController.addUser()
                                : Get.snackbar(
                                    '',
                                    'Please Agree the privacy and policy',
                                    colorText: colorBlack,
                                    backgroundColor: colorWhite,
                                  );
                          }
                        },
                        child: signupController.isLoading == true
                            ? const CircularIndicatorWidget()
                            : const Text(
                                'Sign Up',
                                style: authButtonTextStyle,
                              ),
                      ),
                      SizedBox(
                        height: height * 0.05,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RichText(
                            text: TextSpan(
                              text: 'Already have an account?',
                              style: const TextStyle(
                                  color: colorWhite,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16),
                              children: <TextSpan>[
                                TextSpan(
                                  recognizer: TapGestureRecognizer()
                                    ..onTap =
                                        () => Get.to(() => ScreenSignIn()),
                                  text: '   Sign in',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: authbuttoncolor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
