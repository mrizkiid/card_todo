import 'package:card_todo/TODO/main_menu/main_menu_bloc/mainmenu_bloc.dart';
import 'package:card_todo/TODO/task_list/bloc_task/task_menu_bloc.dart';
import 'package:flutter/material.dart';

class MainDialog extends StatefulWidget {
  const MainDialog({
    Key? key,
    required this.parentContext,
    this.mainMenuBloc,
    this.taskMenuBloc,
    required this.listData,
    required this.title,
  }) : super(key: key);

  final BuildContext parentContext;
  final List<String> listData;
  final String title;
  final MainMenuBloc? mainMenuBloc;
  final TaskMenuBloc? taskMenuBloc;

  @override
  State<MainDialog> createState() => _MainDialogState();
}

class _MainDialogState extends State<MainDialog> {
  TextEditingController textEditingController = TextEditingController();

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  bool checkValue(String value) {
    value.toLowerCase();
    bool isContain = widget.listData.contains(value);
    return isContain;
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mainMenuBloc = widget.mainMenuBloc;
    final taskMenuBloc = widget.taskMenuBloc;
    String titleTask = widget.title;
    return SizedBox(
      width: 300,
      height: 270,
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 70,
            child: Center(
              child: Text(
                titleTask,
                style: const TextStyle(color: Colors.black, fontSize: 20),
              ),
            ),
          ),
          Container(
            height: 2,
            color: Colors.black,
          ),
          Flexible(
            fit: FlexFit.tight,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20).copyWith(top: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Form(
                        key: formkey,
                        child: TextFormField(
                          controller: textEditingController,
                          validator: (value) {
                            if (value == null) {
                              return '$titleTask harus diisi';
                            }
                            if (checkValue(value)) {
                              return '$titleTask telah diisi sebelumnya';
                            }

                            return null;
                          },
                          style: const TextStyle(
                              color: Colors.black, fontSize: 18),
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              ),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              ),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            labelText: 'Add what yout want to do',
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            suffix: GestureDetector(
                              onTap: () {
                                textEditingController.clear();
                              },
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 3),
                                child: const Icon(
                                  Icons.close,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          buttonAddDialog(
                              title: 'Cancel',
                              onTap: () {
                                Navigator.of(widget.parentContext).pop();
                                // textEditingController.dispose();
                              }),
                          const SizedBox(
                            width: 8,
                          ),
                          buttonAddDialog(
                              title: 'Save',
                              onTap: () {
                                final isValid =
                                    formkey.currentState!.validate();
                                String text = textEditingController.text;
                                if (isValid) {
                                  if (mainMenuBloc != null) {
                                    mainMenuBloc
                                        .add(MainMenuAddEvent(titleTask: text));
                                  }
                                  if (taskMenuBloc != null) {
                                    taskMenuBloc.add(
                                      TaskAddEvent(
                                        task: text,
                                      ),
                                    );
                                  }
                                  Navigator.of(widget.parentContext).pop();
                                  // textEditingController.dispose();
                                }
                              })
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buttonAddDialog(
      {required String title, bool? isTopHierarcy, void Function()? onTap}) {
    isTopHierarcy ??= false;
    onTap ??= () {
      print('ontap dialog add null');
    };
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        height: 32,
        decoration: const BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(color: Colors.white, fontSize: 15),
          ),
        ),
      ),
    );
  }
}
