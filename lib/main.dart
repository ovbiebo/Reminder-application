import 'package:Reminder/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:Reminder/presentation/pages/add.dart';

void main() => runApp(ReminderApp());

class ReminderApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Reminder",
      theme: ThemeData(
        primaryColor: Colors.black,
      ),
      home: HomePage(),
      routes: {
        "Add": (context) => AddPage(),
        "Groups": (context) => AddPage(),
        "Credentials": (context) => AddPage(),
      },
    );
  }
}
