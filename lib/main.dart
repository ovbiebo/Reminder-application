import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vsfluttertest/utils/constants.dart';
import 'package:vsfluttertest/pages/add.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jiffy/jiffy.dart';
import 'package:flare_flutter/flare_actor.dart';
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
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Color.fromRGBO(22, 22, 22, 1),
        title: Text(
          "   Reminders",
          style: questrialStyle.copyWith(
            fontSize: SizeConfig.horizontalBlockSize * 6.6,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {},
          ),
//          IconButton(
//            icon: Icon(Icons.search),
//            onPressed: () {},
//          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddPage()),
              );
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

    return Dismissible(
      key: Key(record.reference.documentID),
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
              child: FlareActor(
                "assets/ReminderTimer.flr",
                alignment: Alignment.center,
                fit: BoxFit.contain,
                color: Colors.green,
                animation: "idle",
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
              Jiffy(record.startTime.toDate()).fromNow(),
//              "Starts " + dateFormat.format(record.startTime.toDate()),
              style: questrialStyle.copyWith(
                fontSize: SizeConfig.horizontalBlockSize * 5,
                color: Color.fromRGBO(255, 255, 255, 0.4),
              ),
            ),
          ],
        ),
      ),
      onDismissed: (direction) {
        try {
          Firestore.instance
              .collection('Reminders')
              .document(record.reference.documentID)
              .delete();
        } catch (e) {
          print(e.toString());
        }
//        Firestore.instance.runTransaction(
//          (Transaction delTransaction) async {
//            await delTransaction.delete(Firestore.instance
//                .collection('Reminders')
//                .document(record.reference.documentID));
//          },
//        );
        Scaffold.of(context)
            .showSnackBar(SnackBar(content: Text("Reminder deleted.")));
      },
    );
  }
}

class Record {
  final String subject;
  final Timestamp startTime;
  final Timestamp endTime;
  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['Subject'] != null),
        assert(map['Start'] != null),
        assert(map['End'] != null),
        subject = map['Subject'],
        startTime = map['Start'],
        endTime = map['End'];

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Record<$subject:$startTime:$endTime>";
}
