import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:halowarga/const/colors.dart';
import 'package:halowarga/views/pengurus/detail_iuran_perbulan.dart';
import 'package:intl/intl.dart';

class DetailTagihanPengurus extends StatefulWidget {
  final int initialTabIndex;

  DetailTagihanPengurus({Key? key, required this.initialTabIndex})
      : super(key: key);

  @override
  _DetailTagihanPengurusState createState() => _DetailTagihanPengurusState();
}

class _DetailTagihanPengurusState extends State<DetailTagihanPengurus>
    with TickerProviderStateMixin {
  late TabController _tabController;

  final List<String> _listMonth = [
    'Januari',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

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

  bool _checkCurrentMonth(String month) {
    return DateFormat('MMM').format(DateTime.now()) == month;
  }

  Widget monthCard(String month, String tabName) {
    return GestureDetector(
      onTap: () => Get.to(() => DetailIuranPerbulan(
            tabName: tabName,
            month: month,
            year: '2021',
          )),
      child: Container(
        height: 100,
        width: 80,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                  color: Colors.black12,
                  blurRadius: 5,
                  spreadRadius: 1,
                  offset: Offset(2, 2))
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              month.substring(0, 3),
              style: TextStyle(
                  color: AppColor.black,
                  fontSize: 17,
                  fontWeight: FontWeight.w500),
            ),
            Container(
              height: 10,
              margin: EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _checkCurrentMonth(month.substring(0, 3))
                      ? AppColor.mainColor
                      : AppColor.white),
            )
          ],
        ),
      ),
    );
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
            Expanded(
                child: Container(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: TabBarView(
                controller: _tabController,
                children: [
                  // tab keamanan
                  ListView(
                    physics: BouncingScrollPhysics(),
                    children: [
                      SizedBox(height: 20),
                      Wrap(
                          spacing: 20,
                          runSpacing: 20,
                          alignment: WrapAlignment.center,
                          children: _listMonth
                              .map<Widget>(
                                  (month) => monthCard(month, 'Keamanan'))
                              .toList()),
                    ],
                  ),
                  // tab kebersihan
                  ListView(
                    physics: BouncingScrollPhysics(),
                    children: [
                      SizedBox(height: 20),
                      Wrap(
                          spacing: 20,
                          runSpacing: 20,
                          alignment: WrapAlignment.center,
                          children: _listMonth
                              .map<Widget>(
                                  (month) => monthCard(month, 'Kebersihan'))
                              .toList()),
                    ],
                  ),
                  // tab iuran bulanab
                  ListView(
                    physics: BouncingScrollPhysics(),
                    children: [
                      SizedBox(height: 20),
                      Wrap(
                          spacing: 20,
                          runSpacing: 20,
                          alignment: WrapAlignment.center,
                          children: _listMonth
                              .map<Widget>(
                                  (month) => monthCard(month, 'Iuran Bulanan'))
                              .toList()),
                    ],
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
