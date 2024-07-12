import 'package:flutter/material.dart';

import 'Button.dart';


class DialogBox extends StatelessWidget {
  final controller;
  VoidCallback onCancel;
  VoidCallback onSave;


  DialogBox({super.key,
    required this.controller,
    required this.onCancel,
    required this.onSave

  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AlertDialog(
        backgroundColor: Color(0xff94e1da),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        content: Container(
          height: 160,
          width: 280,
          child: Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SingleChildScrollView(
                  child: TextFormField(
                    maxLines: 1,
                    controller: controller,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Add New Task",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      MyBtn(
                        text: "Cancel",
                        onPressed: onCancel,
                      ),
                      SizedBox(width: 50,),
                      MyBtn(
                        text: "Save",
                        onPressed: onSave,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
