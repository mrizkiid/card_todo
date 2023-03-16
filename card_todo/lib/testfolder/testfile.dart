import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class TestPageFile extends StatefulWidget {
  TestPageFile({Key? key}) : super(key: key);

  List items = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10'];

  @override
  State<TestPageFile> createState() => _TestPageFileState();
}

class _TestPageFileState extends State<TestPageFile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ReorderableListView.builder(
        
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.all(8),
        itemCount: widget.items.length,
        itemBuilder: (context, index) {
          return Card(
            key: ValueKey(index),
            child: Text('Items $index'),
          );
        },
        onReorder: (int oldIndex, int newIndex) {
          setState(() {
            if (newIndex > oldIndex) {
              newIndex -= 1;
            }
            final item = widget.items.removeAt(oldIndex);
            widget.items.insert(newIndex, item);
          });
        },
      ),
    );
  }
}
