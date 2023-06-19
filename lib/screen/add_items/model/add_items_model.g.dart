// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_items_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AddItemsModelAdapter extends TypeAdapter<AddItemsModel> {
  @override
  final int typeId = 1;

  @override
  AddItemsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AddItemsModel(
      image: fields[1] as String?,
      name: fields[2] as String,
      age: fields[3] as String,
      qualification: fields[4] as String?,
      description: fields[5] as String?,
    )..id = fields[0] as String?;
  }

  @override
  void write(BinaryWriter writer, AddItemsModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.image)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.age)
      ..writeByte(4)
      ..write(obj.qualification)
      ..writeByte(5)
      ..write(obj.description);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AddItemsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
