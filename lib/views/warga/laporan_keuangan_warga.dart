import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:halowarga/const/colors.dart';

class LaporanKeuanganWarga extends StatelessWidget {
  LaporanKeuanganWarga({Key? key}) : super(key: key);

  Widget _cardIncome(
      bool isIncome, String title, String date, String total, String income) {
    return Container(
      height: 72,
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 10),
      alignment: Alignment.center,
      child: Row(
        children: [
          Container(
            height: 70,
            width: 70,
            decoration: BoxDecoration(
                color: AppColor.placeholder,
                borderRadius: BorderRadius.circular(12)),
            child: Center(
              child: Container(
                height: 28,
                width: 28,
                decoration: BoxDecoration(
                    color: isIncome ? AppColor.mainColor : AppColor.red,
                    shape: BoxShape.circle),
                child: Icon(
                  isIncome ? Icons.arrow_upward : Icons.arrow_downward,
                  color: AppColor.white,
                  size: 20,
                ),
              ),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: Get.width / 2.1,
                      child: Text(
                        title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            height: 1,
                            fontSize: 13,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Text(
                      isIncome ? '+$income' : '-$income',
                      style: TextStyle(
                          height: 1.1,
                          color: isIncome ? AppColor.mainColor : AppColor.red,
                          fontSize: 11),
                    )
                  ],
                ),
                SizedBox(height: 5),
                Text(
                  date,
                  style: TextStyle(color: AppColor.secondaryText, fontSize: 11),
                ),
                Text(
                  total,
                  style: TextStyle(
                      color: isIncome ? AppColor.mainColor : AppColor.red,
                      fontSize: 17,
                      fontWeight: FontWeight.w500),
                )
              ],
            ),
          )
        ],
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
                            ? _cardIncome(
                                true,
                                'Penerimaan uang Penerimaan uangalalalalalalalal',
                                '29 Apr 2021',
                                'RP.23.450.000',
                                '10.500.000')
                            : _cardIncome(false, 'Bayar uang ronda',
                                '29 Apr 2021', 'RP.23.450.000', '500.000');
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
