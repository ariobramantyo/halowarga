import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:halowarga/const/colors.dart';
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
            Expanded(
                child: Container(
              child: TabBarView(
                controller: _tabController,
                children: [
                  Icon(Icons.shield),
                  Icon(Icons.cleaning_services),
                  Icon(Icons.show_chart)
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
