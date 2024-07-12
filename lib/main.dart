import 'package:flutter/material.dart';
import 'package:medic/userspage.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';


void main() async {
  await Hive.initFlutter();
  await Hive.openBox('UsersBox');
  await Hive.openBox('DetailBox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: UsersPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}