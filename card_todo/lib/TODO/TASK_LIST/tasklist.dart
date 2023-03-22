// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

List<taskModel> taskList = [
  taskModel(isPressed: false, title: 'Pertama'),
  taskModel(isPressed: false, title: 'Kedua'),
  taskModel(isPressed: true, title: 'Ketiga'),
  taskModel(isPressed: true, title: 'Keempat'),
  taskModel(isPressed: false, title: 'Kelima'),
  taskModel(isPressed: false, title: 'Keenam'),
];

class taskModel {
  bool isPressed;
  String title;
  taskModel({
    required this.isPressed,
    required this.title,
  });
}
