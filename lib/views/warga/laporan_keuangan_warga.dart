import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:halowarga/const/colors.dart';
import 'package:halowarga/services/firestore_service.dart';
import 'package:halowarga/views/widget/card_income.dart';
import 'package:intl/intl.dart';

class LaporanKeuanganWarga extends StatelessWidget {
  LaporanKeuanganWarga({Key? key}) : super(key: key);

  final _year = DateFormat('yyyy').format(DateTime.now());
  final _month = DateFormat('MMM').format(DateTime.now());

  int _getTotalValue(List<dynamic> values) {
    var total = 0;
    values.forEach((element) {
      total += element['income'] as int;
    });

    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.placeholder,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 100,
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 20),
              color: AppColor.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Container(
                      height: 45,
                      width: 45,
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                          color: AppColor.mainColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: Icon(Icons.arrow_back_ios, color: AppColor.white),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Laporan Keuangan',
                        style: TextStyle(color: AppColor.black, fontSize: 17),
                      ),
                      FutureBuilder<int>(
                        future: FirestoreService.getTotalBalance(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Text(
                              'Rp.${snapshot.data}',
                              style: TextStyle(
                                  color: AppColor.black,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600),
                            );
                          }
                          return Text(
                            'loading...',
                            style: TextStyle(
                                color: AppColor.black,
                                fontSize: 17,
                                fontWeight: FontWeight.w600),
                          );
                        },
                      )
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 15),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              decoration: BoxDecoration(color: AppColor.white),
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('financeReport')
                    .where('year', isEqualTo: _year)
                    .where('month', isEqualTo: _month)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final income = snapshot.data!.docs
                        .where((element) =>
                            element.id != 'totalBalance' &&
                            element['type'] == 'income')
                        .toList();

                    final outcome = snapshot.data!.docs
                        .where((element) =>
                            element.id != 'totalBalance' &&
                            element['type'] == 'outcome')
                        .toList();
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Laporan Bulan $_month $_year',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                            )),
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Pemasukan', style: TextStyle(fontSize: 17)),
                            Text(
                              _getTotalValue(income).toString(),
                              style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Pengeluaran', style: TextStyle(fontSize: 17)),
                            Text(_getTotalValue(outcome).toString(),
                                style: TextStyle(
                                    fontSize: 17,
                                    color: AppColor.red,
                                    fontWeight: FontWeight.w500))
                          ],
                        ),
                        Divider(
                          color: AppColor.secondaryText,
                          thickness: 1,
                          indent: Get.width / 2,
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                              (_getTotalValue(outcome) + _getTotalValue(income))
                                  .toString(),
                              style: TextStyle(
                                  fontSize: 17,
                                  color: AppColor.black,
                                  fontWeight: FontWeight.w500)),
                        ),
                      ],
                    );
                  }
                  return Center(child: CircularProgressIndicator());
                },
              ),
            ),
            SizedBox(height: 15),
            Expanded(
                child: Container(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
              decoration: BoxDecoration(
                  color: AppColor.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Detail Keuangan',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                  ),
                  Expanded(
                      child: Container(
                          margin: EdgeInsets.only(top: 10),
                          child: StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('financeReport')
                                .orderBy('timeSubmit', descending: true)
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return ListView.builder(
                                  physics: BouncingScrollPhysics(),
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder: (context, index) {
                                    var income = snapshot.data!.docs[index];
                                    return snapshot.data!.docs[index].id !=
                                            'totalBalance'
                                        ? CardIncome(
                                            isIncome:
                                                income['type'] == 'income',
                                            title: income['title'],
                                            date:
                                                '${income['day']} ${income['month']} ${income['year']}',
                                            total:
                                                '${income['currentTotalBalance']}',
                                            income: '${income['income']}')
                                        : Container();
                                  },
                                );
                              }
                              return Center(child: CircularProgressIndicator());
                            },
                          ))),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
