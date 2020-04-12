import 'package:flutter/cupertino.dart';
import 'package:Reminder/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:Reminder/record.dart';
import 'package:jiffy/jiffy.dart';
import 'package:Reminder/Components/clock.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Widget ReminderCard(Record record, BuildContext context) {
  return Dismissible(
    key: Key(record.reference.documentID),
    child: Container(
      padding: EdgeInsets.only(
        top: 24,
        bottom: 32,
        left: 32,
        right: 32,
      ),
      margin: EdgeInsets.only(bottom: 32),
      height: SizeConfig.verticalBlockSize * 60,
      decoration: BoxDecoration(
        color: Color.fromRGBO(42, 42, 42, 1),
        borderRadius: BorderRadius.all(Radius.circular(32)),
      ),
      child: Column(
        children: <Widget>[
          Text(
            "Personal",
            style: questrialStyle.copyWith(
              fontSize: SizeConfig.horizontalBlockSize * 4.5,
              color: Color.fromRGBO(255, 255, 255, 0.4),
            ),
          ),
          Clock(record.startTime.toDate(), record.endTime.toDate()),
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
