import 'package:flutter/material.dart';
import 'package:vsfluttertest/utils/constants.dart';

void main() => runApp(ReminderApp());

class ReminderApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // SizeConfig().init(context);
      debugShowCheckedModeBanner: false,
      title: "Reminder",
      home: Scaffold(
        backgroundColor: Color.fromRGBO(18, 18, 18, 1),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color.fromRGBO(18, 18, 18, 1),
          title: Text(
            "   Reminders",
            style: questrialStyle.copyWith(
              fontSize: SizeConfig.horizontalBlockSize * 7,
            ),
          ),
          actions: <Widget>[
            Icon(Icons.search),
            SizedBox(
              width: 10,
            ),
            Icon(Icons.add),
            SizedBox(
              width: 32,
            ),
          ],
        ),
        body: ListView.builder(
          physics: BouncingScrollPhysics(),
          padding:  EdgeInsets.all(16),
          itemCount: 10 * 2,
          itemBuilder: (context, index) {
            SizeConfig().init(context);
            if (index.isOdd) return Divider(
              height: 32,
            );
            return Container(
              padding: EdgeInsets.all(32),
              height: SizeConfig.verticalBlockSize * 60,
              decoration: BoxDecoration(
                color: Color.fromRGBO(36, 36, 36, 1),
                borderRadius: BorderRadius.all(Radius.circular(32)),
              ),
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      height: SizeConfig.horizontalBlockSize * 35,
                      width: SizeConfig.horizontalBlockSize * 35,
                      margin: EdgeInsets.all(32),
                      decoration: BoxDecoration(
                          color: Colors.green, shape: BoxShape.circle),
                    ),
                  ),
                  Text(
                    "Wake up",
                    style: questrialStyle.copyWith(
                      fontSize: SizeConfig.horizontalBlockSize * 8,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.horizontalBlockSize * 2,
                  ),
                  Text(
                    "Demilade",
                    style: questrialStyle.copyWith(
                      fontSize: SizeConfig.horizontalBlockSize * 6,
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
