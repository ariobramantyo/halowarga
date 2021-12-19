import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:halowarga/const/colors.dart';
import 'package:halowarga/views/widget/card_income.dart';

class LaporanKeuanganWarga extends StatelessWidget {
  LaporanKeuanganWarga({Key? key}) : super(key: key);

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
                      Text(
                        'Rp.25.000.000',
                        style: TextStyle(
                            color: AppColor.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Container(
              height: 250,
              width: 250,
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
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return index % 2 == 0
                            ? CardIncome(
                                isIncome: true,
                                title: 'Penerimaan uang Penerimaan',
                                date: '29 Apr 2021',
                                total: 'RP.23.450.000',
                                income: '10.500.000')
                            : CardIncome(
                                isIncome: false,
                                title: 'Penerimaan uang Penerimaan',
                                date: '29 Apr 2021',
                                total: 'RP.23.450.000',
                                income: '10.500.000');
                      },
                    ),
                  )),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
