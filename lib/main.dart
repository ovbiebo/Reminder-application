import 'package:Reminder/features/authentication/domain/repositories/i_auth_facade.dart';
import 'package:Reminder/features/authentication/presentation/bloc/bloc.dart';
import 'package:Reminder/features/authentication/presentation/widgets/wrapper_widget.dart';
import 'package:Reminder/injection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:Reminder/presentation/pages/add_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:provider/provider.dart';

void main() {
  configureInjection(Environment.dev);
  runApp(ReminderApp());
}

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
