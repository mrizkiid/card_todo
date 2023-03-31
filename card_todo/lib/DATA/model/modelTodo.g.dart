// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'modelTodo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TitleListAdapter extends TypeAdapter<TitleList> {
  @override
  final int typeId = 0;

  @override
  TitleList read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TitleList(
      title: fields[0] as String,
      keyValue: fields[1] as String,
      sumTask: fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, TitleList obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.keyValue)
      ..writeByte(2)
      ..write(obj.sumTask);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TitleListAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class TodoListAdapter extends TypeAdapter<TodoList> {
  @override
  final int typeId = 1;

  @override
  TodoList read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TodoList(
      title: fields[0] as String,
      taskList: (fields[1] as List).cast<TaskList>(),
    );
  }

  @override
  void write(BinaryWriter writer, TodoList obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.taskList);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TodoListAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class TaskListAdapter extends TypeAdapter<TaskList> {
  @override
  final int typeId = 2;

  @override
  TaskList read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TaskList(
      isChecked: fields[0] as bool,
      title: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, TaskList obj) {
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
      other is TaskListAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
