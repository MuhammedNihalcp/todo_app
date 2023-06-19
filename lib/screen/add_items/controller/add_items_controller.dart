import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todo_app/screen/add_items/model/add_items_model.dart';

class AddItemsContorller extends GetxController {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController agecontroller = TextEditingController();
  TextEditingController descriptioncontroller = TextEditingController();
  TextEditingController qualificationcontroller = TextEditingController();

  @override
  void onInit() {
    getAllDetails();
    refreshDetails();
    super.onInit();
  }

  List<AddItemsModel> userList = [];

  final db = 'itemsDB';

  String image = '';

  void addDetails() async {
    AddItemsModel model = AddItemsModel(
      image: image,
      name: namecontroller.text.trim(),
      age: agecontroller.text.trim(),
      qualification: qualificationcontroller.text.trim(),
      description: descriptioncontroller.text.trim(),
    );
    final box = await Hive.openBox<AddItemsModel>(db);
    box.put(model.id, model);
    update();

    refreshDetails();
    Get.back();
    disposetext();
  }

  Future<List<AddItemsModel>> getAllDetails() async {
    final box = await Hive.openBox<AddItemsModel>(db);
    return Future.value(box.values.toList());
  }

  updateUser(int index, AddItemsModel models) async {
    namecontroller.text = models.name;
    agecontroller.text = models.age;
    qualificationcontroller.text = models.qualification!;
    descriptioncontroller.text = models.description!;
    update();

    // AddItemsModel model = AddItemsModel(
    //   name: namecontroller.text.trim(),
    //   age: agecontroller.text.trim(),
    //   qualification: qualificationcontroller.text.trim(),
    //   description: descriptioncontroller.text.trim(),
    // );
    final box = await Hive.openBox<AddItemsModel>(db);
    box.putAt(index, models);
    update();
    refreshDetails();

    // disposetext();
  }

  deleteUser(String id) async {
    final box = await Hive.openBox<AddItemsModel>(db);
    box.delete(id);
    update();
    refreshDetails();
  }

  void disposetext() {
    namecontroller.clear();
    agecontroller.clear();
    image = '';
    update();
    qualificationcontroller.clear();
    descriptioncontroller.clear();
  }

  refreshDetails() async {
    userList = await getAllDetails();
    update();
  }

  getFromGallery() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      final imageFile = File(pickedFile.path).readAsBytesSync();
      image = base64Encode(imageFile);
      update();
    } else {
      return null;
    }
  }

  getFromCamera() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      final imageFile = File(pickedFile.path).readAsBytesSync();
      image = base64Encode(imageFile);
      update();
    } else {
      return null;
    }
  }

  AddItemsModel findById(String? id) {
    return userList.firstWhere((element) => element.id == id);
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

  String? ageValidation(String? value) {
    if (value == null || value.isEmpty) {
      return 'Plaese enter the age';
    } else if (value == '0') {
      return 'Your age not valid';
    } else if (value.length > 4) {
      return 'Please enter your correct age';
    } else {
      return null;
    }
  }
}
