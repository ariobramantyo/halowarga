import 'package:cloud_firestore/cloud_firestore.dart';

class FinanceReport {
  String title;
  int income;
  int currentTotalBalance;
  String day;
  String month;
  String year;
  String type;
  String timeSubmit;

  FinanceReport({
    required this.title,
    required this.income,
    required this.currentTotalBalance,
    required this.day,
    required this.month,
    required this.year,
    required this.type,
    required this.timeSubmit,
  });

  Map<String, dynamic> toMap() => {
        'title': this.title,
        'income': this.income,
        'currentTotalBalance': this.currentTotalBalance,
        'day': this.day,
        'month': this.month,
        'year': this.year,
        'type': this.type,
        'timeSubmit': this.timeSubmit,
      };

  factory FinanceReport.fromSnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>>? map) {
    return FinanceReport(
      title: map!['title'],
      income: map['income'],
      currentTotalBalance: map['currentTotalBalance'],
      day: map['day'],
      month: map['month'],
      year: map['year'],
      type: map['type'],
      timeSubmit: map['timeSubmit'],
    );
  }
}
