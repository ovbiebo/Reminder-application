import 'package:Reminder/features/authentication/presentation/widgets/wrapper_widget.dart';
import 'package:Reminder/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:Reminder/presentation/pages/add_page.dart';

import 'features/authentication/presentation/pages/sign_in_page.dart';

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
      home: Wrapper(),
      routes: {
        "Add": (context) => AddPage(),
        "Groups": (context) => AddPage(),
        "Credentials": (context) => AddPage()
      },
    );
  }
}
