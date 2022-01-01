import 'package:cloud_firestore/cloud_firestore.dart';

class Report {
  String category;
  String title;
  String desc;
  String sender;
  String date;
  String time;

  Report({
    required this.category,
    required this.title,
    required this.desc,
    required this.sender,
    required this.date,
    required this.time,
  });

  Map<String, dynamic> toMap() => {
        'category': this.category,
        'title': this.title,
        'sender': this.sender,
        'desc': this.desc,
        'date': this.date,
        'time': this.time,
      };

  factory Report.fromSnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>>? map) {
    return Report(
        category: map!['category'],
        title: map['title'],
        desc: map['desc'],
        sender: map['sender'],
        date: map['date'],
        time: map['time']);
  }
}
