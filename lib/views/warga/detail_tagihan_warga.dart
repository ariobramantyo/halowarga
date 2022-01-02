import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:halowarga/const/colors.dart';
import 'package:halowarga/controller/user_controller.dart';
import 'package:halowarga/controller/year_controller.dart';
import 'package:halowarga/model/financeReport.dart';
import 'package:intl/intl.dart';

class DetailTagihanWarga extends StatefulWidget {
  final int initialTabIndex;

  DetailTagihanWarga({Key? key, required this.initialTabIndex})
      : super(key: key);

  @override
  _DetailTagihanWargaState createState() => _DetailTagihanWargaState();
}

class _DetailTagihanWargaState extends State<DetailTagihanWarga>
    with TickerProviderStateMixin {
  late TabController _tabController;

  final _yearController = Get.put(YearController());
  final _userController = Get.find<UserController>();

  final List<String> _listMonth = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];

  bool _isDataExist(String value, List<FinanceReport> list) {
    var data = list.where((row) {
      return row.month == value;
    });
    if (data.length > 0) {
      return true;
    } else {
      return false;
    }
  }

  bool _checkCurrentMonth(String month) {
    return DateFormat('MMM').format(DateTime.now()) == month;
  }

  Widget monthCard(String month, List<FinanceReport> list) {
    return Container(
      height: 100,
      width: 80,
      decoration: BoxDecoration(
          color: _isDataExist(month, list) ? AppColor.mainColor : AppColor.red,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
                color: Colors.black12,
                blurRadius: 5,
                spreadRadius: 1,
                offset: Offset(2, 2))
          ]),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                month,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: AppColor.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 5),
              Icon(
                _isDataExist(month, list)
                    ? Icons.check_circle
                    : Icons.remove_circle,
                color: AppColor.white,
              )
            ],
          ),
          Container(
            height: 10,
            margin: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _checkCurrentMonth(month)
                    ? AppColor.white
                    : Colors.transparent),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
        length: 3, initialIndex: widget.initialTabIndex, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        'Hari ini',
                        style: TextStyle(
                            color: AppColor.secondaryText, fontSize: 17),
                      ),
                      Text(
                        DateFormat('dd MMMM yyyy').format(DateTime.now()),
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w500),
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
                          'Keamanan',
                          textAlign: TextAlign.center,
                        )),
                  ),
                  Tab(
                    child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Kebersihan',
                          textAlign: TextAlign.center,
                        )),
                  ),
                  Tab(
                    child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Bayar Iuran',
                          textAlign: TextAlign.center,
                        )),
                  ),
                ],
              ),
            ),
            Container(
              height: 60,
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 20),
              color: AppColor.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(() => Text(
                        'Tagihan ${_yearController.year.value}',
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w500),
                      )),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () => _yearController.decreaseYear(),
                          padding: EdgeInsets.zero,
                          icon: Icon(Icons.chevron_left)),
                      Obx(
                        () => IconButton(
                            onPressed: () => _yearController.increaseYear(),
                            padding: EdgeInsets.zero,
                            icon: Icon(
                              Icons.chevron_right,
                              color: _yearController.isMaxYear()
                                  ? AppColor.secondaryText
                                  : AppColor.black,
                            )),
                      )
                    ],
                  )
                ],
              ),
            ),
            Expanded(
                child: Container(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: TabBarView(
                controller: _tabController,
                children: [
                  // tab keamanan
                  Obx(
                    () => StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('user')
                          .doc(_userController.loggedUser.value.uid)
                          .collection('monthlyPayment')
                          .where('typeIncome', isEqualTo: 'Keamanan')
                          .where('year',
                              isEqualTo: _yearController.year.toString())
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          var _data1 = snapshot.data!.docs
                              .map<FinanceReport>((e) =>
                                  FinanceReport.fromSnapshot(e
                                      as QueryDocumentSnapshot<
                                          Map<String, dynamic>>))
                              .toList();
                          return ListView(
                            physics: BouncingScrollPhysics(),
                            children: [
                              SizedBox(height: 20),
                              Wrap(
                                  spacing: 20,
                                  runSpacing: 20,
                                  alignment: WrapAlignment.center,
                                  children: _listMonth
                                      .map<Widget>(
                                          (month) => monthCard(month, _data1))
                                      .toList()),
                              SizedBox(height: 20),
                            ],
                          );
                        }
                        return Center(child: CircularProgressIndicator());
                      },
                    ),
                  ),
                  // tab kebersihan
                  Obx(
                    () => StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('user')
                          .doc(_userController.loggedUser.value.uid)
                          .collection('monthlyPayment')
                          .where('typeIncome', isEqualTo: 'Kebersihan')
                          .where('year',
                              isEqualTo: _yearController.year.toString())
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          var _data2 = snapshot.data!.docs
                              .map<FinanceReport>((e) =>
                                  FinanceReport.fromSnapshot(e
                                      as QueryDocumentSnapshot<
                                          Map<String, dynamic>>))
                              .toList();
                          return ListView(
                            physics: BouncingScrollPhysics(),
                            children: [
                              SizedBox(height: 20),
                              Wrap(
                                  spacing: 20,
                                  runSpacing: 20,
                                  alignment: WrapAlignment.center,
                                  children: _listMonth
                                      .map<Widget>(
                                          (month) => monthCard(month, _data2))
                                      .toList()),
                              SizedBox(height: 20),
                            ],
                          );
                        }
                        return Center(child: CircularProgressIndicator());
                      },
                    ),
                  ),
                  // tab iuran bulanab
                  Obx(
                    () => StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('user')
                          .doc(_userController.loggedUser.value.uid)
                          .collection('monthlyPayment')
                          .where('typeIncome', isEqualTo: 'Bayar Iuran')
                          .where('year',
                              isEqualTo: _yearController.year.toString())
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          var _data3 = snapshot.data!.docs
                              .map<FinanceReport>((e) =>
                                  FinanceReport.fromSnapshot(e
                                      as QueryDocumentSnapshot<
                                          Map<String, dynamic>>))
                              .toList();
                          return ListView(
                            physics: BouncingScrollPhysics(),
                            children: [
                              SizedBox(height: 20),
                              Wrap(
                                  spacing: 20,
                                  runSpacing: 20,
                                  alignment: WrapAlignment.center,
                                  children: _listMonth
                                      .map<Widget>(
                                          (month) => monthCard(month, _data3))
                                      .toList()),
                              SizedBox(height: 20),
                            ],
                          );
                        }
                        return Center(child: CircularProgressIndicator());
                      },
                    ),
                  ),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
