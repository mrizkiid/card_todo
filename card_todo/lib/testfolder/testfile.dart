import 'package:card_todo/testfolder/hive/modelketiga/modelketiga.dart';
import 'package:card_todo/testfolder/services.dart';
import 'package:flutter/material.dart';

class TestPageFolder extends StatefulWidget {
  const TestPageFolder({super.key});

  @override
  State<TestPageFolder> createState() => _TestPageFolderState();
}

class _TestPageFolderState extends State<TestPageFolder> {
  List user = [];

  bool isPressed = false;

  RepoData repoData = RepoData();

  List<String> titles = [];
  List<ListTask> tasks = [];

  // @override
  // void initState() {

  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ListView.builder(
            itemCount: titles.length,
            itemBuilder: (context, index) => ListTile(
              leading: Container(
                width: 40,
                height: 40,
                color: Colors.grey,
              ),
              title: Text(titles[index]),
              subtitle: Text(tasks[index].title),
            ),
          ),
          Center(
            child: InkWell(
              onTap: () async {
                await repoData.init();
                repoData.addTodo();
                repoData.initUser('123');
                titles = repoData.getTitle('today');

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
