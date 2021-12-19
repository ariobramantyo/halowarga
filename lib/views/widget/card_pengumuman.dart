import 'package:flutter/cupertino.dart';
import 'package:halowarga/const/colors.dart';

class CardPengumuman extends StatelessWidget {
  const CardPengumuman({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 70,
                width: 70,
                decoration: BoxDecoration(
                    color: AppColor.placeholder,
                    borderRadius: BorderRadius.circular(12)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '20',
                      style: TextStyle(
                          color: AppColor.secondaryText, fontSize: 24),
                    ),
                    Text(
                      'Apr',
                      style: TextStyle(
                          color: AppColor.secondaryText, fontSize: 11),
                    )
                  ],
                ),
              ),
              SizedBox(width: 10),
              Container(
                width: 200,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Lorem Ipsum',
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempo Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempo',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(
                          color: AppColor.secondaryText, fontSize: 11),
                    )
                  ],
                ),
              ),
            ],
          ),
          Text(
            '15.00',
            style: TextStyle(color: AppColor.secondaryText, fontSize: 11),
          )
        ],
      ),
    );
  }
}
