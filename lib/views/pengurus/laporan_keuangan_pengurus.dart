import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:halowarga/const/colors.dart';
import 'package:halowarga/services/firestore_service.dart';
import 'package:halowarga/views/pengurus/add_income_page..dart';
import 'package:halowarga/views/widget/card_income.dart';

class LaporanKeunganPengurus extends StatelessWidget {
  LaporanKeunganPengurus({Key? key}) : super(key: key);

  Widget _button(String title, IconData icon, Color color) {
    return ElevatedButton(
      onPressed: () => Get.to(() =>
          AddIncomePage(type: title == 'Tambah Uang' ? 'income' : 'outcome')),
      child: Row(
        children: [
          Container(
            height: 24,
            decoration: BoxDecoration(shape: BoxShape.circle, color: color),
            child: Icon(icon),
          ),
          SizedBox(width: 10),
          Text(
            title,
            style: TextStyle(fontSize: 11, color: AppColor.black),
          )
        ],
      ),
      style: ElevatedButton.styleFrom(
        fixedSize: Size(150, 56),
        primary: AppColor.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 0,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.mainColor,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 100,
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 20),
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
                          color: AppColor.white,
                          borderRadius: BorderRadius.circular(10)),
                      child:
                          Icon(Icons.arrow_back_ios, color: AppColor.mainColor),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Laporan Keuangan',
                        style: TextStyle(color: AppColor.white, fontSize: 17),
                      ),
                      FutureBuilder<int>(
                        future: FirestoreService.getTotalBalance(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Text(
                              'Rp.${snapshot.data}',
                              style: TextStyle(
                                  color: AppColor.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600),
                            );
                          }
                          return Text(
                            'loading...',
                            style: TextStyle(
                                color: AppColor.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w600),
                          );
                        },
                      )
                    ],
                  ),
                ],
              ),
            ),
            Container(
              height: 200,
              width: 250,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _button('Tambah Uang', Icons.add, AppColor.mainColor),
                  _button('Kurangi Uang', Icons.remove, AppColor.red)
                ],
              ),
            ),
            Expanded(
                child: Container(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
              decoration: BoxDecoration(
                  color: AppColor.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12))),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Detail Keuangan',
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w500),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          'Lihat semua',
                          style: TextStyle(
                              color: AppColor.mainColor,
                              fontSize: 13,
                              fontWeight: FontWeight.w500),
                        ),
                      )
                    ],
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
