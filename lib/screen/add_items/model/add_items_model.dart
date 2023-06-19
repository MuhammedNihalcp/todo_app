import 'package:hive_flutter/hive_flutter.dart';
 part 'add_items_model.g.dart';

@HiveType(typeId: 1)
class AddItemsModel {
  @HiveField(0)
  String? id;
  @HiveField(1)
  String? image;
  @HiveField(2)
  String name;
  @HiveField(3)
  String age;
  @HiveField(4)
  String? qualification;
  @HiveField(5)
  String? description;

  AddItemsModel({
    this.image,
    required this.name,
    required this.age,
    this.qualification,
    this.description,
  }) {
    id = DateTime.now().microsecondsSinceEpoch.toString();
  }
}
