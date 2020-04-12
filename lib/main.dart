import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:Reminder/utils/constants.dart';
import 'package:Reminder/pages/add.dart';
import 'package:Reminder/record.dart';
import 'package:Reminder/Components/reminderCard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
      routes: {
        "Add": (context) => AddPage(),
        "Groups": (context) => AddPage(),
        "Credentials": (context) => AddPage(),
      },
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
        titleSpacing: 0.0,
        backgroundColor: Color.fromRGBO(22, 22, 22, 1),
        title: FlatButton(
          child: Text(
            "   Reminders",
            style: questrialStyle.copyWith(
              fontSize: SizeConfig.horizontalBlockSize * 6.6,
              color: Colors.white,
            ),
          ),
//          onPressed: (){Navigator.of(context).pushNamed("Add");},
        ),
        actions: <Widget>[
//          IconButton(
//            icon: Icon(Icons.filter_list),
//            onPressed: () {},
//          ),
//          IconButton(
//            icon: Icon(Icons.search),
//            onPressed: () {},
//          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed("Add");
            },
          ),
          SizedBox(
            width: SizeConfig.horizontalBlockSize * 5,
          ),
        ],
      ),
      body: RemindersList(),
    );
  }
}

class RemindersList extends StatefulWidget {
  @override
  RemindersListState createState() {
    return RemindersListState();
  }
}

class RemindersListState extends State<RemindersList> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance
          .collection('Reminders')
          .orderBy("Start", descending: false)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();
        return _buildList(context, snapshot.data.documents);
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.only(
        top: 16,
        bottom: 16,
        left: SizeConfig.horizontalBlockSize * 9,
        right: SizeConfig.horizontalBlockSize * 9,
      ),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final record = Record.fromSnapshot(data);
    DateFormat dateFormat = DateFormat("HH:mm");

    return ReminderCard(record, context);
  }
}
