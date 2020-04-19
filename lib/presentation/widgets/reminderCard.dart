import 'package:Reminder/data/models/record.dart';
import 'package:flutter/cupertino.dart';
import 'package:Reminder/utils/constants.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:jiffy/jiffy.dart';
import 'package:Reminder/presentation/widgets/clock.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ReminderCard extends StatefulWidget {
  final Record record;

  const ReminderCard({Key key, this.record}):super(key: key);

  @override
  ReminderCardState createState() => ReminderCardState();
}

class ReminderCardState extends State<ReminderCard> {
  Timer t;
  String timing = "";

  @override
  void initState() {
    super.initState();
    t = Timer.periodic(Duration(milliseconds: 50), (Timer r){
      setState(() {
        if(DateTime.now().isBefore(widget.record.startTime.toDate())){
          timing = Jiffy(widget.record.startTime.toDate()).fromNow();
        }
        else if(DateTime.now().isBefore(widget.record.endTime.toDate())){
          timing = "Ends " + Jiffy(widget.record.endTime.toDate()).fromNow();
        }
        else if(DateTime.now().isAfter(widget.record.endTime.toDate())){
          timing = "Ended";
          t.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    t.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(widget.record.reference.documentID),
      child: Container(
        padding: cardPadding,
        margin: EdgeInsets.only(bottom: 32),
        height: SizeConfig.verticalBlockSize * 60,
        decoration: cardDecoration,
        child: Column(
          children: <Widget>[
            Text(
              "Personal",
              style: questrialStyle.copyWith(
                fontSize: SizeConfig.horizontalBlockSize * 5,
                color: Color.fromRGBO(255, 255, 255, 0.4),
              ),
            ),
            Clock(widget.record.startTime.toDate(),
                widget.record.endTime.toDate()),
            Text(
              widget.record.subject,
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
              timing,
//              "Starts " + dateFormat.format(widget.record.startTime.toDate()),
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
              .document(widget.record.reference.documentID)
              .delete();
        } catch (e) {
          print(e.toString());
        }
//        Firestore.instance.runTransaction(
//          (Transaction delTransaction) async {
//            await delTransaction.delete(Firestore.instance
//                .collection('Reminders')
//                .document(widget.record.reference.documentID));
//          },
//        );
      },
    );
  }
}
