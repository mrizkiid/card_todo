// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserAdapter extends TypeAdapter<User> {
  @override
  final int typeId = 0;

  @override
  User read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return User(
      userId: fields[0] as String,
      listTask: (fields[1] as List).cast<ListTitle>(),
    );
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.userId)
      ..writeByte(1)
      ..write(obj.listTask);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ListTitleAdapter extends TypeAdapter<ListTitle> {
  @override
  final int typeId = 1;

  @override
  ListTitle read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ListTitle(
      title: fields[0] as String,
      listTitle: (fields[1] as List).cast<ListTask>(),
    );
  }

  @override
  void write(BinaryWriter writer, ListTitle obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.listTitle);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ListTitleAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ListTaskAdapter extends TypeAdapter<ListTask> {
  @override
  final int typeId = 2;

  @override
  ListTask read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ListTask(
      isChecked: fields[0] as bool,
      title: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ListTask obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.isChecked)
      ..writeByte(1)
      ..write(obj.title);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ListTaskAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
