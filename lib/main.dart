import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vsfluttertest/utils/constants.dart';
import 'package:vsfluttertest/pages/add.dart';
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
            onPressed: _pushSaved,
            // () {
            // Firestore.instance.collection('Reminders').add({
            //   "Subject": "Move forward",
            //   "Time": Timestamp.fromDate(
            //       DateTime.now().add(Duration(minutes: 10))),
            //   "From": Timestamp.fromDate(DateTime.now()),
            // });
            // },
          ),
          SizedBox(
            width: 32,
          ),
        ],
      ),
      body: RemindersList(),
    );
  }

  void _pushSaved() {
    Navigator.of(context).push();
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
          .orderBy("Time", descending: false)
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
      padding: EdgeInsets.only(top: 16, bottom: 16, left: 32, right: 32),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final record = Record.fromSnapshot(data);
    DateFormat dateFormat = DateFormat("HH:mm");

    return Dismissible(
      key: Key(record.time.toString()),
      child: Container(
        padding: EdgeInsets.all(32),
        margin: EdgeInsets.only(bottom: 32),
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
                decoration:
                    BoxDecoration(color: Colors.green, shape: BoxShape.circle),
              ),
            ),
            Text(
              record.subject,
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
              dateFormat.format(record.time.toDate()),
              style: questrialStyle.copyWith(
                fontSize: SizeConfig.horizontalBlockSize * 5,
                color: Color.fromRGBO(255, 255, 255, 0.4),
              ),
            ),
          ],
        ),
      ),
      onDismissed: (direction) {
        // Firestore.instance.collection('Reminders').document(record.reference.documentID).delete();
        // setState(() {
        Firestore.instance.runTransaction((Transaction delTransaction) async {
          await delTransaction.delete(Firestore.instance
              .collection('Reminders')
              .document(record.reference.documentID));
        });
        // snapshot.removeAt(index);
        // });
        // setState(() {
        //   Firestore.instance.runTransaction((Transaction delTransaction) async {
        //     await delTransaction.delete(Firestore.instance
        //         .collection('Reminders')
        //         .document(record.reference.documentID));
        //   });
        //   // snapshot.removeAt(index);
        // });
        Scaffold.of(context)
            .showSnackBar(SnackBar(content: Text("Reminder deleted.")));
      },
    );
  }
}

class Record {
  final String subject;
  final Timestamp time;
  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['Subject'] != null),
        assert(map['Time'] != null),
        subject = map['Subject'],
        time = map['Time'];

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Record<$subject:$time>";
}
