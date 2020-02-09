import 'package:flutter/material.dart';
import 'package:vsfluttertest/utils/constants.dart';

void main() => runApp(ReminderApp());

class ReminderApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Reminder",
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Color.fromRGBO(22, 22, 22, 1),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color.fromRGBO(22, 22, 22, 1),
        title: Text(
          "   Reminders",
          style: questrialStyle.copyWith(
            fontSize: SizeConfig.horizontalBlockSize * 6.6,
          ),
        ),
        actions: <Widget>[
          Icon(Icons.filter_list),
          SizedBox(
            width: SizeConfig.horizontalBlockSize * 3,
          ),
          Icon(Icons.search),
          SizedBox(
            width: SizeConfig.horizontalBlockSize * 3,
          ),
          Icon(Icons.add),
          SizedBox(
            width: 32,
          ),
        ],
      ),
      body: ListView.builder(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.only(top: 16, bottom: 16, left: 32, right: 32),
        itemCount: 10 * 2,
        itemBuilder: (context, index) {
          SizeConfig().init(context);
          if (index.isOdd)
            return Divider(
              height: SizeConfig.verticalBlockSize * 5,
            );
          return Container(
            padding: EdgeInsets.all(32),
            height: SizeConfig.verticalBlockSize * 60,
            decoration: BoxDecoration(
              color: Color.fromRGBO(42, 42, 42, 1),
              borderRadius: BorderRadius.all(Radius.circular(32)),
            ),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Container(
                    height: SizeConfig.horizontalBlockSize * 40,
                    width: SizeConfig.horizontalBlockSize * 40,
                    decoration: BoxDecoration(
                        color: Colors.green, shape: BoxShape.circle),
                  ),
                ),
                Text(
                  "Study",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: questrialStyle.copyWith(
                    fontSize: SizeConfig.horizontalBlockSize * 7,
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
                    fontSize: SizeConfig.horizontalBlockSize * 5,
                    color: Color.fromRGBO(255, 255, 255, 0.4),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
