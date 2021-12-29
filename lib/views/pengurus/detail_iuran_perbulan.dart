import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:halowarga/const/colors.dart';
import 'package:halowarga/model/financeReport.dart';
import 'package:halowarga/model/user.dart';
import 'package:halowarga/services/firestore_service.dart';
import 'package:intl/intl.dart';

class DetailIuranPerbulan extends StatefulWidget {
  DetailIuranPerbulan(
      {Key? key,
      required this.tabName,
      required this.year,
      required this.month})
      : super(key: key);

  final String tabName;
  final String year;
  final String month;

  @override
  _DetailIuranPerbulanState createState() => _DetailIuranPerbulanState();
}

class _DetailIuranPerbulanState extends State<DetailIuranPerbulan>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, initialIndex: 0, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _addIncome(UserData user) async {
    // ambil total uang kas RT
    try {
      print('ambil total balance');
      final totalBalance = await FirestoreService.getTotalBalance();

      print('buat object FinanceReport');
      final financeReport = FinanceReport(
        title: 'Pembayaran ${widget.tabName}, ' + user.name!.toString(),
        income: 50000,
        currentTotalBalance: totalBalance + 50000,
        day: DateFormat('dd').format(DateTime.now()),
        month: DateFormat('MMM').format(DateTime.now()),
        year: DateFormat('yyyy').format(DateTime.now()),
        type: 'income',
        timeSubmit: DateTime.now().toIso8601String(),
        payerName: user.name!.toString(),
        typeIncome: widget.tabName,
      );

      // print('tambah income ke firestore');
      FirestoreService.addIncome(financeReport, 'income');

      // print('update total balance di firestore');
      FirestoreService.updateTotalBalance(50000);

      // print('tambah catatan pembayran bulanan user');
      FirestoreService.addUserMonthlyPayment(financeReport, user.uid!);
    } catch (e) {
      print(e.toString());
    }
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
              color: AppColor.mainColor,
              child: Row(
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
                  SizedBox(width: 20),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.month,
                        style: TextStyle(
                            color: AppColor.white,
                            fontSize: 17,
                            fontWeight: FontWeight.w500),
                      ),
                      StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('financeReport')
                            .where('month',
                                isEqualTo: widget.month.substring(0, 3))
                            .where('year', isEqualTo: widget.year)
                            .where('typeIncome', isEqualTo: widget.tabName)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Text(
                              '+' +
                                  (snapshot.data!.docs.length * 50000)
                                      .toString(),
                              style: TextStyle(
                                  color: AppColor.white, fontSize: 13),
                            );
                          }
                          return Text(
                            'loading...',
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.w500),
                          );
                        },
                      )
                    ],
                  ),
                ],
              ),
            ),
            Container(
              height: 60,
              width: double.infinity,
              color: AppColor.mainColor,
              padding: EdgeInsets.symmetric(vertical: 10),
              child: TabBar(
                unselectedLabelColor: AppColor.white,
                indicatorSize: TabBarIndicatorSize.label,
                labelColor: AppColor.mainColor,
                labelStyle:
                    TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                indicator: BoxDecoration(
                    color: AppColor.white,
                    borderRadius: BorderRadius.circular(12)),
                controller: _tabController,
                tabs: [
                  Tab(
                    child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Belum Lunas',
                          textAlign: TextAlign.center,
                        )),
                  ),
                  Tab(
                    child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Lunas',
                          textAlign: TextAlign.center,
                        )),
                  ),
                ],
              ),
            ),
            Expanded(
                child: Container(
              color: AppColor.white,
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: TabBarView(
                controller: _tabController,
                children: [
                  // list belum lunas
                  FutureBuilder<List<UserData>>(
                    future: FirestoreService.getListWarga(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        var _listWarga = snapshot.data!;

                        return StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('financeReport')
                              // .where('subFinanceReport', isNull: false)
                              .where('month',
                                  isEqualTo: widget.month.substring(0, 3))
                              .where('year', isEqualTo: widget.year)
                              .where('typeIncome', isEqualTo: widget.tabName)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              print('panjang snapshot ' +
                                  snapshot.data!.docs.length.toString());

                              var listLunas = snapshot.data!.docs
                                  .map((value) => FinanceReport.fromSnapshot(
                                      value as QueryDocumentSnapshot<
                                          Map<String, dynamic>>))
                                  .toList();

                              print('panjang listLunas ' +
                                  listLunas.length.toString());

                              bool isDataExist(String value) {
                                var data = listLunas.where(
                                    (row) => (row.payerName.contains(value)));
                                if (data.length >= 1) {
                                  return false;
                                } else {
                                  return true;
                                }
                              }

                              var data = _listWarga
                                  .where((item) => isDataExist(item.name!))
                                  .toList();

                              return ListView.builder(
                                itemCount: data.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    height: 50,
                                    width: double.infinity,
                                    margin: EdgeInsets.symmetric(vertical: 8),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              height: 47,
                                              width: 47,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: AppColor.placeholder,
                                              ),
                                              child: data[index].imageUrl == ''
                                                  ? Align(
                                                      alignment:
                                                          Alignment.center,
                                                      child: Icon(
                                                        Icons.person,
                                                        size: 30,
                                                        color: AppColor
                                                            .secondaryText,
                                                      ),
                                                    )
                                                  : ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              100),
                                                      child: Image.network(
                                                          data[index]
                                                                  .imageUrl ??
                                                              'https://ppa-feui.com/wp-content/uploads/2013/01/nopict-300x300.png',
                                                          fit: BoxFit.fill),
                                                    ),
                                            ),
                                            SizedBox(width: 10),
                                            Container(
                                              width: Get.width / 2,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    data[index].name!,
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                  SizedBox(height: 2),
                                                  Text(
                                                    data[index].address!,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 2,
                                                    style: TextStyle(
                                                        height: 1,
                                                        color: AppColor
                                                            .secondaryText,
                                                        fontSize: 13),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        OutlinedButton(
                                          onPressed: () async {
                                            print(data[index].uid);
                                            _addIncome(data[index]);
                                          },
                                          style: OutlinedButton.styleFrom(
                                              backgroundColor: AppColor.white,
                                              side: BorderSide(
                                                  color: AppColor.mainColor)),
                                          child: Text('Lunas',
                                              style: TextStyle(
                                                fontSize: 13,
                                                color: AppColor.mainColor,
                                              )),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            }
                            return Center(child: CircularProgressIndicator());
                          },
                        );
                      }
                      return Center(child: CircularProgressIndicator());
                    },
                  ),

                  // list lunas
                  FutureBuilder<List<UserData>>(
                      future: FirestoreService.getListWarga(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          var _listWargaa = snapshot.data!;
                          return StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('financeReport')
                                // .where('subFinanceReport', isNull: false)
                                .where('month',
                                    isEqualTo: widget.month.substring(0, 3))
                                .where('year', isEqualTo: widget.year)
                                .where('typeIncome', isEqualTo: widget.tabName)
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                print('panjang snapshot' +
                                    snapshot.data!.docs.length.toString());

                                var listLunas = snapshot.data!.docs
                                    .map((value) => FinanceReport.fromSnapshot(
                                        value as QueryDocumentSnapshot<
                                            Map<String, dynamic>>))
                                    .toList();

                                print('panjang listLunas' +
                                    listLunas.length.toString());

                                bool isDataExist(String value) {
                                  var data = listLunas.where(
                                      (row) => (row.payerName.contains(value)));
                                  if (data.length >= 1) {
                                    return true;
                                  } else {
                                    return false;
                                  }
                                }

                                var data = _listWargaa
                                    .where((item) => isDataExist(item.name!))
                                    .toList();

                                return ListView.builder(
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      height: 50,
                                      width: double.infinity,
                                      margin: EdgeInsets.symmetric(vertical: 8),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                height: 47,
                                                width: 47,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: AppColor.placeholder,
                                                ),
                                                child: data[index].imageUrl ==
                                                        ''
                                                    ? Align(
                                                        alignment:
                                                            Alignment.center,
                                                        child: Icon(
                                                          Icons.person,
                                                          size: 30,
                                                          color: AppColor
                                                              .secondaryText,
                                                        ),
                                                      )
                                                    : ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(100),
                                                        child: Image.network(
                                                            data[index]
                                                                    .imageUrl ??
                                                                'https://ppa-feui.com/wp-content/uploads/2013/01/nopict-300x300.png',
                                                            fit: BoxFit.fill),
                                                      ),
                                              ),
                                              SizedBox(width: 10),
                                              Container(
                                                width: Get.width / 2,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      data[index].name!,
                                                      style: TextStyle(
                                                          fontSize: 13,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    SizedBox(height: 2),
                                                    Text(
                                                      data[index].address!,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 2,
                                                      style: TextStyle(
                                                          height: 1,
                                                          color: AppColor
                                                              .secondaryText,
                                                          fontSize: 13),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            '+50.000',
                                            style: TextStyle(
                                                fontSize: 13,
                                                color: AppColor.mainColor),
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                );
                              }
                              return Center(child: CircularProgressIndicator());
                            },
                          );
                        }
                        return Center(child: CircularProgressIndicator());
                      }),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
