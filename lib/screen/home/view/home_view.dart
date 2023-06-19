import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:get/get.dart';
import 'package:todo_app/core/colors.dart';
import 'package:todo_app/core/style.dart';
import 'package:todo_app/screen/add_items/controller/add_items_controller.dart';
import 'package:todo_app/screen/add_items/view/add_items.dart';
import 'package:todo_app/screen/items_view_page/view/items_view.dart';

class ScreenHome extends StatelessWidget {
  ScreenHome({super.key});

  final additemscontroller = Get.put(AddItemsContorller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: authbackgroundColor,
      appBar: AppBar(
        backgroundColor: authbuttoncolor,
        title: const Text(
          'USERS',
          style: TextStyle(color: colorBlack),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => ItemsAddScreen());
            },
            icon: const Icon(
              Icons.add,
              color: colorBlack,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: GetBuilder(
          init: additemscontroller,
          builder: (controller) {
            return additemscontroller.userList.isEmpty
                ? const Center(
                    child: Text(
                      'User is Empty',
                      style: textwhitecolor,
                    ),
                  )
                : ListView.separated(
                    itemBuilder: (context, index) {
                      final userdata = additemscontroller.userList;
                      return Slidable(
                        endActionPane: ActionPane(
                          motion: const DrawerMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (ctx) {
                                Get.defaultDialog(
                                  title: 'Delete',
                                  middleText: '',
                                  confirm: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      ElevatedButton(
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  authbuttoncolor),
                                          shape: MaterialStateProperty.all<
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
                                          Get.back();
                                        },
                                        child: const Text('No'),
                                      ),
                                      ElevatedButton(
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  authbuttoncolor),
                                          shape: MaterialStateProperty.all<
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
                                              .deleteUser(userdata[index].id!);
                                          Get.back();
                                        },
                                        child: const Text('Yes'),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              icon: Icons.delete,
                              label: 'delete',
                            )
                          ],
                        ),
                        child: ListTile(
                          onTap: () {
                            Get.to(
                              () => ItemsViewPage(
                                index: index,
                                id: userdata[index].id!,
                              ),
                            );
                          },
                          leading: userdata[index].image == null
                              ? const CircleAvatar(
                                  radius: 30,
                                  backgroundImage:
                                      AssetImage('assets/images/profile.png'),
                                )
                              : CircleAvatar(
                                  radius: 30,
                                  backgroundImage: MemoryImage(
                                    const Base64Decoder()
                                        .convert(userdata[index].image!),
                                  ),
                                ),
                          title: Text(
                            userdata[index].name,
                            style: textwhitecolor,
                          ),
                          subtitle: Text(
                            userdata[index].age,
                            style: textwhitecolor,
                          ),
                          trailing: userdata[index].image != '' &&
                                  userdata[index].qualification != '' &&
                                  userdata[index].description != ''
                              ? const Icon(
                                  Icons.check_circle_outline_rounded,
                                  color: Colors.green,
                                )
                              : const SizedBox(),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox();
                    },
                    itemCount: additemscontroller.userList.length,
                  );
          },
        ),
      ),
    );
  }
}
