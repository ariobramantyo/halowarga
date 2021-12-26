import 'package:cloud_firestore/cloud_firestore.dart';

class Announcement {
  String title;
  String desc;
  String date;
  String time;

  Announcement({
    required this.title,
    required this.desc,
    required this.date,
    required this.time,
  });

  Map<String, dynamic> toMap() => {
        'title': this.title,
        'desc': this.desc,
        'date': this.date,
        'time': this.time,
      };

  factory Announcement.fromSnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>>? map) {
    return Announcement(
        title: map!['title'],
        desc: map['desc'],
        date: map['date'],
        time: map['time']);
  }
}
