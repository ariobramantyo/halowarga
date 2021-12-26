import 'package:cloud_firestore/cloud_firestore.dart';

class Document {
  String type;
  String name;
  String date;
  String desc;
  String timeSubmit;
  String status;

  Document({
    required this.type,
    required this.name,
    required this.date,
    required this.desc,
    required this.timeSubmit,
    this.status = 'Diproses',
  });

  Map<String, dynamic> toMap() => {
        'type': this.type,
        'name': this.name,
        'date': this.date,
        'desc': this.desc,
        'timeSubmit': this.timeSubmit,
        'status': this.status,
      };

  factory Document.fromSnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>>? map) {
    return Document(
      type: map!['type'],
      name: map['name'],
      date: map['date'],
      desc: map['desc'],
      timeSubmit: map['timeSubmit'],
      status: map['status'],
    );
  }

  factory Document.fromMap(Map<String, dynamic>? map) {
    return Document(
      type: map!['type'],
      name: map['name'],
      date: map['date'],
      desc: map['desc'],
      timeSubmit: map['timeSubmit'],
      status: map['status'],
    );
  }
}
