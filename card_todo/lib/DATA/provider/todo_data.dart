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
    'PROJECT1',
    'RELATIONSHIP',
    'PROJECT2',
    'PROJECT4',
    'PROJECT3',
    'PROJECT5',
    'PROJECT6',
    'PROJECT7',
  ];

  List<TaskList> tasklist = [
    TaskList(isChecked: false, title: 'Pertama'),
    TaskList(isChecked: true, title: 'Kedua'),
    TaskList(isChecked: false, title: 'Ketiga'),
    TaskList(isChecked: false, title: 'Keempat'),
    TaskList(isChecked: true, title: 'Kelima'),
    TaskList(isChecked: true, title: 'Keenam'),
    TaskList(isChecked: false, title: 'Ketujuh'),
  ];

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
