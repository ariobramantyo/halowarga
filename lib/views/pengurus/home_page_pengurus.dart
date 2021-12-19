import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:halowarga/const/colors.dart';
import 'package:halowarga/views/pengurus/detail_tagihan_pengurus.dart';
import 'package:halowarga/views/pengurus/laporan_keuangan_pengurus.dart';
import 'package:halowarga/views/widget/card_pengumuman.dart';

class HomePagePengurus extends StatelessWidget {
  HomePagePengurus({Key? key}) : super(key: key);

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
                      Text(
                        "Carlos",
                        style: TextStyle(
                            color: AppColor.white,
                            fontSize: 24,
                            height: 1,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "Rp.23.000.000",
                        style: TextStyle(
                            color: AppColor.white,
                            fontSize: 17,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Selamat pagi",
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
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColor.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12)),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Pengumuman',
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
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return CardPengumuman();
                      },
                    ),
                  )),
                  Container(
                    height: 70,
                    width: double.infinity,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: Get.mediaQuery.size.width * 2 / 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Halolapor',
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  'Jika terdapat masalah silahkan lapor, kami akan membantu sepenuh hati.',
                                  style: TextStyle(fontSize: 11),
                                )
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              height: 45,
                              width: 45,
                              decoration: BoxDecoration(
                                  color: AppColor.mainColor,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}
