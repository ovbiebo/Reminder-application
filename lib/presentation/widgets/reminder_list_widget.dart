import 'package:Reminder/data/datasources/record_cloud_data_source.dart';
import 'package:Reminder/data/models/record.dart';
import 'package:Reminder/presentation/widgets/reminderCard.dart';
import 'package:Reminder/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

///Created by Demilade Oladugba on 4/19/2020

class RemindersList extends StatefulWidget {
  @override
  RemindersListState createState() {
    return RemindersListState();
  }
}

class RemindersListState extends State<RemindersList> {
  final RecordCloudDataSource recordCloudDataSourceImpl = RecordCloudDataSourceImpl();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: recordCloudDataSourceImpl.getRecords(),
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

    return ReminderCard(record: record);
  }
}