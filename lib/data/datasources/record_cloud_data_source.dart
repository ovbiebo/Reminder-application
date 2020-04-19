import 'package:Reminder/data/models/record.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

///Created by Demilade Oladugba on 4/19/2020

abstract class RecordCloudDataSource {
  Future<void> addRecord(Record record);

  Future<void> updateRecord(Record record);

  Future<void> deleteRecord(String id);

  Stream<QuerySnapshot> getRecords();
}

class RecordCloudDataSourceImpl implements RecordCloudDataSource {
  final CollectionReference _recordCollection =
      Firestore.instance.collection('Reminders');

  @override
  Stream<QuerySnapshot> getRecords() {
    return _recordCollection.orderBy("Start", descending: false).snapshots();
  }

  @override
  Future<void> updateRecord(Record record) {
    // TODO: implement updateRecord
    throw UnimplementedError();
  }

  @override
  Future<void> addRecord(Record record) {
    // TODO: implement addRecord
    throw UnimplementedError();
  }

  @override
  Future<void> deleteRecord(String re) {
    // TODO: implement deleteRecord
    throw UnimplementedError();
  }
}
