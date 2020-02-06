import 'package:flutter/material.dart';
import 'package:vsfluttertest/utils/constants.dart';

void main() => runApp(ReminderApp());

class ReminderApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color.fromRGBO(18, 18, 18, 1),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color.fromRGBO(18, 18, 18, 1),
          title: Text(
            "Reminders",
            style: questrialStyle.copyWith(
              fontSize: 30,
            ),
          ),
          actions: <Widget>[
            Icon(Icons.search),
            SizedBox(
              width: 10,
            ),
            Icon(Icons.add),
            SizedBox(
              width: 10,
            ),
          ],
        ),
        body: ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: 10,
          itemBuilder: (context, index) {
            return Container(
              padding: EdgeInsets.all(32),
              height: 400,
              width: double.infinity,
              margin: EdgeInsets.only(left: 32,right: 32,top: 32),
              decoration: BoxDecoration(
                color: Color.fromRGBO(32, 32, 32, 1),
                borderRadius: BorderRadius.all(Radius.circular(32)),
              ),
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      height: 150,
                      width: 150,
                      margin: EdgeInsets.all(32),
                      decoration: BoxDecoration(
                          color: Colors.green, shape: BoxShape.circle),
                    ),
                  ),
                  Text(
                    "Wake up",
                    style: questrialStyle.copyWith(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Demilade",
                    style: questrialStyle.copyWith(
                      fontSize: 24,
                      color: Color.fromRGBO(255, 255, 255, 0.4),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
