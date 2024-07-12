import 'package:flutter/material.dart';

class MyBtn extends StatelessWidget {
  final String text;
  VoidCallback onPressed;
  MyBtn({super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: Color(0xff43B3AE),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 10,
      height: 50,
      child: Text(text),
    );
  }
}
