import 'package:flutter/material.dart';

class MainDialog extends StatefulWidget {
  MainDialog(
      {Key? key,
      required this.parentContext,
      required this.title,
      required this.listData})
      : super(key: key);

  final BuildContext parentContext;
  List<String> listData;
  final String title;

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
    return SizedBox(
      width: 300,
      height: 270,
      child: Column(
        children: <Widget>[
          const SizedBox(
            height: 70,
            child: Center(
              child: Text(
                'Add Task',
                style: TextStyle(color: Colors.black, fontSize: 20),
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
                              return '${widget.title} harus diisi';
                            }
                            if (checkValue(value)) {
                              return '${widget.title} telah diisi sebelumnya';
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
                                if (isValid) {
                                  print(textEditingController.text);
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
