import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/core/colors.dart';
import 'package:todo_app/core/style.dart';
import 'package:todo_app/screen/add_items/controller/add_items_controller.dart';
import 'package:todo_app/screen/add_items/view/add_items.dart';
import 'package:todo_app/screen/edit_items/view/edit_view.dart';

class ItemsViewPage extends StatelessWidget {
  ItemsViewPage({
    required this.index,
    required this.id,
    super.key,
  });
  int index;
  String id;
  final additemscontroller = Get.put(AddItemsContorller());
  @override
  Widget build(BuildContext context) {
    final findUser = additemscontroller.findById(id);
    return Scaffold(
      backgroundColor: authbackgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: colorBlack,
          ),
        ),
        backgroundColor: authbuttoncolor,
        title: const Text(
          'USERS DETAILS',
          style: TextStyle(color: colorBlack),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Get.to(
                () => ItemsEditScreen(
                  usermodel: findUser,
                  index: index,
                ),
              );
              additemscontroller.updateUser(index, findUser);
            },
            icon: const Icon(
              Icons.edit,
              color: colorBlack,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: GetBuilder(
          init: additemscontroller,
          builder: (controller) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    kheight20,
                    findUser.image == null
                        ? const CircleAvatar(
                            radius: 50,
                            backgroundImage: AssetImage(
                              'assets/images/profile.png',
                            ),
                          )
                        : CircleAvatar(
                            radius: 50,
                            backgroundImage: MemoryImage(
                              const Base64Decoder().convert(
                                findUser.image!,
                              ),
                            ),
                          ),
                    kheight20,
                    Text(
                      'Name : ${findUser.name}',
                      style: const TextStyle(
                        color: colorWhite,
                        fontSize: 20,
                      ),
                    ),
                    kheight20,
                    Text(
                      'Age : ${findUser.age}',
                      style: const TextStyle(
                        color: colorWhite,
                        fontSize: 20,
                      ),
                    ),
                    kheight20,
                    Text(
                      'Qualification : ${findUser.qualification}',
                      style: const TextStyle(
                        color: colorWhite,
                        fontSize: 20,
                      ),
                    ),
                    kheight20,
                    Text(
                      'Description : ${findUser.description}',
                      style: const TextStyle(
                        color: colorWhite,
                        fontSize: 20,
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
