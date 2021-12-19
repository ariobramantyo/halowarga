import 'package:flutter/material.dart';
import 'package:halowarga/const/colors.dart';
import 'package:halowarga/views/widget/list_surat.dart';

class SuratPagePengurus extends StatefulWidget {
  const SuratPagePengurus({Key? key}) : super(key: key);

  @override
  _SuratPagePengurusState createState() => _SuratPagePengurusState();
}

class _SuratPagePengurusState extends State<SuratPagePengurus>
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
              color: AppColor.mainColor,
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Warga',
                    style: TextStyle(
                        color: AppColor.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    'RT 03 Kelurahan Pesalakan',
                    style: TextStyle(color: AppColor.white, fontSize: 11),
                  )
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
                          'Surat Diminta',
                          textAlign: TextAlign.center,
                        )),
                  ),
                  Tab(
                    child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Surat Diserahkan',
                          textAlign: TextAlign.center,
                        )),
                  ),
                ],
              ),
            ),
            Expanded(
                child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              color: AppColor.white,
              child: TabBarView(
                controller: _tabController,
                children: [
                  // tab surat diminta
                  ListSurat(),
                  // tab surat diserahkan
                  ListSurat(),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
