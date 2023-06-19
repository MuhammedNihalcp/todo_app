import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/core/colors.dart';
import 'package:todo_app/screen/add_items/controller/add_items_controller.dart';
import 'package:todo_app/screen/add_items/model/add_items_model.dart';

import '../../../core/style.dart';
import '../../../util/TextFormFieldWidget/text_form_field_widget.dart';

class ItemsEditScreen extends StatelessWidget {
  ItemsEditScreen({
    required this.usermodel,
    required this.index,
    super.key,
  });

  final additemscontroller = Get.put(AddItemsContorller());
  AddItemsModel usermodel;
  int index;
  double width = Get.width;
  double height = Get.height;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: authbackgroundColor,
      body: SafeArea(
        child: GetBuilder(
          init: additemscontroller,
          builder: (controller) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      kheight20,
                      usermodel.image == null
                          ? Stack(
                              children: [
                                const CircleAvatar(
                                  radius: 50,
                                  backgroundImage:
                                      AssetImage('assets/images/profile.png'),
                                ),
                                Positioned(
                                  right: -10,
                                  bottom: -1,
                                  child: IconButton(
                                    onPressed: () {
                                      Get.defaultDialog(
                                        title: 'A photo of you',
                                        middleText:
                                            'Please make sure your photo clearly shows your fase',
                                        confirm: Column(
                                          children: [
                                            ElevatedButton(
                                              style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        authbuttoncolor),
                                                shape:
                                                    MaterialStateProperty.all<
                                                        RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      10,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              onPressed: () {
                                                additemscontroller
                                                    .getFromGallery();
                                              },
                                              child: const Text('Gallery'),
                                            ),
                                            kheight10,
                                            ElevatedButton(
                                              style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        authbuttoncolor),
                                                shape:
                                                    MaterialStateProperty.all<
                                                        RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      10,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              onPressed: () {
                                                additemscontroller
                                                    .getFromCamera();
                                              },
                                              child: const Text('Cemara'),
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                    icon: const Icon(
                                      Icons.camera_alt,
                                      color: colorWhite,
                                    ),
                                  ),
                                )
                              ],
                            )
                          : Stack(
                              children: [
                                CircleAvatar(
                                  radius: 50,
                                  backgroundImage: MemoryImage(
                                    const Base64Decoder()
                                        .convert(additemscontroller.image),
                                  ),
                                ),
                                Positioned(
                                  right: -10,
                                  bottom: -1,
                                  child: IconButton(
                                    onPressed: () {
                                      Get.defaultDialog(
                                        title: 'A photo of you',
                                        middleText:
                                            'Please make sure your photo clearly shows your fase',
                                        confirm: Column(
                                          children: [
                                            ElevatedButton(
                                              style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        authbuttoncolor),
                                                shape:
                                                    MaterialStateProperty.all<
                                                        RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      10,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              onPressed: () {
                                                additemscontroller
                                                    .getFromGallery();
                                              },
                                              child: const Text('Gallery'),
                                            ),
                                            kheight10,
                                            ElevatedButton(
                                              style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        authbuttoncolor),
                                                shape:
                                                    MaterialStateProperty.all<
                                                        RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      10,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              onPressed: () {
                                                additemscontroller
                                                    .getFromCamera();
                                              },
                                              child: const Text('Cemara'),
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                    icon: const Icon(
                                      Icons.camera_alt,
                                      color: colorWhite,
                                    ),
                                  ),
                                )
                              ],
                            ),
                      kheight20,
                      TextFormFieldWidget(
                        labelText: 'Name',
                        keyboardType: TextInputType.name,
                        controller: additemscontroller.namecontroller,
                        validator: (name) {
                          return additemscontroller.usernameValidation(name);
                        },
                      ),
                      kheight20,
                      TextFormFieldWidget(
                        labelText: 'Age',
                        keyboardType: TextInputType.number,
                        controller: additemscontroller.agecontroller,
                        validator: (age) {
                          return additemscontroller.ageValidation(age);
                        },
                      ),
                      kheight20,
                      TextFormFieldWidget(
                        labelText: 'Qualification',
                        keyboardType: TextInputType.name,
                        controller: additemscontroller.qualificationcontroller,
                      ),
                      kheight20,
                      TextFormField(
                        style: const TextStyle(color: colorWhite),
                        controller: additemscontroller.descriptioncontroller,
                        keyboardType: TextInputType.multiline,
                        minLines: 6,
                        maxLines: 10,
                        decoration: InputDecoration(
                          label: const Text(
                            'Who am i',
                            style: TextStyle(
                              color: colorWhite,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: authbuttoncolor),
                              borderRadius: BorderRadius.circular(20)),
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: authbuttoncolor),
                              borderRadius: BorderRadius.circular(20)),
                          disabledBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: authbuttoncolor),
                              borderRadius: BorderRadius.circular(20)),
                          focusedErrorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.red),
                              borderRadius: BorderRadius.circular(20)),
                          errorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.red),
                              borderRadius: BorderRadius.circular(20)),
                        ),
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
                            additemscontroller.updateUser(index, usermodel);
                            Get.back();
                            additemscontroller.disposetext();
                          }
                        },
                        child: const Text(
                          'SAVE',
                          style: authButtonTextStyle,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
