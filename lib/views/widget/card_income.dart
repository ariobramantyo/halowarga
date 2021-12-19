import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:halowarga/const/colors.dart';

class CardIncome extends StatelessWidget {
  CardIncome(
      {Key? key,
      required this.isIncome,
      required this.title,
      required this.date,
      required this.total,
      required this.income})
      : super(key: key);

  final bool isIncome;
  final String title;
  final String date;
  final String total;
  final String income;

  @override
  Widget build(BuildContext context) {
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
}
