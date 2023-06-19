import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/screen/auth/sign_in/controller/sign_in_contoller.dart';
import 'package:todo_app/screen/auth/sign_up/view/sign_up_view.dart';

import '../../../../core/colors.dart';
import '../../../../core/style.dart';
import '../../../../util/TextFormFieldWidget/text_form_field_widget.dart';
import '../../../../util/auth_head_text/auth_head_text.dart';
import '../../../../util/circular_indicator_widget/circular_indicator_widget.dart';

class ScreenSignIn extends StatelessWidget {
  ScreenSignIn({super.key});
  final formKey = GlobalKey<FormState>();
  double height = Get.height;
  double width = Get.width;
  final signinContoller = Get.put(SignInContoller());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: authbackgroundColor,
      body: SafeArea(
        child: GetBuilder(
            init: signinContoller,
            builder: (controller) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        SizedBox(
                          height: height * 0.1,
                        ),
                        const AuthHeadText(
                          text: 'Login',
                        ),
                        SizedBox(
                          height: height * 0.1,
                        ),
                        TextFormFieldWidget(
                          labelText: 'Email',
                          keyboardType: TextInputType.emailAddress,
                          controller: signinContoller.usernameController,
                          validator: (username) {
                            return signinContoller.usernameValidation(username);
                          },
                        ),
                        kheight20,
                        TextFormFieldWidget(
                          labelText: 'Password',
                          keyboardType: TextInputType.name,
                          controller: signinContoller.passwordContorller,
                          obscureText: signinContoller.obscureText,
                          onPressed: () {
                            signinContoller.visibility();
                          },
                          icon: signinContoller.icon,
                          validator: (password) {
                            return signinContoller.passwordValdation(password);
                          },
                        ),
                        kheight20,
                        Row(
                          children: [
                            Material(
                              color: authbackgroundColor,
                              child: Checkbox(
                                checkColor: authbuttoncolor,
                                fillColor:
                                    MaterialStateProperty.all(colorWhite),
                                value: signinContoller.agree,
                                onChanged: (values) {
                                  signinContoller.onChanged(values);
                                },
                              ),
                            ),
                            const Text(
                              'Remember me',
                              style: TextStyle(
                                color: colorWhite,
                                fontWeight: FontWeight.w400,
                                fontSize: 18,
                              ),
                            ),
                            Expanded(
                              child: TextButton(
                                onPressed: () {
                                  // Navigator.of(context).push(
                                  //   MaterialPageRoute(
                                  //     builder: (context) => ScreenForgotPassword(
                                  //       height: height,
                                  //       width: width,
                                  //     ),
                                  //   ),
                                  // );
                                },
                                child: const Text(
                                  'Forgot Password',
                                  style: TextStyle(
                                    color: authbuttoncolor,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 18,
                                  ),
                                ),
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
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                signinContoller.agree
                                    ? signinContoller.loginUser()
                                    : Get.snackbar(
                                        '',
                                        'Pleas Agree Remember me',
                                        colorText: colorBlack,
                                        backgroundColor: colorWhite,
                                      );
                              }
                            },
                            child: signinContoller.isLoading == true
                                ? const CircularIndicatorWidget()
                                : const Text(
                                    'Login',
                                    style: authButtonTextStyle,
                                  )),
                        SizedBox(
                          height: height * 0.1,
                        ),
                        // const Text(
                        //   'Or Sign in with ',
                        //   style: TextStyle(
                        //     color: colorWhite,
                        //     fontWeight: FontWeight.w500,
                        //     fontSize: 18,
                        //   ),
                        // ),
                        // kheight20,
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     InkWell(
                        //       onTap: () {},
                        //       child: Image(
                        //         width: width * 0.3,
                        //         height: height * 0.1,
                        //         image:
                        //             const AssetImage('assets/images/google_logo.png'),
                        //       ),
                        //     ),
                        //     InkWell(
                        //       onTap: () {},
                        //       child: Image(
                        //         width: width * 0.3,
                        //         height: height * 0.075,
                        //         image: const AssetImage(
                        //             'assets/images/facebook_logo.png'),
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        RichText(
                          text: TextSpan(
                            text: "Don't have an account?",
                            style: const TextStyle(
                                color: colorWhite,
                                fontWeight: FontWeight.w500,
                                fontSize: 16),
                            children: <TextSpan>[
                              TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => Get.to(() => ScreenSignUp()),
                                text: '   Sign Up',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: authbuttoncolor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
