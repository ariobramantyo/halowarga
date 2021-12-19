import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:halowarga/const/colors.dart';

class CardPerson extends StatelessWidget {
  const CardPerson({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 45,
                width: 45,
                decoration: BoxDecoration(
                    color: AppColor.placeholder, shape: BoxShape.circle),
              ),
              SizedBox(width: 10),
              Container(
                width: Get.width / 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Lorem Ipsum',
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'Lorem ipsum dolor sit amet',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(
                          height: 1,
                          color: AppColor.secondaryText,
                          fontSize: 13),
                    )
                  ],
                ),
              ),
            ],
          ),
          Text(
            'warga',
            style: TextStyle(color: AppColor.secondaryText, fontSize: 13),
          )
        ],
      ),
    );
  }
}
