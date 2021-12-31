import 'package:cloud_firestore/cloud_firestore.dart';

class Document {
  String id;
  String type;
  String name;
  String date;
  String desc;
  String sender;
  String senderId;
  String timeSubmit;
  String status;

  Document({
    required this.id,
    required this.type,
    required this.name,
    required this.date,
    required this.desc,
    required this.sender,
    required this.senderId,
    required this.timeSubmit,
    this.status = 'Diproses',
  });

  Map<String, dynamic> toMap() => {
        'id': this.id,
        'type': this.type,
        'name': this.name,
        'date': this.date,
        'desc': this.desc,
        'sender': this.sender,
        'senderId': this.senderId,
        'timeSubmit': this.timeSubmit,
        'status': this.status,
      };

  factory Document.fromSnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>>? map) {
    return Document(
      id: map!['id'],
      type: map['type'],
      name: map['name'],
      date: map['date'],
      desc: map['desc'],
      sender: map['sender'],
      senderId: map['senderId'],
      timeSubmit: map['timeSubmit'],
      status: map['status'],
    );
  }

  factory Document.fromMap(Map<String, dynamic>? map) {
    return Document(
      id: map!['id'],
      type: map['type'],
      name: map['name'],
      date: map['date'],
      desc: map['desc'],
      sender: map['sender'],
      senderId: map['senderId'],
      timeSubmit: map['timeSubmit'],
      status: map['status'],
    );
  }
}
