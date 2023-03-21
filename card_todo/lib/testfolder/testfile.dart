import 'package:flutter/material.dart';

class TestPageFolder extends StatefulWidget {
  const TestPageFolder({super.key});

  @override
  State<TestPageFolder> createState() => _TestPageFolderState();
}

class _TestPageFolderState extends State<TestPageFolder> {
  List user = [];

  bool isPressed = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ListView.builder(
            itemBuilder: (context, index) => ListTile(),
          ),
          Center(
            child: InkWell(
              onTap: () {
                setState(() {
                  isPressed = !isPressed;
                });
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                child: const Center(
                  child: Text('LOAD'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
