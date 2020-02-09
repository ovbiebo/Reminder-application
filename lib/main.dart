import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vsfluttertest/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:timeago/timeago.dart' as timeago;

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
          // Icon(Icons.filter_list),
          // SizedBox(
          //   width: SizeConfig.horizontalBlockSize * 3,
          // ),
          // Icon(Icons.search),
          // SizedBox(
          //   width: SizeConfig.horizontalBlockSize * 3,
          // ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Firestore.instance.collection('Reminders').add({
                "Subject": "Move forward",
                "Time": Timestamp.fromDate(DateTime.now().add(Duration(minutes: 10))),
              });
            },
          ),
          SizedBox(
            width: 32,
          ),
        ],
      ),
      body: StreamBuilder(
        stream: Firestore.instance
            .collection('Reminders')
            .orderBy("Time", descending: false)
            .snapshots(),
        builder: (context, snapshot) {
          SizeConfig().init(context);
          if (!snapshot.hasData) return const Text('Fetching data');
          return ListView.builder(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.only(top: 16, bottom: 16, left: 32, right: 32),
            itemCount: snapshot.data.documents.length * 2,
            itemBuilder: (context, i) {
              if (i.isOdd)
                return Divider(
                  height: SizeConfig.verticalBlockSize * 5,
                );
              final index = i ~/ 2;
              DocumentSnapshot document = snapshot.data.documents[index];
              DateFormat dateFormat = DateFormat("HH:mm");
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
                      document['Subject'],
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
                      dateFormat.format(document['Time'].toDate()),
                      style: questrialStyle.copyWith(
                        fontSize: SizeConfig.horizontalBlockSize * 5,
                        color: Color.fromRGBO(255, 255, 255, 0.4),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
