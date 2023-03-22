// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userkedua.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserKeduaAdapter extends TypeAdapter<UserKedua> {
  @override
  final int typeId = 3;

  @override
  UserKedua read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserKedua(
      userId: fields[0] as String,
      listTitle: (fields[1] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, UserKedua obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.userId)
      ..writeByte(1)
      ..write(obj.listTitle);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserKeduaAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ListTaskKeduaAdapter extends TypeAdapter<ListTaskKedua> {
  @override
  final int typeId = 4;

  @override
  ListTaskKedua read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ListTaskKedua(
      listTitle: fields[0] as String,
      listTask: (fields[1] as List).cast<ListTask>(),
    );
  }

  @override
  void write(BinaryWriter writer, ListTaskKedua obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.listTitle)
      ..writeByte(1)
      ..write(obj.listTask);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ListTaskKeduaAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ListTaskAdapter extends TypeAdapter<ListTask> {
  @override
  final int typeId = 5;

  @override
  ListTask read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ListTask(
      tasks: fields[0] as String,
      checked: fields[1] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, ListTask obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.tasks)
      ..writeByte(1)
      ..write(obj.checked);
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
