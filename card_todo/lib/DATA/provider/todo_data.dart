// ignore_for_file: public_member_api_docs, sort_constructors_first
class TodoData {
  List<String> listTask = [
    'todo1',
    'todo2',
    'todo3',
    'todo4',
    'todo5',
    'todo6',
    'todo7',
    'todo8',
    'todo9',
    'todo10',
  ];
  List<String> listTitle = [
    'GYM',
    'PRAY',
    'DIET',
    'WORK',
    'THESIS',
    'RELATIONSHIP'
  ];
  // List<String> listTitle = [
  //   'GYM',
  //   'PRAY',
  //   'DIET',
  //   'WORK',
  //   'THESIS',
  //   'PROJECT1',
  //   'RELATIONSHIP',
  //   'PROJECT2',
  //   'PROJECT4',
  //   'PROJECT3',
  //   'PROJECT5',
  //   'PROJECT6',
  //   'PROJECT7',
  // ];

  List<TitleList> todoList = [
    TitleList(
      title: 'Gym',
      taskList: [
        TaskList(isChecked: false, title: 'Gym Pertama'),
        TaskList(isChecked: true, title: 'Gym Kedua'),
        TaskList(isChecked: false, title: 'Gym Ketiga'),
        TaskList(isChecked: false, title: 'Gym Keempat'),
        TaskList(isChecked: true, title: 'Gym Kelima'),
        TaskList(isChecked: true, title: 'Gym Keenam'),
        TaskList(isChecked: false, title: 'Gym Ketujuh'),
      ],
    ),
    TitleList(
      title: 'Pray',
      taskList: [
        TaskList(isChecked: false, title: 'Pray Pertama'),
        TaskList(isChecked: true, title: 'Pray Kedua'),
        TaskList(isChecked: false, title: 'Pray Ketiga'),
        TaskList(isChecked: false, title: 'Pray Keempat'),
        TaskList(isChecked: true, title: 'Pray Kelima'),
        TaskList(isChecked: true, title: 'Pray Keenam'),
        TaskList(isChecked: false, title: 'Pray Ketujuh'),
      ],
    ),
    TitleList(
      title: 'Diet',
      taskList: [
        TaskList(isChecked: false, title: 'Diet Pertama'),
        TaskList(isChecked: true, title: 'Diet Kedua'),
        TaskList(isChecked: false, title: 'Diet Ketiga'),
        TaskList(isChecked: false, title: 'Diet Keempat'),
        TaskList(isChecked: true, title: 'Diet Kelima'),
        TaskList(isChecked: true, title: 'Diet Keenam'),
        TaskList(isChecked: false, title: 'Diet Ketujuh'),
      ],
    ),
    TitleList(
      title: 'Work',
      taskList: [
        TaskList(isChecked: false, title: 'Work Pertama'),
        TaskList(isChecked: true, title: 'Work Kedua'),
        TaskList(isChecked: false, title: 'Work Ketiga'),
        TaskList(isChecked: false, title: 'Work Keempat'),
        TaskList(isChecked: true, title: 'Work Kelima'),
        TaskList(isChecked: true, title: 'Work Keenam'),
        TaskList(isChecked: false, title: 'Work Ketujuh'),
      ],
    ),
    TitleList(
      title: 'Thesis',
      taskList: [
        TaskList(isChecked: false, title: 'Thesis Pertama'),
        TaskList(isChecked: true, title: 'Thesis Kedua'),
        TaskList(isChecked: false, title: 'Thesis Ketiga'),
        TaskList(isChecked: false, title: 'Thesis Keempat'),
        TaskList(isChecked: true, title: 'Thesis Kelima'),
        TaskList(isChecked: true, title: 'Thesis Keenam'),
        TaskList(isChecked: false, title: 'Thesis Ketujuh'),
      ],
    ),
    TitleList(
      title: 'Relationship',
      taskList: [
        TaskList(isChecked: false, title: 'Relationship Pertama'),
        TaskList(isChecked: true, title: 'Relationship Kedua'),
        TaskList(isChecked: false, title: 'Relationship Ketiga'),
        TaskList(isChecked: false, title: 'Relationship Keempat'),
        TaskList(isChecked: true, title: 'Relationship Kelima'),
        TaskList(isChecked: true, title: 'Relationship Keenam'),
        TaskList(isChecked: false, title: 'Relationship Ketujuh'),
      ],
    ),
  ];

  List<String> getTitleList() => todoList.map((e) => e.title).toList();

  List<TaskList> getTasklist(String title) =>
      todoList.firstWhere((element) => element.title == title).taskList;

  // List<TaskList> tasklist = [
  //   TaskList(isChecked: false, title: 'Pertama'),
  //   TaskList(isChecked: true, title: 'Kedua'),
  //   TaskList(isChecked: false, title: 'Ketiga'),
  //   TaskList(isChecked: false, title: 'Keempat'),
  //   TaskList(isChecked: true, title: 'Kelima'),
  //   TaskList(isChecked: true, title: 'Keenam'),
  //   TaskList(isChecked: false, title: 'Ketujuh'),
  // ];

  void orderList() {}
}

class TaskList {
  bool isChecked;
  String title;
  TaskList({
    required this.isChecked,
    required this.title,
  });
}

class TitleList {
  String title;
  List<TaskList> taskList;
  TitleList({
    required this.title,
    required this.taskList,
  });
}
