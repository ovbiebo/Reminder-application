import 'package:cloud_firestore/cloud_firestore.dart';

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