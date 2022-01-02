import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:halowarga/const/colors.dart';
import 'package:halowarga/controller/user_controller.dart';
import 'package:halowarga/model/announce.dart';
import 'package:halowarga/services/firestore_service.dart';
import 'package:halowarga/views/pengurus/add_announce_page.dart';
import 'package:halowarga/views/pengurus/detail_tagihan_pengurus.dart';
import 'package:halowarga/views/pengurus/laporan_keuangan_pengurus.dart';
import 'package:halowarga/views/pengurus/report_page.dart';
import 'package:halowarga/views/widget/card_pengumuman.dart';

class HomePagePengurus extends StatelessWidget {
  HomePagePengurus({Key? key}) : super(key: key);

  final _userController = Get.find<UserController>();

  String _greeting() {
    var hour = DateTime.now().hour;
    if (hour < 10 && hour > 4) {
      return 'Selamat Pagi';
    } else if (hour < 14 && hour >= 10) {
      return 'Selamat Siang';
    } else if (hour < 18 && hour >= 14) {
      return 'Selamat Sore';
    }
    return 'Selamat Malam';
  }

  Widget _menuIcon(Widget nextPage, IconData icon, String title) {
    return GestureDetector(
      onTap: () {
        Get.to(() => nextPage);
      },
      child: Container(
        width: 80,
        child: Column(
          children: [
            Container(
              height: 56,
              width: 56,
              decoration: BoxDecoration(
                  color: AppColor.white,
                  borderRadius: BorderRadius.circular(10)),
              child: Center(
                  child: Icon(
                icon,
                size: 28,
                color: AppColor.mainColor,
              )),
            ),
            SizedBox(height: 10),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: AppColor.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w500),
            )
          ],
        ),
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
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx(() => Text(
                            _userController.loggedUser.value.name != null
                                ? _userController.loggedUser.value.name!
                                    .split(' ')
                                    .first
                                : '',
                            style: TextStyle(
                                color: AppColor.white,
                                fontSize: 24,
                                height: 1,
                                fontWeight: FontWeight.w600),
                          )),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _greeting(),
                        style: TextStyle(
                            color: AppColor.white, fontSize: 11, height: 1),
                      ),
                      Text(
                        "RT 03 Kelurahan Pesalakan",
                        style: TextStyle(color: AppColor.white, fontSize: 11),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _menuIcon(DetailTagihanPengurus(initialTabIndex: 0),
                        Icons.verified_user, 'Tagihan\nKeamanan'),
                    _menuIcon(DetailTagihanPengurus(initialTabIndex: 1),
                        Icons.cleaning_services, 'Tagihan\nKebersihan'),
                    _menuIcon(DetailTagihanPengurus(initialTabIndex: 2),
                        Icons.money, 'Tagihan\nIuran'),
                    _menuIcon(LaporanKeunganPengurus(), Icons.show_chart,
                        'Laporan\nKeuangan')
                  ]),
            ),
            Expanded(
                child: Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: AppColor.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'Pengumuman',
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Expanded(
                      child: Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          child: StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('announcement')
                                .orderBy('date')
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return ListView.builder(
                                  physics: BouncingScrollPhysics(),
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder: (context, index) {
                                    var annnouce = Announcement.fromSnapshot(
                                        snapshot.data!.docs[index]
                                            as QueryDocumentSnapshot<
                                                Map<String, dynamic>>);
                                    return CardPengumuman(
                                      announcement: annnouce,
                                    );
                                  },
                                );
                              }
                              return Center(child: CircularProgressIndicator());
                            },
                          ))),
                  Container(
                      height: 35,
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Buat Pengumuman',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w500)),
                          IconButton(
                              onPressed: () => Get.to(() => AddAnnouncePage()),
                              padding: EdgeInsets.zero,
                              icon: Icon(Icons.arrow_forward_ios,
                                  size: 20, color: AppColor.mainColor))
                        ],
                      )),
                  Divider(),
                  Container(
                      height: 35,
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Lihat Laporan Warga',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w500)),
                          IconButton(
                              onPressed: () => Get.to(() => ReportPage()),
                              padding: EdgeInsets.zero,
                              icon: Icon(Icons.arrow_forward_ios,
                                  size: 20, color: AppColor.mainColor))
                        ],
                      ))
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}
